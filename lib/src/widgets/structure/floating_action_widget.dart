import '../../../flart.dart';

typedef FlartVoidCallback = String Function();

class FloatingActionButton extends Widget {
  final Widget child;
  final FlartColor backgroundColor;
  final FlartVoidCallback? onPressed;
  final Map<String, String>? cssStyle;

  FloatingActionButton({
    required this.child,
    this.backgroundColor = FlartColors.green,
    this.onPressed,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = _generateUniqueId();

    final style = {
      'position': 'fixed',
      'bottom': '20px',
      'right': '20px',
      'width': '56px',
      'height': '56px',
      'border-radius': '50%',
      'background-color': backgroundColor.toString(),
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'box-shadow': '0 3px 6px rgba(0,0,0,0.16)',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'z-index': '1000',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();
    buffer.writeln('<div id="$id" style="$style">');
    buffer.writeln(child.render(context));
    buffer.writeln('</div>');

    if (onPressed != null) {
      final jsFunc = onPressed!();
      buffer.writeln('''
        <script>
          document.getElementById('$id')?.addEventListener('click', () => {
            $jsFunc
          });
        </script>
      ''');
    }

    return buffer.toString();
  }

  String _generateUniqueId() {
    final now = DateTime.now();
    return 'fab_${now.millisecondsSinceEpoch}_${now.microsecondsSinceEpoch}';
  }
}
