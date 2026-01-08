import '../../../flartdart.dart';

/// A widget that rotates its child
class AnimatedRotation extends Widget {
  final Widget child;
  final double turns;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  AnimatedRotation({
    required this.child,
    required this.turns,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
  });

  @override
  String render(BuildContext context) {
    final id = 'animated_rotation_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;
    final degrees = turns * 360;

    return '''
      <div id="$id" style="
        transform: rotate(${degrees}deg);
        transform-origin: center;
        transition: transform ${durationMs}ms;
      ">
        ${child.render(context)}
      </div>
    ''';
  }
}
