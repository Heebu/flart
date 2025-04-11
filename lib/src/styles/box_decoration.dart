class BoxDecoration {
  final String? color;
  final String? border;
  final double? borderRadius;

  const BoxDecoration({this.color, this.border, this.borderRadius});

  Map<String, String> toCss() {
    final map = <String, String>{};
    if (color != null) map['background-color'] = color!;
    if (border != null) map['border'] = border!;
    if (borderRadius != null) map['border-radius'] = '${borderRadius}px';
    return map;
  }
}
