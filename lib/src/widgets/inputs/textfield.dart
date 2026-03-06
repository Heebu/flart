import '../../../flartdart.dart';

/// A FDText field widget for user input
class FDTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? style;
  final EdgeInsets? padding;
  final FlartColor? backgroundColor;
  final FlartColor? borderColor;
  final FlartColor? focusedBorderColor;
  final double? borderRadius;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTextField({
    this.controller,
    this.placeholder,
    this.label,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.style,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Create an internal controller if none provided
    final effectiveController =
        controller ?? TextEditingController(text: initialValue ?? '');

    final radius = borderRadius ?? 4.0;
    final pad =
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final hasError = errorText != null;

    return FDContainer(
      cssStyle: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
        ...?cssStyle,
      },
      child: FDColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            FDText(
              label!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.textStyle.color,
              ),
            ),
          FDContainer(
            decoration: BoxDecoration(
              color: backgroundColor ?? theme.cardColor,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: hasError
                    ? theme.errorColor
                    : (borderColor ?? theme.dividerColor),
                width: 1,
              ),
            ),
            child: FDStack(
              children: [
                FDEditableText(
                  controller: effectiveController,
                  placeholder: placeholder,
                  obscureText: obscureText,
                  maxLength: maxLength,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  style: style ?? theme.textStyle,
                  textAlign: TextAlign.start,
                  padding: pad,
                  rawCss: '''
                    ${prefixIcon != null ? 'padding-left: 40px;' : ''}
                    ${suffixIcon != null ? 'padding-right: 40px;' : ''}
                    border: none !important;
                    background: transparent !important;
                    ${rawCss ?? ''}
                  ''',
                ),
                if (prefixIcon != null)
                  FDPositioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: FDCenter(child: prefixIcon!),
                  ),
                if (suffixIcon != null)
                  FDPositioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: FDCenter(child: suffixIcon!),
                  ),
              ],
            ),
          ),
          if (errorText != null)
            FDText(
              errorText!,
              style: TextStyle(fontSize: 12, color: theme.errorColor),
            )
          else if (helperText != null)
            FDText(
              helperText!,
              style: TextStyle(fontSize: 12, color: FlartColors.grey),
            ),
        ],
      ),
    );
  }
}
