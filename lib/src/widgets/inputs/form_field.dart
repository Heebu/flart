import 'package:flartdart/src/widgets/inputs/textfield.dart';

import '../../../flartdart.dart';

/// A form field wrapper that provides validation and state management
class FormField<T> extends Widget {
  final Widget Function(FormFieldState<T> state) builder;
  final T? initialValue;
  final String? Function(T? value)? validator;
  final ValueChanged<T?>? onSaved;
  final bool enabled;

  FormField({
    required this.builder,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.enabled = true,
  });

  @override
  String render(BuildContext context) {
    final state = FormFieldState<T>(
      value: initialValue,
      validator: validator,
      onSaved: onSaved,
      enabled: enabled,
    );

    return builder(state).render(context);
  }
}

/// State for FormField
class FormFieldState<T> {
  T? value;
  String? errorText;
  final String? Function(T? value)? validator;
  final ValueChanged<T?>? onSaved;
  final bool enabled;

  FormFieldState({
    this.value,
    this.validator,
    this.onSaved,
    this.enabled = true,
  });

  void didChange(T? newValue) {
    value = newValue;
    validate();
  }

  bool validate() {
    if (validator != null) {
      errorText = validator!(value);
      return errorText == null;
    }
    return true;
  }

  void save() {
    onSaved?.call(value);
  }

  void reset() {
    value = null;
    errorText = null;
  }
}

/// A FDText form field with built-in validation
class FDTextFormField extends Widget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final String? initialValue;
  final String? Function(String? value)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final Map<String, String>? cssStyle;

  FDTextFormField({
    this.controller,
    this.placeholder,
    this.label,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final state = FormFieldState<String>(
      value: initialValue,
      validator: validator,
      onSaved: onSaved != null ? (value) => onSaved!(value ?? '') : null,
      enabled: enabled,
    );

    return FDTextField(
      controller: controller,
      placeholder: placeholder,
      label: label,
      initialValue: state.value,
      onChanged: (value) {
        state.didChange(value);
        onChanged?.call(value);
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      errorText: state.errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      padding: padding,
      cssStyle: cssStyle,
    ).render(context);
  }
}

/// A form widget that groups form fields
class Form extends Widget {
  final Widget child;
  final VoidCallback? onChanged;
  final GlobalKey<FormState>? key;

  Form({
    required this.child,
    this.onChanged,
    this.key,
  });

  @override
  String render(BuildContext context) {
    final id = 'form_${DateTime.now().microsecondsSinceEpoch}';

    return '''
      <form id="$id" style="width: 100%;">
        ${child.render(context)}
      </form>
      <script>
        (function() {
          const form = document.getElementById('$id');
          form.addEventListener('submit', function(e) {
            e.preventDefault();
            console.log('Form submitted');
          });
          ${onChanged != null ? '''
            form.addEventListener('change', function() {
              console.log('Form changed');
            });
          ''' : ''}
        })();
      </script>
    ''';
  }
}

/// Global key for form state
class GlobalKey<T> {
  final String id = 'key_${DateTime.now().microsecondsSinceEpoch}';
}

/// Form state
class FormState {
  bool validate() {
    // Validate all fields
    return true;
  }

  void save() {
    // Save all fields
  }

  void reset() {
    // Reset all fields
  }
}
