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
  final double? scale; // Alias for startScale
  final bool fadeIn;
  final String? rawCss;

  const FDAnimate({
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideX,
    this.slideY,
    this.startScale,
    this.scale,
    this.fadeIn = true,
    this.rawCss,
    Key? key,
  }) : super(key: key);

  @override
  String render(BuildContext context) {
    final id = 'animate_${DateTime.now().microsecondsSinceEpoch}';

    final initialOpacity = fadeIn ? '0' : '1';
    final currentScale = scale ?? startScale;
    final initialScale = currentScale != null ? 'scale($currentScale)' : '';
    final initialTranslate = (slideX != null || slideY != null)
        ? 'translate(${slideX ?? 0}px, ${slideY ?? 0}px)'
        : '';

    final initialTransform = '$initialScale $initialTranslate'.trim();

    return '''
      <style>
        @keyframes anim_$id {
          0% {
            opacity: $initialOpacity;
            ${initialTransform.isNotEmpty ? 'transform: $initialTransform;' : ''}
          }
          100% {
            opacity: 1;
            transform: none;
          }
        }
      </style>
      <div id="$id" style="
        animation: anim_$id ${duration.inMilliseconds}ms ease-out ${delay.inMilliseconds}ms both;
        will-change: opacity, transform;
        ${rawCss ?? ''}
      ">
        ${child.render(context)}
      </div>
    ''';
  }
}
