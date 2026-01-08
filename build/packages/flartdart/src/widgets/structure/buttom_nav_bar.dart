import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

class FDBottomNavigationBar extends Widget {
  final List<FDBottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int index)? onTap;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDBottomNavigationBar({
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final style = {
      'display': 'flex',
      'justify-content': 'space-around',
      'align-items': 'center',
      'padding': '10px 0',
      'background': '#f9f9f9',
      'box-shadow': '0 -1px 5px rgba(0,0,0,0.1)',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();
    buffer.writeln('<div style="$style ${rawCss ?? ''}">');

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final selected = i == currentIndex;
      final id = 'nav-item-$i';

      String clickAttr = '';
      if (onTap != null) {
        final cbId = FlartCallbackManager.register(() => onTap!(i));
        clickAttr = 'onclick="window.__flartHandleClick(\'$cbId\')"';
      }

      buffer.writeln('''
        <div id="$id" style="position: relative; cursor: pointer;" $clickAttr>
          ${selected ? (item.activeIcon?.render(context) ?? item.icon.render(context)) : item.icon.render(context)}
          ${item.label != null ? '<div style="font-size: 12px; color: ${selected ? '#007BFF' : '#555'}">${item.label}</div>' : ''}
          ${item.badge != null ? '<div style="position: absolute; top: 0; right: 0;">${item.badge!.render(context)}</div>' : ''}
        </div>
      ''');
    }

    buffer.writeln('</div>');
    return buffer.toString();
  }
}
