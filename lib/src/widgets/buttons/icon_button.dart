import 'package:flartdart/src/widgets/structure/icons.dart';
import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

class FDIconButton extends Widget {
  final FDIcon icon;
  final VoidCallback? onPressed;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDIconButton({
    required this.icon,
    this.onPressed,
    this.cssStyle,
    this.rawCss,
    Key? key,
  }) : super(key: key);

  @override
  String render(BuildContext context) {
    final id =
        'icon_btn_stateless_${hashCode}_${DateTime.now().millisecondsSinceEpoch}';
    final theme = Theme.of(context);
    final cbId =
        onPressed != null ? FlartCallbackManager.register(onPressed!) : null;

    final styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'padding': '8px',
      'border': 'none',
      'background': 'transparent',
      'border-radius': '50%',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'outline': 'none',
      'transition': 'background-color 0.2s, transform 0.1s',
      ...?cssStyle,
    };
    final styleString =
        styles.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <button id="$id" class="fd-icon-button" style="$styleString ${rawCss ?? ''}" 
        ${cbId != null ? 'onclick="window.__flartHandleClick(\'$cbId\')"' : ''}>
        ${icon.render(context)}
      </button>
      <style>
        .fd-icon-button:hover {
          background-color: ${theme.primaryColor.toString()}1A !important;
        }
        .fd-icon-button:active {
          transform: scale(0.92);
          background-color: ${theme.primaryColor.toString()}33 !important;
        }
      </style>
    ''';
  }
}
