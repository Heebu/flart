import '../../../flartdart.dart';

typedef TransitionBuilder = Widget Function(BuildContext context, Widget? child);

/// A widget that rebuilds when the given [animation] changes value.
/// It uses a StatefulWidget internally to listen to the animation.
class AnimatedBuilder extends StatefulWidget {
  final AnimationController animation;
  final TransitionBuilder builder;
  final Widget? child;

  const AnimatedBuilder({
    required this.animation,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  State<AnimatedBuilder> createState() => _AnimatedBuilderState();
}

class _AnimatedBuilderState extends State<AnimatedBuilder> {
  @override
  void initState() {
    super.initState();
    widget.animation.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(AnimatedBuilder oldWidget) {
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
    return widget.builder(context, widget.child);
  }
}
