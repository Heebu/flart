import 'package:flart_project/src/widgets/utils/build_context.dart';

import '../../../flart.dart';

typedef OnChanged = void Function(String value);

class TextField extends Widget {
  final String? placeholder;
  final bool obscureText;
  final OnChanged? onChanged;
  final Map<String, String>? cssStyle;
  final TextEditingController? controller;

  TextField({
    this.placeholder,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'textField_\${DateTime.now().millisecondsSinceEpoch}';
    final style = {
      'padding': '8px',
      'font-size': '16px',
      'border': '1px solid #ccc',
      'border-radius': '4px',
      'outline': 'none',
      ...?cssStyle,
    }.entries.map((e) => '\${e.key}: \${e.value};').join(' ');

    final type = obscureText ? 'password' : 'text';
    final valueAttr = controller != null ? 'value="\${controller!.text}"' : '';
    final placeholderAttr = placeholder != null ? 'placeholder="\$placeholder"' : '';

    final buffer = StringBuffer();
    buffer.writeln('<input id="\$id" type="\$type" \$valueAttr \$placeholderAttr style="\$style"/>');

    if (onChanged != null || controller != null) {
      buffer.writeln('''
        <script>
          const inputEl = document.getElementById('$id');
          inputEl.addEventListener('input', (e) => {
            const value = e.target.value;
            window.__flartInputs = window.__flartInputs || {};
            window.__flartInputs['$id'] = value;
          });
        </script>
      ''');
    }

    return buffer.toString();
  }


}
