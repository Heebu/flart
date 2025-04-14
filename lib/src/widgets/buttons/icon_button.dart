import '../../../flart.dart';

typedef IconCallback = String Function();

class IconButton extends Widget {
  final Icon icon;
  final IconCallback? onPressed;
  final Map<String, String>? cssStyle;

  IconButton({
    required this.icon,
    this.onPressed,
    this.cssStyle,
  });

  @override
  String render() {
    final id = 'icon_btn_${DateTime.now().millisecondsSinceEpoch}';
    final style = {
      'border': 'none',
      'background': 'transparent',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'outline': 'none',
      'padding': '8px',
      'border-radius': '4px',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();
    buffer.writeln('<button id="$id" style="$style">${icon.render()}</button>');

    if (onPressed != null) {
      buffer.writeln('''
        <script>
          document.getElementById('$id').addEventListener('click', () => {
            ${onPressed!()}
          });
        </script>
      ''');
    }

    return buffer.toString();
  }
}
