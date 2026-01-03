
import '../../../flartdart.dart';

class BottomNavigationBar extends Widget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int index)? onTap;
  final Map<String, String>? cssStyle;

  BottomNavigationBar({
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.cssStyle,
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
    buffer.writeln('<div style="$style">');

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final selected = i == currentIndex;
      final id = 'nav-item-$i';

      buffer.writeln('''
        <div id="$id" style="position: relative; cursor: pointer;">
          ${selected ? (item.activeIcon?.render(context) ?? item.icon.render(context)) : item.icon.render(context)}
          ${item.label != null ? '<div style="font-size: 12px; color: ${selected ? '#007BFF' : '#555'}">${item.label}</div>' : ''}
          ${item.badge != null ? '<div style="position: absolute; top: 0; right: 0;">${item.badge!.render(context)}</div>' : ''}
        </div>
        <script>
          document.getElementById('$id')?.addEventListener('click', () => {
            window.__flartNavHandlers?.[$i]?.();
          });
        </script>
      ''');
    }

    buffer.writeln('</div>');

    // JS handler registration
    buffer.writeln('<script>window.__flartNavHandlers = {};</script>');
    for (int i = 0; i < items.length; i++) {
      final jsFunc = onTap != null ? onTap!(i) : '';
      buffer.writeln('''
        <script>
          window.__flartNavHandlers[$i] = function() {
            $jsFunc
          };
        </script>
      ''');
    }

    return buffer.toString();
  }
}
