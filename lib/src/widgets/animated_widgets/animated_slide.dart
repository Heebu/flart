import '../../../flartdart.dart';

/// A widget that slides its child in and out
class AnimatedSlide extends Widget {
  final Widget child;
  final Offset offset;
  final Duration duration;
  final Curve curve;

  const AnimatedSlide({
    required this.child,
    required this.offset,
    required this.duration,
    this.curve = Curves.linear,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final xPercent = offset.dx * 100;
    final yPercent = offset.dy * 100;
    final styles = <String, String>{
      'transform': 'translate($xPercent%, $yPercent%)',
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
