import '../../../flartdart.dart';

class FDDivider extends Widget {
  final double thickness;
  final double? indent;
  final double? endIndent;
  final FlartColor? color;
  final EdgeInsets? margin;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDivider({
    this.thickness = 1.0,
    this.indent,
    this.endIndent,
    this.color,
    this.margin,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final styleMap = <String, String>{
      'height': '${thickness}px',
      'width': '100%',
      'background-color': color?.toString() ?? theme.dividerColor.toString(),
      'border': 'none',
      'display': 'block',
      'margin-left': '${indent ?? 0}px',
      'margin-right': '${endIndent ?? 0}px',
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
      'hr',
      id: key?.toString(),
      styles: styleMap,
    );
  }
}
