import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef AnimatedContainer = FDAnimatedContainer;

/// A container that gradually changes its values over a period of time.
/// Follows Flutter's [AnimatedContainer] implicit animation specification.
class FDAnimatedContainer extends Widget {
  final Widget? child;
  final double? width;
  final double? height;
  final FlartColor? color;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Curve curve;
  final Duration duration;
  final VoidCallback? onEnd;
  final Clip clipBehavior;

  const FDAnimatedContainer({
    this.child,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.padding,
    this.margin,
    this.alignment,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
    this.clipBehavior = Clip.none,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final curveCss = curve.toCss();

    final styles = <String, String>{
      'box-sizing': 'border-box',
      'transition':
          'width ${durationMs}ms $curveCss, height ${durationMs}ms $curveCss, background-color ${durationMs}ms $curveCss, border ${durationMs}ms $curveCss, border-radius ${durationMs}ms $curveCss, box-shadow ${durationMs}ms $curveCss, padding ${durationMs}ms $curveCss, margin ${durationMs}ms $curveCss, transform ${durationMs}ms $curveCss',
    };

    if (width != null) styles['width'] = '${width}px';
    if (height != null) styles['height'] = '${height}px';

    if (padding != null) styles['padding'] = padding!.toCss();
    if (margin != null) styles['margin'] = margin!.toCss();

    // Decoration & Color
    final effectiveColor = decoration?.color ?? color;
    if (effectiveColor != null) {
      styles['background-color'] = effectiveColor.toString();
    }

    if (decoration != null) {
      final decStyles = decoration!.toCss();
      styles.addAll(decStyles);
    }

    if (alignment != null) {
      styles['display'] = 'flex';
      styles.addAll(alignment!.toCss());
    }

    if (clipBehavior == Clip.hardEdge || clipBehavior == Clip.antiAlias) {
      styles['overflow'] = 'hidden';
    }

    final events = <String, void Function(web.Event)>{};
    if (onEnd != null) {
      events['transitionend'] = (e) => onEnd!();
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      key: key?.toString(),
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: child != null ? [child!.buildNode(context)] : const [],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
