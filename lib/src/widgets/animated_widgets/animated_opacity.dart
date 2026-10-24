import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// A widget that animates its opacity over time
class AnimatedOpacity extends Widget {
  final Widget child;
  final double opacity;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  const AnimatedOpacity({
    required this.child,
    required this.opacity,
    required this.duration,
    this.curve = Curves.linear,
    this.onEnd,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final styles = <String, String>{
      'opacity': opacity.clamp(0.0, 1.0).toString(),
      'transition': 'opacity ${durationMs}ms ${curve.toCss()}',
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
