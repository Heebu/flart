class FontWeight {
  const FontWeight._(this.value);
  final String value;

  static const FontWeight normal = FontWeight._('normal');
  static const FontWeight bold = FontWeight._('bold');
  static const FontWeight w100 = FontWeight._('100');
  static const FontWeight w200 = FontWeight._('200');
  static const FontWeight w300 = FontWeight._('300');
  static const FontWeight w400 = FontWeight._('400');
  static const FontWeight w500 = FontWeight._('500');
  static const FontWeight w600 = FontWeight._('600');
  static const FontWeight w700 = FontWeight._('700');
  static const FontWeight w800 = FontWeight._('800');
  static const FontWeight w900 = FontWeight._('900');

  @override
  String toString() => value;
}

class TextStyle {
  final String? color;
  final double? fontSize;
  final FontWeight? fontWeight;
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
    if (fontWeight != null) styles['font-weight'] = fontWeight!.value;
    if (fontFamily != null) styles['font-family'] = fontFamily!;
    return styles;
  }
}
