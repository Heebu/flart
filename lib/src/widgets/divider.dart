import '../../flart.dart';

class Divider extends Widget {
  final double thickness;
  final double? indent;
  final double? endIndent;
  final FlartColor? color;
  final EdgeInsets? margin;
  final Map<String, String>? cssStyle;

  Divider({
    this.thickness = 1.0,
    this.indent,
    this.endIndent,
    this.color,
    this.margin,
    this.cssStyle,
  });

  @override
  String render() {
    final styleMap = <String, String>{
      'height': '${thickness}px',
      'background-color': color?.toString() ?? '#000000',
      'margin-left': '${indent ?? 0}px',
      'margin-right': '${endIndent ?? 0}px',
      if (margin != null) 'margin': margin!.toCss(),
      ...?cssStyle,
    };

    final styleString =
    styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$styleString"></div>';
  }
}
