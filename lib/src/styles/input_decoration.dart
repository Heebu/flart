import '../../flartdart.dart';

/// Defines the shape of the border around an input field.
abstract class InputBorder {
  const InputBorder({this.borderSide = const BorderSide()});

  /// The properties of this border's outline or underline.
  final BorderSide borderSide;

  /// An input border that does not draw anything.
  static const InputBorder none = _NoInputBorder();

  /// Whether this input border is an outline (surrounds all four sides).
  bool get isOutline;
}

class _NoInputBorder extends InputBorder {
  const _NoInputBorder()
      : super(
            borderSide:
                const BorderSide(width: 0, color: FlartColors.transparent));

  @override
  bool get isOutline => false;
}

/// An [InputBorder] that draws a rounded rectangle around the input field.
class OutlineInputBorder extends InputBorder {
  final BorderRadius borderRadius;

  const OutlineInputBorder({
    super.borderSide = const BorderSide(color: FlartColors.grey, width: 1.0),
    this.borderRadius = const BorderRadius.circular(4.0),
  });

  @override
  bool get isOutline => true;
}

/// An [InputBorder] that draws a horizontal line below the input field.
class UnderlineInputBorder extends InputBorder {
  final BorderRadius borderRadius;

  const UnderlineInputBorder({
    super.borderSide = const BorderSide(color: FlartColors.grey, width: 1.0),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  bool get isOutline => false;
}

/// The visual decoration around a [TextField] or [TextFormField].
class InputDecoration {
  final String? labelText;
  final Widget? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? helperText;
  final TextStyle? helperStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final bool? filled;
  final FlartColor? fillColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final EdgeInsets? contentPadding;
  final bool enabled;
  final bool isDense;

  const InputDecoration({
    this.labelText,
    this.label,
    this.hintText,
    this.hintStyle,
    this.helperText,
    this.helperStyle,
    this.errorText,
    this.errorStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.filled,
    this.fillColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.contentPadding,
    this.enabled = true,
    this.isDense = false,
  });

  InputDecoration copyWith({
    String? labelText,
    Widget? label,
    String? hintText,
    TextStyle? hintStyle,
    String? helperText,
    TextStyle? helperStyle,
    String? errorText,
    TextStyle? errorStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
    String? suffixText,
    bool? filled,
    FlartColor? fillColor,
    InputBorder? border,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? disabledBorder,
    EdgeInsets? contentPadding,
    bool? enabled,
    bool? isDense,
  }) {
    return InputDecoration(
      labelText: labelText ?? this.labelText,
      label: label ?? this.label,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      helperText: helperText ?? this.helperText,
      helperStyle: helperStyle ?? this.helperStyle,
      errorText: errorText ?? this.errorText,
      errorStyle: errorStyle ?? this.errorStyle,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      prefixText: prefixText ?? this.prefixText,
      suffixText: suffixText ?? this.suffixText,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      border: border ?? this.border,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
      contentPadding: contentPadding ?? this.contentPadding,
      enabled: enabled ?? this.enabled,
      isDense: isDense ?? this.isDense,
    );
  }
}
