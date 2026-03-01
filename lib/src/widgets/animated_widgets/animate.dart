import '../../../flartdart.dart';

/// A powerful entry animation wrapper.
///
/// Wraps a widget and applies entrance animations (fade, scale, slide)
/// when it first appears in the DOM.
class FDAnimate extends Widget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double? slideX;
  final double? slideY;
  final double? startScale;
  final bool fadeIn;
  final String? rawCss;

  const FDAnimate({
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideX,
    this.slideY,
    this.startScale,
    this.fadeIn = true,
    this.rawCss,
    Key? key,
  }) : super(key: key);

  @override
  String render(BuildContext context) {
    final id = 'animate_${DateTime.now().microsecondsSinceEpoch}';

    final initialOpacity = fadeIn ? '0' : '1';
    final initialScale = startScale != null ? 'scale($startScale)' : '';
    final initialTranslate = (slideX != null || slideY != null)
        ? 'translate(${slideX ?? 0}px, ${slideY ?? 0}px)'
        : '';

    final initialTransform = '$initialScale $initialTranslate'.trim();

    return '''
      <div id="$id" style="
        opacity: $initialOpacity;
        transform: $initialTransform;
        transition: opacity ${duration.inMilliseconds}ms ${delay.inMilliseconds}ms ease-out, 
                    transform ${duration.inMilliseconds}ms ${delay.inMilliseconds}ms ease-out;
        ${rawCss ?? ''}
      ">
        ${child.render(context)}
      </div>
      <script>
        (function() {
          const el = document.getElementById('$id');
          if (el) {
            requestAnimationFrame(() => {
              requestAnimationFrame(() => {
                el.style.opacity = '1';
                el.style.transform = 'none';
              });
            });
          }
        })();
      </script>
    ''';
  }
}
