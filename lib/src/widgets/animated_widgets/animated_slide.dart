import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Flutter compatibility typedefs
typedef FDAnimatedSlide = AnimatedSlide;

/// A widget that animates the translation of its child.
/// Follows Flutter's [AnimatedSlide] specification.
class AnimatedSlide extends Widget {
  final Widget child;
  final Offset offset;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  const AnimatedSlide({
    required this.child,
    required this.offset,
    required this.duration,
    this.curve = Curves.linear,
    this.onEnd,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final xPercent = offset.dx * 100;
    final yPercent = offset.dy * 100;

    final styles = <String, String>{
      'display': 'inline-block',
      'transform': 'translate($xPercent%, $yPercent%)',
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
