import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef EditableText = FDEditableText;
typedef OnTextChanged = void Function(String value);
typedef OnTextSubmitted = void Function(String value);

class FDEditableText extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle? style;
  final String? placeholder;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? maxLength;
  final OnTextChanged? onChanged;
  final OnTextSubmitted? onSubmitted;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final EdgeInsets? padding;
  final bool showBorder;

  const FDEditableText({
    required this.controller,
    this.style,
    this.placeholder,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.padding,
    this.showBorder = true,
    super.key,
  });

  @override
  State<FDEditableText> createState() => _FDEditableTextState();
}

class _FDEditableTextState extends State<FDEditableText> {
  late String _inputId;

  @override
  void initState() {
    super.initState();
    _inputId = 'editable_${hashCode}_${DateTime.now().millisecondsSinceEpoch}';
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(FDEditableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleControllerChanged);
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isMultiline = widget.maxLines != null && widget.maxLines! > 1;
    final type = widget.obscureText
        ? 'password'
        : _keyboardTypeToString(widget.keyboardType);

    final baseStyle = <String, String>{
      'box-sizing': 'border-box',
      'padding': widget.padding?.toCss() ?? '8px 12px',
      'font-size': widget.style?.fontSize != null
          ? '${widget.style!.fontSize}px'
          : '16px',
      'color':
          widget.style?.color?.toString() ?? theme.textStyle.color.toString(),
      'border': widget.showBorder ? '1px solid ${theme.dividerColor}' : 'none',
      'border-radius': '6px',
      'outline': 'none',
      'text-align': widget.textAlign.toString().split('.').last,
      'width': '100%',
      'background': 'transparent',
      'font-family': widget.style?.fontFamily ?? 'inherit',
      'resize': isMultiline ? 'vertical' : 'none',
    };

    final attributes = <String, String>{
      'id': _inputId,
      if (widget.placeholder != null) 'placeholder': widget.placeholder!,
      if (widget.maxLength != null) 'maxlength': widget.maxLength!.toString(),
      if (widget.readOnly) 'readonly': '',
      if (widget.autofocus) 'autofocus': '',
    };

    if (isMultiline) {
      if (widget.maxLines != null) {
        attributes['rows'] = widget.maxLines!.toString();
      }
      return FDElement(
        tag: 'textarea',
        attributes: attributes,
        styles: baseStyle,
        textContent: widget.controller.text,
        events: {
          'input': (web.Event e) {
            final target = e.target as web.HTMLTextAreaElement?;
            if (target != null) {
              final value = target.value;
              if (widget.controller.text != value) {
                widget.controller.text = value;
                widget.onChanged?.call(value);
              }
            }
          },
        },
      );
    }

    attributes['type'] = type;
    attributes['value'] = widget.controller.text;

    return FDElement(
      tag: 'input',
      attributes: attributes,
      styles: baseStyle,
      events: {
        'input': (web.Event e) {
          final target = e.target as web.HTMLInputElement?;
          if (target != null) {
            final value = target.value;
            if (widget.controller.text != value) {
              widget.controller.text = value;
              widget.onChanged?.call(value);
            }
          }
        },
        'keydown': (web.Event e) {
          final target = e.target as web.HTMLInputElement?;
          final kbEvent = e as web.KeyboardEvent;
          if (kbEvent.key == 'Enter' && target != null) {
            final value = target.value;
            widget.onSubmitted?.call(value);
            target.blur();
          }
        }
      },
    );
  }

  String _keyboardTypeToString(TextInputType type) {
    switch (type) {
      case TextInputType.email:
        return 'email';
      case TextInputType.number:
      case TextInputType.phone:
        return 'number';
      case TextInputType.url:
        return 'url';
      default:
        return 'text';
    }
  }
}
