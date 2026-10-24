import '../../../flartdart.dart';

/// A widget that rotates its child
class AnimatedRotation extends Widget {
  final Widget child;
  final double turns;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  const AnimatedRotation({
    required this.child,
    required this.turns,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final durationMs = duration.inMilliseconds;
    final degrees = turns * 360;
    final styles = <String, String>{
      'transform': 'rotate(${degrees}deg)',
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
