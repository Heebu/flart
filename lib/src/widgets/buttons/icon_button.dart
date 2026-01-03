import '../../../flartdart.dart';
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
  String render(BuildContext context) {
    final id = 'icon_btn_${DateTime.now().millisecondsSinceEpoch}';
    final cbId =
        onPressed != null ? FlartCallbackManager.register(onPressed!) : null;

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
      <button id="$id" style="$style" ${cbId != null ? 'onclick="window.__flartHandleClick(\'$cbId\')"' : ''}>
        ${icon.icon}
      </button>
    ''';
  }
}
