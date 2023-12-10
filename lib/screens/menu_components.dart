import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:turn_it_game/configs/contants.dart';
import 'package:turn_it_game/configs/device_size.dart';
import 'package:turn_it_game/main.dart';
import 'package:turn_it_game/providers/score_provider.dart';
import 'package:turn_it_game/screens/game_screen/game_screen.dart';

class MenuComponents {
  static List<Widget> getMenuWidget(context,
      {required VoidCallback settingsNavigationFnc,
      required VoidCallback playNavigationFnc}) {
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
          child: Image.asset(
            PathContants.image('statistics_btn.png'),
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
          child: Image.asset(
            PathContants.image('info_btn.png'),
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

  static List<Widget> getSettingsWidget() {
    return [
      Center(
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
                      // print(
                      //     " ollectPointAudio.play();${collectPointAudio.playing}");
                      // if (collectPointAudio.playing) {
                      //   await collectPointAudio.stop();
                      // }
                      // print(
                      //     " ollectPointAudio.play()2;${collectPointAudio.playing}");
                      // await collectPointAudio.();
                    },
                    child: Image.asset(
                      PathContants.image('volume_up.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    PathContants.image('volume_down.png'),
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
                    onTap: () {},
                    child: Image.asset(
                      PathContants.image('volume_up.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      PathContants.image('volume_down.png'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    ];
  }

  static Widget gameWidget(bool mounted) {
    Flame.device.setPortrait();
    return GameWidget.controlled(
      gameFactory: MainGame.new,
      overlayBuilderMap: {
        "game-over": (context, MainGame gameRef) {
          return Center(
            child: Transform.translate(
              offset: const Offset(0, -70),
              child: GestureDetector(
                onTap: () async {
                  await gameRef.resetGame;
                  if (mounted) {
                    Provider.of<ScoreProvider>(context, listen: false)
                        .resetScore();
                  }
                  gameRef.resumeEngine();
                  gameRef.overlays.remove('game-over');
                },
                child: Image.asset(
                  PathContants.image('play_btn.png'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
