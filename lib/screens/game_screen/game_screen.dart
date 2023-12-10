import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:turn_it_game/screens/game_screen/actors/player.dart';
import 'package:turn_it_game/screens/game_screen/objects/circle_background.dart';

class MainGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, LongPressDetector {
  bool isTapRight = true;
  bool isTap = false;
  Stopwatch stopwatch = Stopwatch()..start();

  late CircleBackground circleBackground;
  late Player player;
  @override
  Color backgroundColor() => Colors.transparent;

  Future<void> get resetGame async {
    removeAll([circleBackground, player]);
    initGame();
  }

  initGame() async {
    // debugMode = true;
    stopwatch.reset();
    var circleSize = Vector2.all(size.x * 0.9);
    var circlePosition = size / 2 - Vector2(0, 70);
    var circleAnchor = Anchor.center;
    circleBackground = CircleBackground(
        size: circleSize, position: circlePosition, anchor: circleAnchor);
    player = Player(
      anchor: Anchor.center,
      position: size / 2,
      radius: 10,
      bgSize: size,
    );
    await add(circleBackground);
    add(player);
  }

  @override
  void onLoad() async {
    initGame();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    isTap = true;
    if (event.devicePosition.x < size.x / 2) {
      isTapRight = false;
    } else {
      isTapRight = true;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    isTap = true;
    if (event.devicePosition.x < size.x / 2) {
      isTapRight = false;
    } else {
      isTapRight = true;
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    isTap = false;
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    isTap = false;
  }

  @override
  void update(double dt) {
    if (isTap) {
      if (isTapRight) {
        circleBackground.angle += 3 * dt;
      } else {
        circleBackground.angle -= 3 * dt;
      }
    }

    super.update(dt);
  }
}
