import '../../flartdart.dart';

/// Style configuration for buttons in Flart.
/// Mirrors Flutter's [ButtonStyle].
class ButtonStyle {
  final TextStyle? textStyle;
  final FlartColor? backgroundColor;
  final FlartColor? foregroundColor;
  final FlartColor? overlayColor;
  final FlartColor? shadowColor;
  final double? elevation;
  final EdgeInsets? padding;
  final Size? minimumSize;
  final Size? fixedSize;
  final Size? maximumSize;
  final BorderSide? side;
  final BorderRadius? shape;
  final Alignment? alignment;

  const ButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.shadowColor,
    this.elevation,
    this.padding,
    this.minimumSize,
    this.fixedSize,
    this.maximumSize,
    this.side,
    this.shape,
    this.alignment,
  });

  ButtonStyle copyWith({
    TextStyle? textStyle,
    FlartColor? backgroundColor,
    FlartColor? foregroundColor,
    FlartColor? overlayColor,
    FlartColor? shadowColor,
    double? elevation,
    EdgeInsets? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    BorderRadius? shape,
    Alignment? alignment,
  }) {
    return ButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      minimumSize: minimumSize ?? this.minimumSize,
      fixedSize: fixedSize ?? this.fixedSize,
      maximumSize: maximumSize ?? this.maximumSize,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      alignment: alignment ?? this.alignment,
    );
  }

  /// Convenience factory mirroring Flutter's `styleFrom`
  static ButtonStyle styleFrom({
    TextStyle? textStyle,
    FlartColor? backgroundColor,
    FlartColor? foregroundColor,
    FlartColor? overlayColor,
    FlartColor? shadowColor,
    double? elevation,
    EdgeInsets? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    BorderRadius? shape,
    Alignment? alignment,
  }) {
    return ButtonStyle(
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      shadowColor: shadowColor,
      elevation: elevation,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      alignment: alignment,
    );
  }
}
