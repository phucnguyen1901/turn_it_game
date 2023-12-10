import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:turn_it_game/screens/game_screen/actors/dangerous_area.dart';
import 'package:turn_it_game/screens/game_screen/actors/score.dart';

class CircleBackground extends SpriteComponent {
  CircleBackground({super.size, super.position, super.anchor});

  List<DangerousArea> currentList = [];
  int maxScoreNumber = 3;
  int currentScoreNumber = 1;

  @override
  void onLoad() async {
    sprite = await Sprite.load('ellipse.png');

    add(CircleHitbox(
        collisionType: CollisionType.passive,
        anchor: Anchor.center,
        position: size / 2,
        radius: size.x / 2 - 12));

    createEnemiesAroundCircle(1);
    createScore();
  }

  createMoreScore(time) {
    if (time > 10 && currentScoreNumber == 1) {
      createScore();
      currentScoreNumber++;
    } else if (time > 20 && currentScoreNumber == 2) {
      createScore();
      currentScoreNumber++;
    }
  }

  reCreateDangerousArea(double time) async {
    for (var e in currentList) {
      e.removeFromParent();
    }
    currentList.length = 0;
    await Future.delayed(const Duration(milliseconds: 300));
    createDangerousAreaFollowLevel(time);
  }

  createDangerousAreaFollowLevel(double time) {
    if (time < 10) {
      createEnemiesAroundCircle(2);
    } else if (time > 10 && time < 20) {
      createEnemiesAroundCircle(5, numberCluster: 2);
    } else if (time > 20) {
      createEnemiesAroundCircle(7, numberCluster: 2, isDangerousArea3: true);
    }
  }

  void createEnemiesAroundCircle(int numberDangerousArea,
      {int numberCluster = 0, bool isDangerousArea3 = false}) {
    final List<int> numbersList = List.generate(20, (index) => index + 1);
    final Random random = Random();
    List<int> positions = [];
    numbersList.shuffle(random);

    for (var i = 1; i <= numberDangerousArea; i++) {
      positions.add(numbersList[i]);
    }
    double circleRadius = size.x / 2 * 0.9;

    double angleIncrement = 2 * pi / numberDangerousArea;

    for (int i = 0; i < numberDangerousArea; i++) {
      double angle = positions[i] * angleIncrement;

      double x = circleRadius * cos(angle);
      double y = circleRadius * sin(angle);

      x += size.x / 2;
      y += size.y / 2;

      if (i > numberDangerousArea - numberCluster) {
        final dangerousAreaType = isDangerousArea3
            ? DangerousAreaType.tripple
            : DangerousAreaType.double;
        var cluster = DangerousArea(x, y, dangerousAreaType: dangerousAreaType)
          ..lookAt(size / 2);
        add(cluster);
        currentList.add(cluster);
      } else {
        var dangerousArea = DangerousArea(x, y)..lookAt(size / 2);
        add(dangerousArea);
        currentList.add(dangerousArea);
      }
    }
  }

  void createScore() {
    var randomPoint = getRandomPointInsideCircle();
    add(Score(
        position: randomPoint,
        paint: Paint()..color = Colors.white,
        radius: 5));
  }

  Vector2 getRandomPointInsideCircle() {
    const distanceToEdgeOfCircle = 50;
    double circleRadius = size.x / 2 * 0.9 - distanceToEdgeOfCircle;
    double radius = Random().nextDouble() * circleRadius;

    Vector2 center = size / 2;
    double angle = Random().nextDouble() * 2 * pi;

    double x = center.x + radius * cos(angle);
    double y = center.y + radius * sin(angle);

    return Vector2(x, y);
  }
}
