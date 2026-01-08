
import '../../../flartdart.dart';

class FDDrawer extends Widget {
  final Widget child;
  final Map<String, String>? cssStyle;

  const FDDrawer({
    required this.child,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styleMap = {
      'width': '250px',
      'height': '100%',
      'background-color': 'white',
      'overflow-y': 'auto',
      ...?cssStyle,
    };

    final style = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div style="$style">
        ${child.render(context)}
      </div>
    ''';
  }


}


//FDGestureDetector(
//   onTap: () => "toggleDrawer();",
//   child: FDIcon(FDIcons.menu),
// )


