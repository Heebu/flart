import 'widget.dart';

typedef GestureCallback = String Function(); // Returns JS string to execute

class GestureDetector extends Widget {
  final Widget child;
  final GestureCallback? onTap;
  final Map<String, String>? cssStyle;

  GestureDetector({
    required this.child,
    this.onTap,
    this.cssStyle,
  });

  @override
  String render() {
    final style = {
      'cursor': onTap != null ? 'pointer' : 'default',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final id = _generateUniqueId();

    final buffer = StringBuffer();
    buffer.writeln('<div id="$id" style="$style">');
    buffer.writeln(child.render());
    buffer.writeln('</div>');

    if (onTap != null) {
      final jsFunc = onTap!(); // e.g., return "alert('Tapped!');"
      buffer.writeln('''
        <script>
          window.__flartTapHandlers = window.__flartTapHandlers || {};
          window.__flartTapHandlers['$id'] = function() {
            $jsFunc
          };
          document.getElementById('$id').addEventListener('click', () => {
            window.__flartTapHandlers['$id']();
          });
        </script>
      ''');
    }

    return buffer.toString();
  }

  String _generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecondsSinceEpoch;
    return 'gesture_${timestamp}_$random';
  }
}
