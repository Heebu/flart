import '../../../flart.dart';

/// A text field widget for user input
class TextField extends Widget {
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

  TextField({
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
  });

  @override
  String render(BuildContext context) {
    final id = 'textfield_${DateTime.now().microsecondsSinceEpoch}';
    final inputType = _getInputType();
    final value = controller?.text ?? initialValue ?? '';
    final bgColor = backgroundColor?.toString() ?? '#ffffff';
    final border = borderColor?.toString() ?? '#cccccc';
    final focusBorder = focusedBorderColor?.toString() ?? '#007bff';
    final radius = borderRadius ?? 4.0;
    final pad = padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final hasError = errorText != null;

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <div style="position: relative; display: flex; align-items: center;">
          ${prefixIcon != null ? '<div style="position: absolute; left: 8px; display: flex; align-items: center;">${prefixIcon!.render(context)}</div>' : ''}
          
          <input
            type="$inputType"
            id="$id"
            value="$value"
            placeholder="${placeholder ?? ''}"
            ${!enabled ? 'disabled' : ''}
            ${readOnly ? 'readonly' : ''}
            ${maxLength != null ? 'maxlength="$maxLength"' : ''}
            style="
              width: 100%;
              padding: ${pad.toCss()};
              ${prefixIcon != null ? 'padding-left: 40px;' : ''}
              ${suffixIcon != null ? 'padding-right: 40px;' : ''}
              background-color: $bgColor;
              border: 1px solid ${hasError ? '#dc3545' : border};
              border-radius: ${radius}px;
              font-size: 14px;
              outline: none;
              transition: border-color 0.2s;
              ${!enabled ? 'opacity: 0.6; cursor: not-allowed;' : ''}
              ${readOnly ? 'background-color: #f5f5f5;' : ''}
              ${cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? ''}
            "
          />
          
          ${suffixIcon != null ? '<div style="position: absolute; right: 8px; display: flex; align-items: center;">${suffixIcon!.render(context)}</div>' : ''}
        </div>
        
        ${errorText != null ? '<span style="font-size: 12px; color: #dc3545;">$errorText</span>' : ''}
        ${helperText != null && errorText == null ? '<span style="font-size: 12px; color: #666;">$helperText</span>' : ''}
      </div>
      
      <style>
        #$id:focus {
          border-color: ${hasError ? '#dc3545' : focusBorder} !important;
          box-shadow: 0 0 0 3px ${hasError ? 'rgba(220, 53, 69, 0.1)' : 'rgba(0, 123, 255, 0.1)'};
        }
      </style>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          ${onChanged != null ? '''
            input.addEventListener('input', function(e) {
              console.log('TextField changed:', e.target.value);
            });
          ''' : ''}
          ${onSubmitted != null ? '''
            input.addEventListener('keypress', function(e) {
              if (e.key === 'Enter') {
                console.log('TextField submitted:', e.target.value);
              }
            });
          ''' : ''}
          ${onTap != null ? '''
            input.addEventListener('click', function() {
              console.log('TextField tapped');
            });
          ''' : ''}
        })();
      </script>
    ''';
  }

  String _getInputType() {
    if (obscureText) return 'password';
    if (keyboardType == TextInputType.email) return 'email';
    if (keyboardType == TextInputType.number) return 'number';
    if (keyboardType == TextInputType.phone) return 'tel';
    if (keyboardType == TextInputType.url) return 'url';
    return 'text';
  }
}

/// Text input types
enum TextInputType {
  text,
  number,
  email,
  phone,
  url,
  multiline,
}
