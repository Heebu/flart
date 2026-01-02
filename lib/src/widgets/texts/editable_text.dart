import 'package:flart/src/controllers/text_editing_controller.dart';
import 'package:flart/src/enums/text_align.dart';

import '../../../flart.dart';

typedef OnTextChanged = void Function(String value);
typedef OnTextSubmitted = void Function(String value);

class EditableText extends Widget {
  final TextEditingController controller;
  final TextStyle? style;
  final String? placeholder;
  final bool obscureText;
  final int? maxLength;
  final OnTextChanged? onChanged;
  final OnTextSubmitted? onSubmitted;
  final TextAlign textAlign;
  final Map<String, String>? cssStyle;

  EditableText({
    required this.controller,
    this.style,
    this.placeholder,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.textAlign = TextAlign.start,
    this.cssStyle,
  });

  String _getTextAlignCss() {
    switch (textAlign) {
      case TextAlign.center:
        return 'center';
      case TextAlign.end:
        return 'right';
      case TextAlign.justify:
        return 'justify';
      default:
        return 'left';
    }
  }

  @override
  String render(BuildContext context) {
    final id = 'editable_${DateTime.now().millisecondsSinceEpoch}';
    final type = obscureText ? 'password' : 'text';

    final baseStyle = {
      'padding': '8px',
      'font-size': style?.fontSize?.toString() ?? '16px',
      'color': style?.color.toString() ?? '#000000',
      'border': '1px solid #ccc',
      'border-radius': '4px',
      'outline': 'none',
      'text-align': _getTextAlignCss(),
      ...?cssStyle,
    };

    final styleString =
        baseStyle.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final placeholderAttr =
        placeholder != null ? 'placeholder="$placeholder"' : '';
    final maxLengthAttr = maxLength != null ? 'maxlength="$maxLength"' : '';
    final valueAttr = 'value="${controller.text}"';

    final buffer = StringBuffer();
    buffer.writeln(
        '<input id="$id" type="$type" $placeholderAttr $maxLengthAttr $valueAttr style="$styleString"/>');

    // JS handlers
    buffer.writeln('''
      <script>
        const editable = document.getElementById('$id');
        editable.addEventListener('input', (e) => {
          window.__flartInputs = window.__flartInputs || {};
          window.__flartInputs['$id'] = e.target.value;
        });

        editable.addEventListener('keydown', (e) => {
          if (e.key === 'Enter') {
            window.__flartSubmitted = window.__flartSubmitted || {};
            window.__flartSubmitted['$id'] = e.target.value;
          }
        });
      </script>
    ''');

    return buffer.toString();
  }
}


//EditableText(
//   controller: TextEditingController(text: 'Edit me'),
//   placeholder: 'Enter text',
//   textAlign: TextAlign.center,
//   style: TextStyle(
//     fontSize: 18,
//     color: FlartColor('#222222'),
//   ),
//   maxLength: 50,
//   onChanged: (value) => print('Changed: $value'),
//   onSubmitted: (value) => print('Submitted: $value'),
// )