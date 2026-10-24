import '../../../flartdart.dart';

/// A widget that animates its size
class AnimatedSize extends Widget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  const AnimatedSize({
    required this.child,
    required this.duration,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
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
