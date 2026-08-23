import '../../../flartdart.dart';

/// A widget that rebuilds when the given [animation] changes value.
/// This is an abstract class; subclasses must implement [build].
abstract class AnimatedWidget extends StatefulWidget {
  final AnimationController animation;

  const AnimatedWidget({
    required this.animation,
    super.key,
  });

  @override
  State<AnimatedWidget> createState() => _AnimatedWidgetState();

  Widget build(BuildContext context);
}

class _AnimatedWidgetState extends State<AnimatedWidget> {
  @override
  void initState() {
    super.initState();
    widget.animation.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(AnimatedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation.removeListener(_handleChange);
      widget.animation.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.animation.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
