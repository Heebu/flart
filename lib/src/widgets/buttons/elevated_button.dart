import 'dart:html';
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
  String render() {
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

    final String baseStyleStr = baseStyle.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final String hoverStyleStr = hoverCss.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final String activeStyleStr = activeCss.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final String disabledStyleStr = disabledCss.entries.map((e) => '${e.key}: ${e.value};').join(' ');

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

    buffer.writeln('<button id="$id" class="$classId">${child.render()}</button>');

    // JavaScript callbacks
    buffer.writeln('<script>');
    if (onPressed != null) {
      final cbId = FlartCallbackManager.register(onPressed!);
      buffer.writeln('''
        document.getElementById("$id").addEventListener("click", function() {
          window.__flartHandleClick("$cbId");
        });
      ''');
    }

    if (onLongPress != null) {
      final longPressId = FlartCallbackManager.register(onLongPress!);
      buffer.writeln('''
        let pressTimer;
        document.getElementById("$id").addEventListener("mousedown", function(e) {
          pressTimer = window.setTimeout(() => {
            window.__flartHandleClick("$longPressId");
          }, 600);
        });
        document.getElementById("$id").addEventListener("mouseup", function(e) {
          clearTimeout(pressTimer);
        });
      ''');
    }

    if (onHover != null) {
      final hoverId = FlartCallbackManager.register(onHover!);
      buffer.writeln('''
        document.getElementById("$id").addEventListener("mouseenter", function() {
          window.__flartHandleClick("$hoverId");
        });
      ''');
    }

    buffer.writeln('</script>');

    return buffer.toString();
  }
}
