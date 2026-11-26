enum FontStyle {
  normal,
  italic,
}

class TextDecoration {
  final String _value;
  const TextDecoration._(this._value);

  static const TextDecoration none = TextDecoration._('none');
  static const TextDecoration underline = TextDecoration._('underline');
  static const TextDecoration overline = TextDecoration._('overline');
  static const TextDecoration lineThrough = TextDecoration._('line-through');

  static TextDecoration combine(List<TextDecoration> decorations) {
    final values =
        decorations.map((d) => d._value).where((v) => v != 'none').join(' ');
    return TextDecoration._(values.isEmpty ? 'none' : values);
  }

  bool contains(TextDecoration other) {
    if (_value == other._value) return true;
    return _value.split(' ').contains(other._value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextDecoration &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value;
}

enum TextDecorationStyle {
  solid,
  double,
  dotted,
  dashed,
  wavy,
}

enum TextOverflow {
  clip,
  fade,
  ellipsis,
  visible,
}

enum TextBaseline {
  alphabetic,
  ideographic,
}

enum TextDirection {
  ltr,
  rtl,
}

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
  /// The color to use when painting the text. Accepts [String] (hex) or [FlartColor].
  final Object? color;
  final Object? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final Object? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final TextOverflow? overflow;

  const TextStyle({
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.overflow,
  });

  TextStyle copyWith({
    Object? color,
    Object? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? decoration,
    Object? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      fontFamily: fontFamily ?? this.fontFamily,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      overflow: overflow ?? this.overflow,
    );
  }

  Map<String, String> toCss() {
    final styles = <String, String>{};
    if (color != null) {
      styles['color'] = color.toString();
    }
    if (backgroundColor != null) {
      styles['background-color'] = backgroundColor.toString();
    }
    if (fontSize != null) {
      styles['font-size'] = '${fontSize}px';
    }
    if (fontWeight != null) {
      styles['font-weight'] = fontWeight!.value;
    }
    if (fontStyle != null) {
      styles['font-style'] =
          fontStyle == FontStyle.italic ? 'italic' : 'normal';
    }
    if (fontFamily != null) {
      styles['font-family'] = fontFamily!;
    }
    if (letterSpacing != null) {
      styles['letter-spacing'] = '${letterSpacing}px';
    }
    if (wordSpacing != null) {
      styles['word-spacing'] = '${wordSpacing}px';
    }
    if (height != null) {
      styles['line-height'] = height.toString();
    }
    if (decoration != null) {
      styles['text-decoration'] = decoration.toString();
      styles['text-decoration-line'] = decoration.toString();
    }
    if (decorationColor != null) {
      styles['text-decoration-color'] = decorationColor.toString();
    }
    if (decorationStyle != null) {
      styles['text-decoration-style'] = decorationStyle!.name;
    }
    if (decorationThickness != null) {
      styles['text-decoration-thickness'] = '${decorationThickness}px';
    }
    if (overflow == TextOverflow.ellipsis) {
      styles['text-overflow'] = 'ellipsis';
    }
    return styles;
  }
}
