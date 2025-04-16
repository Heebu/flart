import '../../../flart.dart';
import 'dart:html';
import '../../helper/callback_manager.dart';

class IconButton extends Widget {
  final Icon icon;
  final VoidCallback? onPressed;
  final Map<String, String>? cssStyle;

  IconButton({
    required this.icon,
    this.onPressed,
    this.cssStyle,
  });

  @override
  String render() {
    final id = 'icon_btn_${DateTime.now().millisecondsSinceEpoch}';
    final cbId = onPressed != null ? FlartCallbackManager.register(onPressed!) : null;

    final style = {
      'font-family': 'Material Icons',
      'font-size': '${icon.size}px',
      'color': icon.color,
      'border': 'none',
      'background': 'transparent',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'outline': 'none',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <button id="$id" style="$style">${icon.icon}</button>
      ${cbId != null ? '''
        <script>
          document.getElementById('$id').addEventListener('click', () => {
            window.__flartHandleClick('$cbId');
          });
        </script>
      ''' : ''}
    ''';
  }
}
