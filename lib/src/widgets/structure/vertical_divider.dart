import '../../../flartdart.dart';

typedef VerticalDivider = FDVerticalDivider;

class FDVerticalDivider extends Widget {
  final double thickness;
  final double? width;
  final double? indent;
  final double? endIndent;
  final FlartColor? color;
  final double? height;
  final EdgeInsets? margin;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDVerticalDivider({
    this.thickness = 1.0,
    this.width,
    this.indent,
    this.endIndent,
    this.color,
    this.height,
    this.margin,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final totalWidth = width ?? thickness;
    final sideMargin = (totalWidth - thickness).clamp(0.0, double.infinity) / 2;

    final styleMap = <String, String>{
      'box-sizing': 'border-box',
      'width': '${thickness}px',
      'background-color': color?.toString() ?? theme.dividerColor.toString(),
      'display': 'inline-block',
      'align-self': 'stretch',
      'flex-shrink': '0',
      'min-height': '16px',
      if (height != null) 'height': '${height}px',
      if (sideMargin > 0) ...{
        'margin-left': '${sideMargin}px',
        'margin-right': '${sideMargin}px',
      },
      if (indent != null) 'margin-top': '${indent}px',
      if (endIndent != null) 'margin-bottom': '${endIndent}px',
      if (margin != null) 'margin': margin!.toCss(),
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styleMap[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styleMap,
    );
  }
}
