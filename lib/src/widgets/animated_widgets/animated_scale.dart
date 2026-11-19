import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Flutter compatibility typedefs
typedef FDAnimatedScale = AnimatedScale;

/// A widget that animates the scale of its child.
/// Follows Flutter's [AnimatedScale] specification.
class AnimatedScale extends Widget {
  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;
  final VoidCallback? onEnd;

  const AnimatedScale({
    required this.child,
    required this.scale,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.onEnd,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final origin = alignment.toTransformOrigin();

    final styles = <String, String>{
      'display': 'inline-block',
      'transform': 'scale($scale)',
      'transform-origin': origin,
      'transition': 'transform ${durationMs}ms ${curve.toCss()}',
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
