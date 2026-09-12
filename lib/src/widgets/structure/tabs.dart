import '../../../flartdart.dart';

/// A tab bar widget
class FDTabBar extends Widget {
  final List<Widget> tabs;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final FlartColor? indicatorColor;
  final FlartColor? labelColor;
  final FlartColor? unselectedLabelColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTabBar({
    required this.tabs,
    this.currentIndex = 0,
    this.onTap,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final themeColor = theme.textStyle.color;

    final indicator =
        indicatorColor?.toString() ?? theme.primaryColor.toString();
    final selected = labelColor?.toString() ?? theme.primaryColor.toString();
    final unselected = unselectedLabelColor?.toString() ??
        (themeColor is FlartColor
            ? themeColor.lerp(FlartColors.grey, 0.4).toString()
            : FlartColors.grey.toString());

    final styles = <String, String>{
      'display': 'flex',
      'border-bottom': '2px solid ${theme.dividerColor}',
      'transition': 'border-color 0.3s',
      'position': 'relative',
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

    for (var i = 0; i < tabs.length; i++) {
      final tab = tabs[i];
      final isSelected = i == currentIndex;

      final tabEvents = <String, void Function(dynamic)>{};
      if (onTap != null) {
        tabEvents['click'] = (e) => onTap!(i);
      }

      final tabChildren = <FlartNode>[
        tab.buildNode(context),
      ];

      if (isSelected) {
        tabChildren.add(FlartElementNode(
          'div',
          attributes: {'class': 'flart-tab-indicator'},
          styles: {
            'position': 'absolute',
            'bottom': '-2px',
            'left': '0',
            'right': '0',
            'height': '2px',
            'background-color': indicator,
          },
        ));
      }

      children.add(FlartElementNode(
        'div',
        id: 'tab-item-$i',
        attributes: {
          'class': 'tab-item${isSelected ? " selected" : ""}',
          'data-index': '$i',
          'role': 'tab',
          'aria-selected': isSelected ? 'true' : 'false',
        },
        styles: {
          'flex': '1',
          'padding': '12px 16px',
          'text-align': 'center',
          'cursor': 'pointer',
          'color': isSelected ? selected : unselected,
          'font-weight': isSelected ? 'bold' : 'normal',
          'position': 'relative',
          'transition': 'color 0.3s',
          'user-select': 'none',
        },
        events: tabEvents,
        children: tabChildren,
      ));
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-tab-bar', 'role': 'tablist'},
      styles: styles,
      children: children,
    );
  }
}

/// A tab view to display content for tabs
class FDTabBarView extends Widget {
  final List<Widget> children;
  final int currentIndex;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTabBarView({
    required this.children,
    this.currentIndex = 0,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= children.length) {
      return FlartElementNode(
        'div',
        children: [FlartTextNode('Invalid tab index')],
      );
    }

    final styles = <String, String>{
      'padding': '16px',
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

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-tab-view', 'role': 'tabpanel'},
      styles: styles,
      children: [children[currentIndex].buildNode(context)],
    );
  }
}
