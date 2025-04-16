
import '../../../flart.dart';

class Drawer extends Widget {
  final Widget child;
  final Map<String, String>? cssStyle;

  const Drawer({
    required this.child,
    this.cssStyle,
  });

  @override
  String render() {
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
        ${child.render()}
      </div>
    ''';
  }
}


//GestureDetector(
//   onTap: () => "toggleDrawer();",
//   child: Icon(Icons.menu),
// )