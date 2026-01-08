import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

typedef FlartVoidCallback = String Function();

class FDFloatingActionButton extends Widget {
  final Widget child;
  final FlartColor backgroundColor;
  final VoidCallback? onPressed;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDFloatingActionButton({
    required this.child,
    this.backgroundColor = FlartColors.green,
    this.onPressed,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final id = _generateUniqueId();

    final style = {
      'position': 'fixed',
      // ... same styles ...
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

    String onClickAttr = '';
    if (onPressed != null) {
      final cbId = FlartCallbackManager.register(onPressed!);
      onClickAttr = 'onclick="window.__flartHandleClick(\'$cbId\')"';
    }

    final buffer = StringBuffer();
    buffer
        .writeln('<div id="$id" style="$style ${rawCss ?? ''}" $onClickAttr>');
    buffer.writeln(child.render(context));
    buffer.writeln('</div>');

    return buffer.toString();
  }

  String _generateUniqueId() {
    final now = DateTime.now();
    return 'fab_${now.millisecondsSinceEpoch}_${now.microsecondsSinceEpoch}';
  }
}
