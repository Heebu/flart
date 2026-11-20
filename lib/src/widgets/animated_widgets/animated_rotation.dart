import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef FDAnimatedRotation = AnimatedRotation;

/// A widget that animates the rotation of its child.
/// Follows Flutter's [AnimatedRotation] specification.
class AnimatedRotation extends Widget {
  final Widget child;
  final double turns;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;
  final VoidCallback? onEnd;

  const AnimatedRotation({
    required this.child,
    required this.turns,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.onEnd,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final degrees = turns * 360;
    final origin = alignment.toTransformOrigin();

    final styles = <String, String>{
      'display': 'inline-block',
      'transform': 'rotate(${degrees}deg)',
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
