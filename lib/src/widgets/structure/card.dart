import '../../../flart.dart';

/// A card widget with elevation and rounded corners
class Card extends Widget {
  final Widget? child;
  final FlartColor? color;
  final double elevation;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Map<String, String>? cssStyle;

  Card({
    this.child,
    this.color,
    this.elevation = 1.0,
    this.margin,
    this.padding,
    this.borderRadius,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final bgColor = color?.toString() ?? '#ffffff';
    final shadowBlur = elevation * 2;
    final shadowSpread = elevation * 0.5;

    final styles = <String, String>{
      'background-color': bgColor,
      'border-radius': borderRadius != null
          ? '${borderRadius!.topLeft}px ${borderRadius!.topRight}px ${borderRadius!.bottomRight}px ${borderRadius!.bottomLeft}px'
          : '4px',
      'box-shadow':
          '0 ${elevation}px ${shadowBlur}px rgba(0,0,0,0.1), 0 ${shadowSpread}px ${elevation * 3}px rgba(0,0,0,0.06)',
      if (margin != null) 'margin': margin!.toCss(),
      if (padding != null) 'padding': padding!.toCss(),
      ...?cssStyle,
    };

    final styleString =
        styles.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$styleString">${child?.render(context) ?? ''}</div>';
  }
}
