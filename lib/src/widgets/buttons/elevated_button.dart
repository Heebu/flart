import '../../../flart.dart';
import '../../helper/callback_manager.dart';

class ElevatedButton extends Widget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onHover;
  final Map<String, String>? cssStyle;
  final Map<String, String>? hoverStyle;
  final Map<String, String>? activeStyle;
  final Map<String, String>? disabledStyle;

  ElevatedButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.cssStyle,
    this.hoverStyle,
    this.activeStyle,
    this.disabledStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'elevated_btn_${DateTime.now().millisecondsSinceEpoch}';
    final classId = 'btn-$id';

    final baseStyle = {
      'padding': '10px 16px',
      'font-size': '14px',
      'background-color': '#6200ea',
      'color': '#ffffff',
      'border': 'none',
      'border-radius': '4px',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'transition': 'all 0.2s ease-in-out',
      ...?cssStyle,
    };

    final hoverCss = {
      ...?hoverStyle,
    };

    final activeCss = {
      ...?activeStyle,
    };

    final disabledCss = {
      ...?disabledStyle,
    };

    final String baseStyleStr =
        baseStyle.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final String hoverStyleStr =
        hoverCss.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final String activeStyleStr =
        activeCss.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final String disabledStyleStr =
        disabledCss.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();

    buffer.writeln('''
      <style>
        .$classId {
          $baseStyleStr
        }
        .$classId:hover {
          $hoverStyleStr
        }
        .$classId:active {
          $activeStyleStr
        }
        .$classId:disabled {
          $disabledStyleStr
        }
      </style>
    ''');

    // Event strings
    String events = '';

    if (onPressed != null) {
      final cbId = FlartCallbackManager.register(onPressed!);
      events += ' onclick="window.__flartHandleClick(\'$cbId\')"';
    }

    if (onHover != null) {
      final hoverId = FlartCallbackManager.register(onHover!);
      events += ' onmouseenter="window.__flartHandleClick(\'$hoverId\')"';
    }

    if (onLongPress != null) {
      final longPressId = FlartCallbackManager.register(onLongPress!);
      // Simple inline long press logic
      events += '''
        onmousedown="this.dataset.tmr = setTimeout(() => window.__flartHandleClick('$longPressId'), 600)"
        onmouseup="clearTimeout(this.dataset.tmr)"
        onmouseleave="clearTimeout(this.dataset.tmr)"
      ''';
    }

    buffer.writeln(
        '<button id="$id" class="$classId" $events>${child.render(context)}</button>');

    return buffer.toString();
  }
}
