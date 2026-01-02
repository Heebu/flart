import '../../../flart.dart';
import 'dart:html';

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
  String render(BuildContext context) {
    final id = 'animated_container_${DateTime.now().millisecondsSinceEpoch}';

    // Create the initial container with base styles
    final initialStyle = {
      'width': '${beginWidth}px',
      'height': '${beginHeight}px',
      'background-color': beginColor.toString(),
      'transition': 'none', // No CSS transitions, we'll animate manually
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    // Initialize the container HTML
    final containerHtml = '''
      <div id="$id" style="$initialStyle">
        ${child?.render(context) ?? ''}
      </div>
    ''';

    // Schedule the animation updates
    controller.addListener(() {
      // Update the animation container styles on each controller value change
      _animateContainer(id, controller);
    });

    // Perform the first animation immediately
    _animateContainer(id, controller);

    return containerHtml;
  }

  // Function to animate the container based on the controller's progress
  void _animateContainer(String id, AnimationController controller) {
    final progress = controller.value; // Get the current progress

    // Interpolate the color and size based on the progress
    final interpolatedColor = beginColor.lerp(endColor, progress);
    final currentWidth = beginWidth + (endWidth - beginWidth) * progress;
    final currentHeight = beginHeight + (endHeight - beginHeight) * progress;

    // Get the container element and update its style
    final container = document.getElementById(id);
    if (container != null) {
      container.style
        ..backgroundColor = interpolatedColor.toString()
        ..width = '${currentWidth}px'
        ..height = '${currentHeight}px';
    }
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