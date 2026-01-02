import 'dart:html';
import '../../../flart.dart';

/// A widget that slides its child in and out
class AnimatedSlide extends Widget {
  final Widget child;
  final Offset offset;
  final Duration duration;
  final Curve curve;

  AnimatedSlide({
    required this.child,
    required this.offset,
    required this.duration,
    this.curve = Curves.linear,
  });

  @override
  String render(BuildContext context) {
    final id = 'animated_slide_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;

    // Convert offset to percentage
    final xPercent = offset.dx * 100;
    final yPercent = offset.dy * 100;

    return '''
      <div id="$id" style="
        transform: translate(${xPercent}%, ${yPercent}%);
        transition: transform ${durationMs}ms;
      ">
        ${child.render(context)}
      </div>
    ''';
  }
}

/// Represents a 2D offset
class Offset {
  final double dx;
  final double dy;

  const Offset(this.dx, this.dy);

  static const Offset zero = Offset(0, 0);
}
