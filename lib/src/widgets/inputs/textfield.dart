import '../../../flartdart.dart';

typedef TextField = FDTextField;

/// A text input field widget following Flutter's [TextField] specification.
class FDTextField extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
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
  final bool autofocus;

  const FDTextField({
    this.controller,
    this.decoration,
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
    this.autofocus = false,
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Resolve decoration properties, prioritizing explicit [decoration] if provided.
    final effectiveLabelText = decoration?.labelText ?? label;
    final effectiveLabelWidget = decoration?.label ??
        (effectiveLabelText != null
            ? FDText(
                effectiveLabelText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.textStyle.color,
                ),
              )
            : null);

    final effectiveHintText = decoration?.hintText ?? placeholder;
    final effectiveErrorText = decoration?.errorText ?? errorText;
    final effectiveHelperText = decoration?.helperText ?? helperText;
    final effectivePrefix = decoration?.prefixIcon ?? prefixIcon;
    final effectiveSuffix = decoration?.suffixIcon ?? suffixIcon;
    final effectiveFillColor =
        decoration?.fillColor ?? backgroundColor ?? theme.cardColor;
    final hasError = effectiveErrorText != null;

    // Resolve borders
    final InputBorder? explicitBorder = hasError
        ? (decoration?.errorBorder ?? decoration?.border)
        : (decoration?.enabledBorder ?? decoration?.border);

    Border resolvedBorder;
    BorderRadius resolvedRadius;

    if (explicitBorder != null) {
      if (explicitBorder is OutlineInputBorder) {
        resolvedRadius = explicitBorder.borderRadius;
        resolvedBorder = Border.all(
          color: explicitBorder.borderSide.color,
          width: explicitBorder.borderSide.width,
        );
      } else if (explicitBorder is UnderlineInputBorder) {
        resolvedRadius = BorderRadius.zero;
        resolvedBorder = Border(
          bottom: explicitBorder.borderSide,
        );
      } else {
        // Border.none or other
        resolvedRadius = BorderRadius.circular(borderRadius ?? 4.0);
        resolvedBorder = Border.all(
          color: FlartColors.transparent,
          width: 0,
        );
      }
    } else {
      resolvedRadius = BorderRadius.circular(borderRadius ?? 4.0);
      resolvedBorder = Border.all(
        color:
            hasError ? theme.errorColor : (borderColor ?? theme.dividerColor),
        width: 1,
      );
    }

    final effectivePadding = decoration?.contentPadding ??
        padding ??
        EdgeInsets.only(
          left: effectivePrefix != null ? 40 : 12,
          right: effectiveSuffix != null ? 40 : 12,
          top: 10,
          bottom: 10,
        );

    final effectiveController =
        controller ?? TextEditingController(text: initialValue ?? '');

    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (effectiveLabelWidget != null) ...[
          effectiveLabelWidget,
          const SizedBox(height: 4),
        ],
        FDContainer(
          decoration: BoxDecoration(
            color: effectiveFillColor,
            borderRadius: resolvedRadius,
            border: resolvedBorder,
          ),
          child: FDStack(
            children: [
              FDEditableText(
                controller: effectiveController,
                placeholder: effectiveHintText,
                obscureText: obscureText,
                autofocus: autofocus,
                maxLength: maxLength,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                style: style ?? theme.textStyle,
                textAlign: TextAlign.start,
                padding: effectivePadding,
                showBorder: false,
              ),
              if (effectivePrefix != null)
                FDPositioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: FDCenter(child: effectivePrefix),
                ),
              if (effectiveSuffix != null)
                FDPositioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: FDCenter(child: effectiveSuffix),
                ),
            ],
          ),
        ),
        if (effectiveErrorText != null) ...[
          const SizedBox(height: 4),
          FDText(
            effectiveErrorText,
            style: decoration?.errorStyle ??
                TextStyle(fontSize: 12, color: theme.errorColor),
          ),
        ] else if (effectiveHelperText != null) ...[
          const SizedBox(height: 4),
          FDText(
            effectiveHelperText,
            style: decoration?.helperStyle ??
                const TextStyle(fontSize: 12, color: FlartColors.grey),
          ),
        ],
      ],
    );
  }
}
