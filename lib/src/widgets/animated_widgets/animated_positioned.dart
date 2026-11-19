import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Flutter compatibility typedefs
typedef FDAnimatedPositioned = AnimatedPositioned;

/// A widget that animates its position within a [Stack].
/// Follows Flutter's [AnimatedPositioned] specification.
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
  final VoidCallback? onEnd;

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
    this.onEnd,
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

    final events = <String, void Function(web.Event)>{};
    if (onEnd != null) {
      events['transitionend'] = (e) => onEnd!();
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      key: key?.toString(),
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: [child.buildNode(context)],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
