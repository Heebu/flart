import '../../../flartdart.dart';

class FDColumn extends Widget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDColumn({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final styleMap = <String, String>{
      'display': 'flex',
      'flex-direction': 'FDColumn',
      'justify-content': _mapMainAxis(mainAxisAlignment),
      'align-items': _mapCrossAxis(crossAxisAlignment),
      ...?cssStyle,
    };

    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final childrenHtml = children.map((child) => child.render(context)).join();

    return '<div style="$styleString ${rawCss ?? ''}">$childrenHtml</div>';
  }

  String _mapMainAxis(MainAxisAlignment value) {
    switch (value) {
      case MainAxisAlignment.center:
        return 'center';
      case MainAxisAlignment.end:
        return 'flex-end';
      case MainAxisAlignment.spaceBetween:
        return 'space-between';
      case MainAxisAlignment.spaceAround:
        return 'space-around';
      case MainAxisAlignment.spaceEvenly:
        return 'space-evenly';
      case MainAxisAlignment.start:
        return 'flex-start';
    }
  }

  String _mapCrossAxis(CrossAxisAlignment value) {
    switch (value) {
      case CrossAxisAlignment.center:
        return 'center';
      case CrossAxisAlignment.end:
        return 'flex-end';
      case CrossAxisAlignment.stretch:
        return 'stretch';
      case CrossAxisAlignment.start:
        return 'flex-start';
    }
  }
}
