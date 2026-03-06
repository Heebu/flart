import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

typedef OnTextChanged = void Function(String value);
typedef OnTextSubmitted = void Function(String value);

class FDEditableText extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle? style;
  final String? placeholder;
  final bool obscureText;
  final int? maxLength;
  final OnTextChanged? onChanged;
  final OnTextSubmitted? onSubmitted;
  final TextAlign textAlign;
  final EdgeInsets? padding;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDEditableText({
    required this.controller,
    this.style,
    this.placeholder,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.textAlign = TextAlign.start,
    this.padding,
    this.cssStyle,
    this.rawCss,
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
    final type = widget.obscureText ? 'password' : 'text';

    final baseStyle = {
      'padding': widget.padding?.toCss() ?? '8px',
      'font-size': widget.style?.fontSize != null ? '${widget.style!.fontSize}px' : '16px',
      'color': widget.style?.color?.toString() ?? theme.textStyle.color.toString(),
      'border': '1px solid ${theme.dividerColor}',
      'border-radius': '4px',
      'outline': 'none',
      'text-align': widget.textAlign.toString().split('.').last,
      'width': '100%',
      'box-sizing': 'border-box',
      'background': 'transparent',
      ...?widget.cssStyle,
    };

    final styleString =
        baseStyle.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final placeholderAttr =
        widget.placeholder != null ? 'placeholder="${widget.placeholder}"' : '';
    final maxLengthAttr =
        widget.maxLength != null ? 'maxlength="${widget.maxLength}"' : '';
    // IMPORTANT: use [value] for current value in HTML.
    final valueAttr = 'value="${widget.controller.text}"';

    final onChangeCbId = FlartCallbackManager.registerEvent((val) {
      final newVal = val.toString();
      // Only set text if it's actually different to avoid recursive re-renders
      if (widget.controller.text != newVal) {
        widget.controller.text = newVal;
        widget.onChanged?.call(newVal);
      }
    });

    final onSubmitCbId = FlartCallbackManager.registerEvent((val) {
      widget.onSubmitted?.call(val.toString());
    });

    final inputHtml = '''
      <input 
        id="$_inputId" 
        type="$type" 
        $placeholderAttr 
        $maxLengthAttr 
        $valueAttr
        style="$styleString ${widget.rawCss ?? ''}"
        oninput="window.__flartHandleEvent('$onChangeCbId', this.value)"
        onkeydown="if(event.key === 'Enter') { window.__flartHandleEvent('$onSubmitCbId', this.value); this.blur(); }"
      />
    '''.trim();

    return FDRawHTML(inputHtml);
  }
}
