import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_it_game/configs/contants.dart';
import 'package:turn_it_game/configs/device_size.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
                      'RECORD 8',
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
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -180),
                  child: Image.asset(
                    PathContants.image('statistics_btn.png'),
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(120, -70),
                  child: Image.asset(
                    PathContants.image('setting_btn.png'),
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(-120, -70),
                  child: Image.asset(
                    PathContants.image('info_btn.png'),
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(0, 30),
                  child: Image.asset(
                    PathContants.image('play_btn.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
