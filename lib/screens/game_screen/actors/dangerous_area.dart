import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:turn_it_game/screens/game_screen/game_screen.dart';

enum DangerousAreaType { single, double, tripple }

class DangerousArea extends SpriteComponent with HasGameRef<MainGame> {
  DangerousArea(x, double y,
      {this.dangerousAreaType = DangerousAreaType.single}) {
    this.x = x;
    this.y = y;
  }
  DangerousAreaType dangerousAreaType;

  @override
  void onLoad() async {
    await initSprite();
    position = Vector2(x, y);
    anchor = Anchor.center;

    Vector2 vertex1 = Vector2(-10.0, 20.0);
    Vector2 vertex2 = Vector2(10.0, 20.0);
    Vector2 vertex3 = Vector2(0.0, 0.0);

    add(PolygonHitbox([vertex1, vertex2, vertex3],
        anchor: Anchor.center, position: size / 2));
  }

  initSprite() async {
    switch (dangerousAreaType) {
      case DangerousAreaType.single:
        sprite = await Sprite.load('dangerous_area.png');
        size = Vector2.all(20);
        break;
      case DangerousAreaType.double:
        sprite = await Sprite.load('dangerous_area2.png');
        size = Vector2(40, 20);
        break;
      case DangerousAreaType.tripple:
        sprite = await Sprite.load('dangerous_area3.png');
        size = Vector2(60, 20);
        break;
      default:
    }
  }
}
