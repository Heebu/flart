import 'dart:html';
import '../../../flartdart.dart';

/// A widget that animates its size
class AnimatedSize extends Widget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  AnimatedSize({
    required this.child,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
  });

  @override
  String render(BuildContext context) {
    final id = 'animated_size_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;

    return '''
      <div id="$id" style="
        transition: width ${durationMs}ms, height ${durationMs}ms;
        overflow: hidden;
      ">
        ${child.render(context)}
      </div>
    ''';
  }
}
