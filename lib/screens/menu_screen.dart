import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:turn_it_game/configs/contants.dart';
import 'package:turn_it_game/configs/device_size.dart';
import 'package:turn_it_game/local_storage/local_storage.dart';
import 'package:turn_it_game/main.dart';
import 'package:turn_it_game/providers/main_app_provider.dart';
import 'package:turn_it_game/screens/menu_components.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with WidgetsBindingObserver {
  ScreenState currentScreenState = ScreenState.menu;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (context.read<MainAppProvider>().musicVolume) {
      if (state == AppLifecycleState.resumed) {
        context.read<MainAppProvider>().playBGMusic();
      } else if (state == AppLifecycleState.paused) {
        context.read<MainAppProvider>().stopBGMusic();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset(
                PathContants.image('bg.png'),
                width: DeviceSize.width(context),
                height: DeviceSize.height(context),
                fit: BoxFit.cover,
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: const Offset(0, 30),
                    child: Text(
                      displayTitle(),
                      style: textStyle,
                    ),
                  )),
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -70),
                  child: SvgPicture.asset(
                    PathContants.image('ellipse.svg'),
                    width: DeviceSize.width(context, partNumber: 9),
                  ),
                ),
              ),
              ...displayBody(),
              currentScreenState == ScreenState.menu
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform.translate(
                        offset: const Offset(0, -50),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentScreenState = ScreenState.menu;
                              });
                            },
                            child: Image.asset(
                                PathContants.image('back_btn.png'))),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  String displayTitle() {
    return switch (currentScreenState) {
      ScreenState.menu => "RECORD ${LocalStorage.getBestScore}",
      ScreenState.playGame => context.watch<MainAppProvider>().textNewBestScore,
      ScreenState.settings => "SETTINGS",
      ScreenState.statistics => "STATISTICS",
      ScreenState.instruction => "INSTRUCTION"
    };
  }

  List<Widget> displayBody() {
    return switch (currentScreenState) {
      ScreenState.menu => [
          ...MenuComponents.getMenuWidget(
            context,
            settingsNavigationFnc: () {
              setState(() {
                currentScreenState = ScreenState.settings;
              });
            },
            playNavigationFnc: () {
              setState(() {
                currentScreenState = ScreenState.playGame;
                Provider.of<MainAppProvider>(context, listen: false).reset();
              });
            },
            infoNavigationFnc: () {
              setState(() {
                currentScreenState = ScreenState.instruction;
              });
            },
            statisticsNavigationFnc: () {
              setState(() {
                currentScreenState = ScreenState.statistics;
              });
            },
          ),
        ],
      ScreenState.playGame => [MenuComponents.gameWidget(mounted)],
      ScreenState.settings => [MenuComponents.getSettingsWidget(context)],
      ScreenState.statistics => [MenuComponents.getStatisticScreen(context)],
      ScreenState.instruction => [MenuComponents.getInfoScreen()]
    };
  }
}

enum ScreenState { menu, settings, statistics, playGame, instruction }
