import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef FDAnimatedSize = AnimatedSize;

/// A widget that animates its size to match the size of its child.
/// Follows Flutter's [AnimatedSize] specification.
class AnimatedSize extends Widget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;
  final VoidCallback? onEnd;

  const AnimatedSize({
    required this.child,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.onEnd,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final styles = <String, String>{
      'transition':
          'width ${durationMs}ms ${curve.toCss()}, height ${durationMs}ms ${curve.toCss()}',
      'overflow': 'hidden',
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
