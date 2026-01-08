import 'package:flartdart/flartdart.dart';
import 'package:flartdart/src/widgets/structure/icons.dart';

import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

class FDIconButton extends Widget {
  final FDIcon icon;
  final VoidCallback? onPressed;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDIconButton({
    required this.icon,
    this.onPressed,
    this.cssStyle,
    this.rawCss,
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
      <button id="$id" style="$style ${rawCss ?? ''}" ${cbId != null ? 'onclick="window.__flartHandleClick(\'$cbId\')"' : ''}>
        ${icon.icon}
      </button>
    ''';
  }
}
