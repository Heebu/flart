import 'package:web/web.dart' as web;

import '../../../flartdart.dart';

/// Global counter for unique animation IDs (avoids microsecond collisions).
int _animateCounter = 0;

/// Shared stylesheet element for all FDAnimate keyframes.
web.CSSStyleSheet? _sharedAnimationSheet;

/// Tracks which keyframe names have already been injected.
final Set<String> _injectedKeyframes = {};

/// Ensures the shared animation stylesheet exists in the document head.
void _ensureSharedSheet() {
  if (_sharedAnimationSheet != null) return;

  final style = web.HTMLStyleElement()
    ..id = 'flart-animation-sheet';
  web.document.head?.append(style);
  _sharedAnimationSheet = style.sheet;
}

/// A powerful entry animation wrapper.
///
/// Wraps a widget and applies entrance animations (fade, scale, slide)
/// when it first appears in the DOM. All keyframes are injected into a
/// single shared `<style>` element to prevent style tag accumulation.
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
    super.key,
  });

  @override
  String render(BuildContext context) {
    final id = 'animate_${_animateCounter++}';

    final initialOpacity = fadeIn ? '0' : '1';
    final currentScale = scale ?? startScale;
    final initialScale = currentScale != null ? 'scale($currentScale)' : '';
    final initialTranslate = (slideX != null || slideY != null)
        ? 'translate(${slideX ?? 0}px, ${slideY ?? 0}px)'
        : '';

    final initialTransform = '$initialScale $initialTranslate'.trim();

    // Inject the keyframe rule into the shared stylesheet (once per unique animation).
    if (!_injectedKeyframes.contains(id)) {
      _ensureSharedSheet();
      final rule = '''
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
      ''';
      try {
        _sharedAnimationSheet?.insertRule(rule, _sharedAnimationSheet!.cssRules.length);
      } catch (_) {
        // Fallback: if insertRule fails, the animation simply won't play.
      }
      _injectedKeyframes.add(id);
    }

    return '''
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
