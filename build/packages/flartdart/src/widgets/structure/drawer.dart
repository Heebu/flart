import '../../../flartdart.dart';

class FDDrawer extends Widget {
  final Widget child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDrawer({
    required this.child,
    this.cssStyle,
    this.rawCss,
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

    final style =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div style="$style ${rawCss ?? ''}">
        ${child.render(context)}
      </div>
    ''';
  }
}


//FDGestureDetector(
//   onTap: () => "toggleDrawer();",
//   child: FDIcon(FDIcons.menu),
// )


