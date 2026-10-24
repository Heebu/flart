import '../../../flartdart.dart';

/// A widget that animates its position
class AnimatedPositioned extends Widget {
  final Widget child;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  final Duration duration;
  final Curve curve;

  const AnimatedPositioned({
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required this.duration,
    this.curve = Curves.linear,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final styles = <String, String>{
      'position': 'absolute',
      'transition': 'all ${durationMs}ms ${curve.toCss()}',
      if (left != null) 'left': '${left}px',
      if (top != null) 'top': '${top}px',
      if (right != null) 'right': '${right}px',
      if (bottom != null) 'bottom': '${bottom}px',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
    };

    return FlartElementNode(
      'div',
      id: key?.toString(),
      key: key?.toString(),
      styles: styles,
      children: [child.buildNode(context)],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
