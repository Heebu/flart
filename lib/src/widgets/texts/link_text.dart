import '../../helper/callback_manager.dart';
import 'dart:html';
import '../../../flart.dart';

class LinkText extends Widget {
  final String label;
  final String? href;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final TextStyle? style;
  final Map<String, String>? cssStyle;

  LinkText({
    required this.label,
    this.href,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final idClick =
        onPressed != null ? FlartCallbackManager.register(onPressed!) : null;
    final idLongPress = onLongPress != null
        ? FlartCallbackManager.register(onLongPress!)
        : null;

    final styleMap = {
      'color': style?.color?.toString() ?? '#1a0dab',
      'font-size': style?.fontSize?.toString() ?? '16px',
      'text-decoration': 'underline',
      'cursor': 'pointer',
      'transition': 'opacity 0.2s ease',
      ...?cssStyle,
    };
    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final eventHandlers = [
      if (idClick != null) 'onclick="__flartHandleClick(\'$idClick\')"',
      if (idLongPress != null)
        '''
        onmousedown="this._pressTimer = setTimeout(() => __flartHandleClick('$idLongPress'), 600)"
        onmouseup="clearTimeout(this._pressTimer)"
        onmouseleave="clearTimeout(this._pressTimer)"
      '''
    ].join(' ');

    if (href != null) {
      return '''
        <a href="$href" style="$styleString" target="_blank" $eventHandlers>$label</a>
      ''';
    } else {
      return '''
        <span style="$styleString" $eventHandlers>$label</span>
      ''';
    }
  }
}



//LinkText(
//   label: 'Click to visit Flart',
//   href: 'https://flart.dev', // Opens in new tab
//   onPressed: () => print('Link clicked!'),
//   onLongPress: () => print('Long press on link!'),
//   style: TextStyle(
//     fontSize: 16,
//     color: FlartColor('#0057ff'),
//   ),
// )