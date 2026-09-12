import '../../../flartdart.dart';

class FDPositioned extends Widget {
  final Widget child;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDPositioned({
    required this.child,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  const FDPositioned.fill({
    required this.child,
    this.top = 0.0,
    this.left = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.width,
    this.height,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'position': 'absolute',
      if (top != null) 'top': '${top}px',
      if (left != null) 'left': '${left}px',
      if (right != null) 'right': '${right}px',
      if (bottom != null) 'bottom': '${bottom}px',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styleMap[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styleMap,
      children: [child.buildNode(context)],
    );
  }
}
