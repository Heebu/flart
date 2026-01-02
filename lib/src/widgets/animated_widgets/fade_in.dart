import 'dart:html';
import '../../../flart.dart';

/// A widget that fades in its child when it first appears
class FadeIn extends Widget {
  final Widget child;
  final Duration duration;
  final Duration? delay;
  final Curve curve;

  FadeIn({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay,
    this.curve = Curves.ease,
  });

  @override
  String render(BuildContext context) {
    final id = 'fade_in_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;
    final delayMs = delay?.inMilliseconds ?? 0;

    return '''
      <div id="$id" style="
        opacity: 0;
        transition: opacity ${durationMs}ms ${delayMs}ms;
      ">
        ${child.render(context)}
      </div>
      <script>
        (function() {
          const el = document.getElementById('$id');
          if (el) {
            // Trigger animation on next frame
            requestAnimationFrame(() => {
              requestAnimationFrame(() => {
                el.style.opacity = '1';
              });
            });
          }
        })();
      </script>
    ''';
  }
}
