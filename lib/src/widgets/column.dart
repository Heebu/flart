import 'widget.dart';
import '../styles/axis_alignment.dart';

class Column extends Widget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Map<String, String>? cssStyle;

  Column({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.cssStyle,
  });

  @override
  String render() {
    final styleMap = <String, String>{
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': _mapMainAxis(mainAxisAlignment),
      'align-items': _mapCrossAxis(crossAxisAlignment),
      ...?cssStyle,
    };

    final styleString = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final childrenHtml = children.map((child) => child.render()).join();

    return '<div style="$styleString">$childrenHtml</div>';
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
      default:
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
      default:
        return 'flex-start';
    }
  }
}
