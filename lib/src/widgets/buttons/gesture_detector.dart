import '../widget.dart';

typedef GestureCallback = String Function();

class GestureDetector extends Widget {
  final Widget child;
  final GestureCallback? onTap;
  final GestureCallback? onDoubleTap;
  final GestureCallback? onLongPress;
  final Map<String, String>? cssStyle;

  GestureDetector({
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.cssStyle,
  });

  @override
  String render() {
    final id = _generateUniqueId();
    final style = {
      'cursor': _hasGesture ? 'pointer' : 'default',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();

    buffer.writeln('<div id="$id" style="$style">');
    buffer.writeln(child.render());
    buffer.writeln('</div>');

    // Scripts for events
    final eventScripts = StringBuffer();
    if (onTap != null) {
      eventScripts.writeln('''
        document.getElementById('$id').addEventListener('click', () => {
          ${onTap!()}
        });
      ''');
    }

    if (onDoubleTap != null) {
      eventScripts.writeln('''
        document.getElementById('$id').addEventListener('dblclick', () => {
          ${onDoubleTap!()}
        });
      ''');
    }

    if (onLongPress != null) {
      eventScripts.writeln('''
        let pressTimer_$id;
        const el_$id = document.getElementById('$id');
        el_$id.addEventListener('mousedown', () => {
          pressTimer_$id = setTimeout(() => {
            ${onLongPress!()}
          }, 600);
        });
        el_$id.addEventListener('mouseup', () => {
          clearTimeout(pressTimer_$id);
        });
        el_$id.addEventListener('mouseleave', () => {
          clearTimeout(pressTimer_$id);
        });
      ''');
    }

    if (_hasGesture) {
      buffer.writeln('''
        <script>
          $eventScripts
        </script>
      ''');
    }

    return buffer.toString();
  }

  bool get _hasGesture => onTap != null || onDoubleTap != null || onLongPress != null;

  String _generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecondsSinceEpoch;
    return 'gesture_${timestamp}_$random';
  }
}
