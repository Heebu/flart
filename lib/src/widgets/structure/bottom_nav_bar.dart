import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';
import '../../helper/style_utils.dart';

class FDBottomNavigationBar extends Widget {
  final List<FDBottomNavigationBarItem> items;
  final int currentIndex;
  final void Function(int index)? onTap;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDBottomNavigationBar({
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final theme = Theme.of(context);
    final style = toInlineStyle({
      'display': 'flex',
      'justify-content': 'space-around',
      'align-items': 'center',
      'padding': '10px 0',
      'background': theme.cardColor.toString(),
      'box-shadow': '0 -1px 5px rgba(0,0,0,0.1)',
      'border-top': '1px solid ${theme.dividerColor}',
      'background-color': theme.scaffoldBackgroundColor.toString(),
      'color': theme.textStyle.color.toString(),
      'overflow-y': 'auto',
      'border-bottom': '2px solid ${theme.dividerColor}',
      ...?cssStyle,
    }, rawCss: rawCss);

    final buffer = StringBuffer();
    buffer.writeln('<div style="$style">');

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final selected = i == currentIndex;
      final id = 'nav-item-$i';

      String clickAttr = '';
      if (onTap != null) {
        final cbId = FlartCallbackManager.register(() => onTap!(i));
        clickAttr = 'onclick="window.__flartHandleClick(\'$cbId\')"';
      }

      final themeColor = theme.textStyle.color is FlartColor
          ? theme.textStyle.color as FlartColor
          : FlartColors.black;

      final labelColor = selected
          ? theme.primaryColor
          : (themeColor.lerp(FlartColors.grey, 0.5));

      buffer.writeln('''
        <div id="$id" style="position: relative; cursor: pointer; text-align: center;" $clickAttr>
          ${selected ? (item.activeIcon?.render(context) ?? item.icon.render(context)) : item.icon.render(context)}
          ${item.label != null ? '<div style="font-size: 12px; color: ${labelColor.toString()}">${item.label}</div>' : ''}
          ${item.badge != null ? '<div style="position: absolute; top: 0; right: 0;">${item.badge!.render(context)}</div>' : ''}
        </div>
      ''');
    }

    buffer.writeln('</div>');
    return buffer.toString();
  }
}
