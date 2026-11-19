import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Shared stylesheet element for all FDAnimate keyframes.
web.CSSStyleSheet? _sharedAnimationSheet;

/// Tracks which keyframe names have already been injected.
final Set<String> _injectedKeyframes = {};

/// Ensures the shared animation stylesheet exists in the document head.
void _ensureSharedSheet() {
  if (_sharedAnimationSheet != null) return;

  final style = web.HTMLStyleElement()..id = 'flart-animation-sheet';
  web.document.head?.append(style);
  _sharedAnimationSheet = style.sheet;

  _injectDefaultKeyframes();
}

void _injectDefaultKeyframes() {
  if (_sharedAnimationSheet == null) return;
  if (!_injectedKeyframes.contains('flart-entrance-anim')) {
    const entranceRule = '''
@keyframes flart-entrance-anim {
  0% {
    opacity: var(--flart-anim-opacity, 1);
    transform: translate(var(--flart-anim-x, 0px), var(--flart-anim-y, 0px)) scale(var(--flart-anim-scale, 1));
  }
  100% {
    opacity: 1;
    transform: translate(0px, 0px) scale(1);
  }
}
''';
    try {
      _sharedAnimationSheet!.insertRule(
          entranceRule, _sharedAnimationSheet!.cssRules.length);
      _injectedKeyframes.add('flart-entrance-anim');
    } catch (_) {}
  }
}

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

  const FDAnimate({
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideX,
    this.slideY,
    this.startScale,
    this.scale,
    this.fadeIn = true,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    _ensureSharedSheet();

    final initialOpacity = fadeIn ? '0' : '1';
    final currentScale = scale ?? startScale ?? 1.0;
    final initialX = slideX ?? 0.0;
    final initialY = slideY ?? 0.0;

    final styles = <String, String>{
      '--flart-anim-opacity': initialOpacity,
      '--flart-anim-x': '${initialX}px',
      '--flart-anim-y': '${initialY}px',
      '--flart-anim-scale': currentScale.toString(),
      'animation':
          'flart-entrance-anim ${duration.inMilliseconds}ms ease-out ${delay.inMilliseconds}ms both',
      'will-change': 'opacity, transform',
    };

    return FlartElementNode(
      'div',
      id: key?.toString(),
      key: key?.toString(),
      styles: styles,
      children: [child.buildNode(context)],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}

/// Convenience slide-in entrance widget.
class SlideIn extends Widget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offsetX;
  final double offsetY;

  const SlideIn({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offsetX = 0.0,
    this.offsetY = 20.0,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return FDAnimate(
      key: key,
      fadeIn: true,
      duration: duration,
      delay: delay,
      slideX: offsetX,
      slideY: offsetY,
      child: child,
    ).buildNode(context);
  }
}

/// Convenience scale-in entrance widget.
class ScaleIn extends Widget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double startScale;

  const ScaleIn({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.startScale = 0.8,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return FDAnimate(
      key: key,
      fadeIn: true,
      duration: duration,
      delay: delay,
      startScale: startScale,
      child: child,
    ).buildNode(context);
  }
}
