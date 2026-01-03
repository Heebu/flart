import 'dart:html';
import '../../../flartdart.dart';

/// A widget that scales its child
class AnimatedScale extends Widget {
  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  AnimatedScale({
    required this.child,
    required this.scale,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
  });

  @override
  String render(BuildContext context) {
    final id = 'animated_scale_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;

    return '''
      <div id="$id" style="
        transform: scale($scale);
        transform-origin: center;
        transition: transform ${durationMs}ms;
      ">
        ${child.render(context)}
      </div>
    ''';
  }
}
