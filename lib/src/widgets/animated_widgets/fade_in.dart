import '../../../flartdart.dart';

/// A widget that fades in its child when it first appears
class FadeIn extends Widget {
  final Widget child;
  final Duration duration;
  final Duration? delay;
  final Curve curve;

  const FadeIn({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay,
    this.curve = Curves.ease,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return FDAnimate(
      key: key,
      fadeIn: true,
      duration: duration,
      delay: delay ?? Duration.zero,
      child: child,
    ).buildNode(context);
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
