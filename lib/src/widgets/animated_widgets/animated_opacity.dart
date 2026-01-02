import '../../../flart.dart';

/// A widget that animates its opacity over time
class AnimatedOpacity extends Widget {
  final Widget child;
  final double opacity;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  AnimatedOpacity({
    required this.child,
    required this.opacity,
    required this.duration,
    this.curve = Curves.linear,
    this.onEnd,
  });

  @override
  String render(BuildContext context) {
    final id = 'animated_opacity_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;

    return '''
      <div id="$id" style="opacity: ${opacity.clamp(0.0, 1.0)}; transition: opacity ${durationMs}ms;">
        ${child.render(context)}
      </div>
      <script>
        (function() {
          const el = document.getElementById('$id');
          if (el) {
            ${onEnd != null ? '''
              el.addEventListener('transitionend', function() {
                // Callback when animation ends
              });
            ''' : ''}
          }
        })();
      </script>
    ''';
  }
}
