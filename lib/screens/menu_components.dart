import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:turn_it_game/configs/contants.dart';
import 'package:turn_it_game/configs/device_size.dart';
import 'package:turn_it_game/local_storage/local_storage.dart';
import 'package:turn_it_game/providers/main_app_provider.dart';
import 'package:turn_it_game/screens/game_screen/game_screen.dart';

class MenuComponents {
  static List<Widget> getMenuWidget(
    context, {
    required VoidCallback settingsNavigationFnc,
    required VoidCallback playNavigationFnc,
    required VoidCallback infoNavigationFnc,
    required VoidCallback statisticsNavigationFnc,
  }) {
    return [
      Center(
        child: Transform.translate(
          offset: const Offset(0, -70),
          child: SvgPicture.asset(
            PathContants.image('ellipse.svg'),
            width: DeviceSize.width(context, partNumber: 9),
          ),
        ),
      ),
      Center(
        child: Transform.translate(
          offset: const Offset(0, -180),
          child: GestureDetector(
            onTap: statisticsNavigationFnc,
            child: Image.asset(
              PathContants.image('statistics_btn.png'),
            ),
          ),
        ),
      ),
      Center(
        child: Transform.translate(
          offset: const Offset(120, -70),
          child: GestureDetector(
            onTap: settingsNavigationFnc,
            child: Image.asset(
              PathContants.image('setting_btn.png'),
            ),
          ),
        ),
      ),
      Center(
        child: Transform.translate(
          offset: const Offset(-120, -70),
          child: GestureDetector(
            onTap: infoNavigationFnc,
            child: Image.asset(
              PathContants.image('info_btn.png'),
            ),
          ),
        ),
      ),
      Center(
        child: Transform.translate(
          offset: const Offset(0, 30),
          child: GestureDetector(
            onTap: playNavigationFnc,
            child: Image.asset(
              PathContants.image('play_btn.png'),
            ),
          ),
        ),
      )
    ];
  }

  static Widget getSettingsWidget(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("SOUND", style: textStyle.copyWith(color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    context.read<MainAppProvider>().setEffectVolume(true);
                  },
                  child: Image.asset(
                    PathContants.image(
                        context.watch<MainAppProvider>().effectVolume
                            ? 'volume_up.png'
                            : 'volume_up_grey.png'),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    context.read<MainAppProvider>().setEffectVolume(false);
                  },
                  child: Image.asset(
                    PathContants.image(
                        context.watch<MainAppProvider>().effectVolume
                            ? 'volume_down_grey.png'
                            : 'volume_down.png'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text("MUSIC", style: textStyle.copyWith(color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<MainAppProvider>().playBGMusic();
                  },
                  child: Image.asset(
                    PathContants.image(
                        context.watch<MainAppProvider>().musicVolume
                            ? 'volume_up.png'
                            : 'volume_up_grey.png'),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    context.read<MainAppProvider>().stopBGMusic();
                  },
                  child: Image.asset(
                    PathContants.image(
                        context.watch<MainAppProvider>().musicVolume
                            ? 'volume_down_grey.png'
                            : 'volume_down.png'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget gameWidget(bool mounted) {
    Flame.device.setPortrait();
    return GameWidget.controlled(
      gameFactory: MainGame.new,
      overlayBuilderMap: {
        "game-over": (context, MainGame gameRef) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: const Offset(0, -50),
                  child: GestureDetector(
                    onTap: () async {
                      await gameRef.resetGame;
                      if (mounted) {
                        Provider.of<MainAppProvider>(context, listen: false)
                            .reset();
                      }
                      gameRef.resumeEngine();
                      gameRef.overlays.remove('game-over');
                    },
                    child: Image.asset(
                      PathContants.image('play_btn.png'),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 110),
                child: Text(
                  "GAME OVER",
                  style: textStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  static Widget getInfoScreen() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: const Offset(0, -80),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text("TAP LEFT OR RIGHT SIDE TO ROTATE THE CIRCLE",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  static Widget getStatisticScreen(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocalStorage.getBestScore.toString(),
              style: textStyle.copyWith(fontSize: 64, color: Colors.white),
            ),
            Text(
              "BEST SCORE",
              style: textStyle.copyWith(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              LocalStorage.timePlayed.toString(),
              style: textStyle.copyWith(fontSize: 64, color: Colors.white),
            ),
            Text(
              "TIMES PLAYED",
              style: textStyle.copyWith(fontSize: 20, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
