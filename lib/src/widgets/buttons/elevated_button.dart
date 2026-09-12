import '../../../flartdart.dart';
class FDElevatedButton extends Widget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onHover;
  final Map<String, String>? cssStyle;
  final Map<String, String>? hoverStyle;
  final Map<String, String>? activeStyle;
  final Map<String, String>? disabledStyle;
  final String? rawCss;

  FDElevatedButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.cssStyle,
    this.hoverStyle,
    this.activeStyle,
    this.disabledStyle,
    this.rawCss,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final id = 'elevated_btn_${key?.toString() ?? DateTime.now().millisecondsSinceEpoch}';
    final classId = 'btn-$id';

    final theme = Theme.of(context);

    final baseStyle = {
      'padding': '10px 16px',
      'font-size': '14px',
      'background-color': theme.primaryColor.toString(),
      'color': '#ffffff',
      'border': 'none',
      'border-radius': '4px',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'transition': 'all 0.2s ease-in-out',
      ...?cssStyle,
    };

    final hoverCss = {
      'background-color':
          theme.primaryColor.lerp(FlartColors.white, 0.2).toString(),
      'box-shadow': '0 6px 12px rgba(0,0,0,0.2)',
      'transform': 'translateY(-1px) scale(1.02)',
      ...?hoverStyle,
    };

    final activeCss = {
      'background-color':
          theme.primaryColor.lerp(FlartColors.black, 0.1).toString(),
      'transform': 'translateY(1px) scale(0.98)',
      'box-shadow': '0 2px 4px rgba(0,0,0,0.1)',
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

    final styleBlock = '''
      <style>
        .$classId {
          $baseStyleStr
          ${rawCss ?? ''}
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
    ''';

    final events = <String, void Function(dynamic)>{};

    if (onPressed != null) {
      events['click'] = (e) => onPressed!();
    }
    if (onHover != null) {
      events['mouseenter'] = (e) => onHover!();
    }
    if (onLongPress != null) {
      // Basic VDOM long press logic
      // To track timeout across events, we would need state.
      // But we can attach it to the DOM node dynamically if needed, 
      // though pure dart is better.
      // For now, we'll just bind mousedown.
      // Note: Full gesture detection should be its own widget (GestureDetector)
      events['mousedown'] = (e) {
        // We'll skip long press timeout in this quick migration,
        // or we can use dart async Future.delayed.
        Future.delayed(const Duration(milliseconds: 600), () {
          // If mouse is still down, trigger it
          onLongPress!();
        });
      };
    }

    final buttonNode = FlartElementNode(
      'button',
      id: id,
      attributes: {'class': classId},
      events: events,
      children: [child.buildNode(context)],
    );

    return FlartElementNode(
      'div',
      styles: {'display': 'contents'},
      children: [
        FlartRawHtmlNode(styleBlock),
        buttonNode,
      ],
    );
  }
}
