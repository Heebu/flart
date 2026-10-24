import '../../../flartdart.dart';

/// A widget that scales its child
class AnimatedScale extends Widget {
  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  const AnimatedScale({
    required this.child,
    required this.scale,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final styles = <String, String>{
      'transform': 'scale($scale)',
      'transform-origin': 'center',
      'transition': 'transform ${durationMs}ms ${curve.toCss()}',
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
