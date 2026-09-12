import '../../../flartdart.dart';
class AnimatedContainer extends Widget {
  final AnimationController controller;
  final FlartColor beginColor;
  final FlartColor endColor;
  final double beginWidth;
  final double endWidth;
  final double beginHeight;
  final double endHeight;
  final Widget? child;
  final Map<String, String>? cssStyle;

  AnimatedContainer({
    required this.controller,
    required this.beginColor,
    required this.endColor,
    required this.beginWidth,
    required this.endWidth,
    required this.beginHeight,
    required this.endHeight,
    this.child,
    this.cssStyle,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final progress = controller.value;
        final interpolatedColor = beginColor.lerp(endColor, progress);
        final currentWidth = beginWidth + (endWidth - beginWidth) * progress;
        final currentHeight = beginHeight + (endHeight - beginHeight) * progress;

        final mergedStyles = {
          'transition': 'none', // Managed by AnimationController
          'background-color': interpolatedColor.toString(),
          ...?cssStyle,
        };

        return FDContainer(
          width: currentWidth,
          height: currentHeight,
          cssStyle: mergedStyles,
          child: child,
        );
      },
    ).buildNode(context);
  }
}

//final controller = AnimationController(
//   duration: Duration(seconds: 2),
//   onUpdate: (_) {},
// );
//
// final animatedBox = AnimatedContainer(
//   controller: controller,
//   beginColor: FlartColor.hex('#42A5F5'),
//   endColor: FlartColor.hex('#AB47BC'),
//   beginWidth: 100,
//   endWidth: 300,
//   beginHeight: 100,
//   endHeight: 150,
// );
//
// // then call this when needed
// controller.forward();
