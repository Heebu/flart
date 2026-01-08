import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

/// A tab bar widget
class FDTabBar extends Widget {
  final List<Widget> tabs;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final FlartColor? indicatorColor;
  final FlartColor? labelColor;
  final FlartColor? unselectedLabelColor;

  FDTabBar({
    required this.tabs,
    this.currentIndex = 0,
    this.onTap,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'tabbar_${DateTime.now().microsecondsSinceEpoch}';
    final indicator = indicatorColor?.toString() ?? '#6200ea';
    final selected = labelColor?.toString() ?? '#6200ea';
    final unselected = unselectedLabelColor?.toString() ?? '#757575';

    return '''
      <div id="$id" style="
        display: flex;
        border-bottom: 2px solid #e0e0e0;
        position: relative;
      ">
        ${tabs.asMap().entries.map((entry) {
      final index = entry.key;
      final tab = entry.value;
      final isSelected = index == currentIndex;

      String clickAttr = '';
      if (onTap != null) {
        final cbId = FlartCallbackManager.register(() => onTap!(index));
        clickAttr = 'onclick="window.__flartHandleClick(\'$cbId\')"';
      }

      return '''
            <div 
              class="tab-item" 
              data-index="$index"
              style="
                flex: 1;
                padding: 12px 16px;
                text-align: center;
                cursor: pointer;
                color: ${isSelected ? selected : unselected};
                font-weight: ${isSelected ? 'bold' : 'normal'};
                position: relative;
                transition: color 0.3s;
              "
              $clickAttr
            >
              ${tab.render(context)}
              ${isSelected ? '''
                <div style="
                  position: absolute;
                  bottom: -2px;
                  left: 0;
                  right: 0;
                  height: 2px;
                  background-color: $indicator;
                "></div>
              ''' : ''}
            </div>
          ''';
    }).join()}
      </div>
    ''';
  }
}

/// A tab view to display content for tabs
class FDTabBarView extends Widget {
  final List<Widget> children;
  final int currentIndex;

  FDTabBarView({
    required this.children,
    this.currentIndex = 0,
  });

  @override
  String render(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= children.length) {
      return '<div>Invalid tab index</div>';
    }

    return '''
      <div style="padding: 16px;">
        ${children[currentIndex].render(context)}
      </div>
    ''';
  }
}
