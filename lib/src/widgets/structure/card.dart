import '../../../flartdart.dart';

typedef Card = FDCard;

/// A Material Design card with elevation and rounded corners.
class FDCard extends Widget {
  final Widget? child;
  final FlartColor? color;
  final double elevation;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Border? border;
  final Clip clipBehavior;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDCard({
    this.child,
    this.color,
    this.elevation = 1.0,
    this.margin,
    this.padding,
    this.borderRadius,
    this.border,
    this.clipBehavior = Clip.none,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = color?.toString() ?? theme.cardColor.toString();
    final shadowBlur = elevation * 2;
    final shadowSpread = elevation * 0.5;

    final radius = borderRadius ?? const BorderRadius.all(4.0);

    final styles = <String, String>{
      'box-sizing': 'border-box',
      'background-color': bgColor,
      'transition': 'background-color 0.3s ease, box-shadow 0.3s ease',
      'border-radius': radius.toCss(),
      if (elevation > 0)
        'box-shadow':
            '0 ${elevation}px ${shadowBlur}px rgba(0,0,0,0.1), 0 ${shadowSpread}px ${elevation * 3}px rgba(0,0,0,0.06)'
      else
        'box-shadow': 'none',
      if (border != null) ...border!.toCss(),
      if (clipBehavior != Clip.none) 'overflow': 'hidden',
      if (margin != null) 'margin': margin!.toCss(),
      if (padding != null) 'padding': padding!.toCss(),
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-card'},
      styles: styles,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
