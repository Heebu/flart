import '../../../flart.dart';

class VerticalDivider extends Widget {
  final double thickness;
  final double? indent;
  final double? endIndent;
  final FlartColor? color;
  final double? height;
  final EdgeInsets? margin;
  final Map<String, String>? cssStyle;

  VerticalDivider({
    this.thickness = 1.0,
    this.indent,
    this.endIndent,
    this.color,
    this.height,
    this.margin,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styleMap = <String, String>{
      'width': '${thickness}px',
      'background-color': color?.toString() ?? '#000000',
      if (height != null) 'height': '${height}px',
      if (indent != null) 'margin-top': '${indent}px',
      if (endIndent != null) 'margin-bottom': '${endIndent}px',
      if (margin != null) 'margin': margin!.toCss(),
      ...?cssStyle,
    };

    final styleString =
    styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$styleString"></div>';
  }


}
