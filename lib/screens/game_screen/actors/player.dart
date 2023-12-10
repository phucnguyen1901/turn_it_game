import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:provider/provider.dart';
import 'package:turn_it_game/providers/score_provider.dart';
import 'package:turn_it_game/screens/game_screen/actors/dangerous_area.dart';
import 'package:turn_it_game/screens/game_screen/game_screen.dart';
import 'package:flame/components.dart';
import 'package:turn_it_game/screens/game_screen/actors/score.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  Player(
      {super.position,
      super.anchor,
      required this.radius,
      super.paint,
      required this.bgSize});
  late Vector2 velocity;
  double speed = 200;
  final degree = 45 / 180;
  double radius = 0;
  get math => null;

  Vector2 bgSize = Vector2.zero();
  CollisionPosition currentPositon = CollisionPosition.topLeft;

  @override
  void onLoad() async {
    sprite = await Sprite.load('player.png');
    _resetBall;

    final hitBox = CircleHitbox();

    add(hitBox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity.normalized() * speed * dt;
  }

  void get _resetBall {
    size = Vector2.all(20);
    velocity = Vector2(150, 150)..normalized();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    int time = game.stopwatch.elapsedMilliseconds ~/ 1000;

    if (time > 30) {
      speed = 250;
    }
    if (other is Score) {
      other.removeFromParent();
      FlameAudio.play('collect.mp3',
          volume:
              Provider.of<MainAppProvider>(game.buildContext!, listen: false)
                  .effectVolume);
      game.circleBackground.createScore();
      Provider.of<MainAppProvider>(game.buildContext!, listen: false)
          .increaseScore();
    } else if (other is DangerousArea) {
      FlameAudio.play('hit.mp3',
          volume:
              Provider.of<MainAppProvider>(game.buildContext!, listen: false)
                  .effectVolume);
      game.overlays.add('game-over');
      game.pauseEngine();
      Provider.of<MainAppProvider>(game.buildContext!, listen: false)
          .recordBestCore();
    } else {
      game.circleBackground.reCreateDangerousArea((time).toDouble());
      game.circleBackground.createMoreScore(time);
      var number = 0;
      final collisionPoint = intersectionPoints.first;
      var velocityLength = velocity.length;
      if (collisionPoint.x < bgSize.x / 2 && collisionPoint.y < bgSize.y / 2) {
        //top-left
        if (currentPositon == CollisionPosition.topLeft) {
          number = 100;
        } else {
          number = -100;
        }
        velocity = Vector2(-velocity.x + number, -velocity.y)..normalized();
        currentPositon = CollisionPosition.topLeft;
      } else if (collisionPoint.x >= bgSize.x / 2 &&
          collisionPoint.y < bgSize.y / 2) {
        //top-right
        velocity = Vector2(-velocity.x + 80, -velocity.y)..normalized();
        currentPositon = CollisionPosition.topRight;
      } else if (collisionPoint.x < bgSize.x / 2 &&
          collisionPoint.y >= bgSize.y / 2) {
        //bottom-left
        velocity = Vector2(-velocity.x + 80, -velocity.y)..normalized();
        currentPositon = CollisionPosition.bottomLeft;
      } else {
        //bottom-right
        if (currentPositon == CollisionPosition.topLeft) {
          number = 100;
        } else {
          number = -100;
        }
        velocity = Vector2(-velocity.x + number, -velocity.y)..normalized();
        currentPositon = CollisionPosition.bottomRight;
      }
      velocity.length = velocityLength;
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}

enum CollisionPosition { topLeft, topRight, bottomLeft, bottomRight }
