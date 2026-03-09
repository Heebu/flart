import '../../../flartdart.dart';

/// A container for grouping form fields.
class FDForm extends StatefulWidget {
  final Widget child;

  const FDForm({
    required this.child,
    super.key,
  });

  static FDFormState? of(BuildContext context) {
    return context.findAncestorStateOfType<FDFormState>();
  }

  @override
  State<FDForm> createState() => FDFormState();
}

class FDFormState extends State<FDForm> {
  final Set<FDFormFieldState<dynamic, FDFormField<dynamic>>> _fields = {};

  void registerField(FDFormFieldState<dynamic, FDFormField<dynamic>> field) {
    _fields.add(field);
  }

  void unregisterField(FDFormFieldState<dynamic, FDFormField<dynamic>> field) {
    _fields.remove(field);
  }

  /// Validates every [FDFormField] that is a descendant of this [FDForm].
  bool validate() {
    bool hasError = false;
    for (final field in _fields) {
      if (!field.validate()) {
        hasError = true;
      }
    }
    return !hasError;
  }

  /// Saves every [FDFormField] that is a descendant of this [FDForm].
  void save() {
    for (final field in _fields) {
      field.save();
    }
  }

  /// Resets every [FDFormField] that is a descendant of this [FDForm].
  void reset() {
    for (final field in _fields) {
      field.reset();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// A single form field.
abstract class FDFormField<T> extends StatefulWidget {
  final T? initialValue;
  final String? Function(T? value)? validator;
  final void Function(T? value)? onSaved;
  final Widget Function(FDFormFieldState<T, FDFormField<T>> state) builder;

  const FDFormField({
    required this.builder,
    this.initialValue,
    this.validator,
    this.onSaved,
    super.key,
  });

  @override
  FDFormFieldState<T, FDFormField<T>> createState();
}

class FDFormFieldState<T, W extends FDFormField<T>> extends State<W> {
  late T? _value;
  String? _errorText;

  T? get value => _value;
  String? get errorText => _errorText;
  bool get hasError => _errorText != null;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FDForm.of(context)?.registerField(this);
  }

  @override
  void dispose() {
    FDForm.of(context)?.unregisterField(this);
    super.dispose();
  }

  void didChange(T? value) {
    setState(() {
      _value = value;
    });
  }

  bool validate() {
    final result = widget.validator?.call(_value);
    setState(() {
      _errorText = result;
    });
    return result == null;
  }

  void reset() {
    setState(() {
      _value = widget.initialValue;
      _errorText = null;
    });
  }

  void save() {
    widget.onSaved?.call(_value);
  }

  @override
  Widget build(BuildContext context) => widget.builder(this);
}

/// A FDText form field with built-in validation
class FDTextFormField extends FDFormField<String> {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;

  FDTextFormField({
    super.initialValue,
    super.validator,
    super.onSaved,
    this.controller,
    this.placeholder,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    super.key,
  }) : super(
          builder: (state) {
            final field = state.widget as FDTextFormField;
            return FDTextField(
              controller: field.controller,
              initialValue: state.value,
              placeholder: field.placeholder,
              label: field.label,
              errorText: state.errorText,
              onChanged: (v) {
                state.didChange(v);
              },
              keyboardType: field.keyboardType,
              obscureText: field.obscureText,
              enabled: field.enabled,
              maxLines: field.maxLines,
              maxLength: field.maxLength,
              prefixIcon: field.prefixIcon,
              suffixIcon: field.suffixIcon,
              padding: field.padding,
            );
          },
        );

  @override
  FDFormFieldState<String, FDTextFormField> createState() =>
      FDFormFieldState<String, FDTextFormField>();
}
