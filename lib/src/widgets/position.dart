import 'widget.dart';

class Positioned extends Widget {
  final Widget child;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  Positioned({
    required this.child,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  String render() {
    final styleMap = <String, String>{
      'position': 'absolute',
      if (top != null) 'top': '${top}px',
      if (left != null) 'left': '${left}px',
      if (right != null) 'right': '${right}px',
      if (bottom != null) 'bottom': '${bottom}px',
    };

    final styleString = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$styleString">${child.render()}</div>';
  }
}
