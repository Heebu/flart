class TextStyle {
  final String? color;
  final double? fontSize;
  final String? fontWeight;
  final String? fontFamily;

  const TextStyle({
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
  });

  Map<String, String> toCss() {
    final styles = <String, String>{};
    if (color != null) styles['color'] = color!;
    if (fontSize != null) styles['font-size'] = '${fontSize}px';
    if (fontWeight != null) styles['font-weight'] = fontWeight!;
    if (fontFamily != null) styles['font-family'] = fontFamily!;
    return styles;
  }
}
