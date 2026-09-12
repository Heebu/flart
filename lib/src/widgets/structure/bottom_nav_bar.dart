import '../../../flartdart.dart';

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
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final styles = <String, String>{
      'display': 'flex',
      'justify-content': 'space-around',
      'align-items': 'center',
      'padding': '8px 0',
      'background-color': theme.cardColor.toString(),
      'box-shadow': '0 -1px 5px rgba(0,0,0,0.1)',
      'border-top': '1px solid ${theme.dividerColor}',
      'color': theme.textStyle.color.toString(),
      'width': '100%',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final children = <FlartNode>[];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final selected = i == currentIndex;

      final themeColor = theme.textStyle.color;
      final labelColor = selected
          ? theme.primaryColor
          : (themeColor is FlartColor
              ? themeColor.lerp(FlartColors.grey, 0.5)
              : FlartColors.grey);

      final itemEvents = <String, void Function(dynamic)>{};
      if (onTap != null) {
        itemEvents['click'] = (e) => onTap!(i);
      }

      final itemChildren = <FlartNode>[
        selected
            ? (item.activeIcon?.buildNode(context) ?? item.icon.buildNode(context))
            : item.icon.buildNode(context),
      ];

      if (item.label != null) {
        itemChildren.add(FlartElementNode(
          'div',
          styles: {
            'font-size': '12px',
            'color': labelColor.toString(),
            'margin-top': '4px',
            'font-weight': selected ? '600' : 'normal',
          },
          children: [FlartTextNode(item.label!)],
        ));
      }

      if (item.badge != null) {
        itemChildren.add(FlartElementNode(
          'div',
          styles: {'position': 'absolute', 'top': '0', 'right': '0'},
          children: [item.badge!.buildNode(context)],
        ));
      }

      children.add(FlartElementNode(
        'div',
        id: 'nav-item-$i',
        attributes: {
          'class': 'flart-nav-item${selected ? " selected" : ""}',
          'role': 'button',
          'tabindex': '0',
        },
        styles: {
          'position': 'relative',
          'cursor': 'pointer',
          'text-align': 'center',
          'padding': '4px 12px',
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'justify-content': 'center',
        },
        events: itemEvents,
        children: itemChildren,
      ));
    }

    return FlartElementNode(
      'nav',
      id: key?.toString(),
      attributes: {'class': 'flart-bottom-nav-bar'},
      styles: styles,
      children: children,
    );
  }
}
