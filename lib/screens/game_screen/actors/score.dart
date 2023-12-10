import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Score extends CircleComponent {
  Score({super.position, super.paint, super.radius});
  @override
  Future<void> onLoad() {
    add(CircleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }
}
