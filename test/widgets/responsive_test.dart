import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Responsive & Adaptive Layout Parity Tests', () {
    test('MediaQuery provides width, height, and ScreenSize', () {
      final mq = MediaQuery.of();
      expect(mq.width, greaterThan(0));
      expect(mq.height, greaterThan(0));
      expect(mq.screenSize, isIn([ScreenSize.small, ScreenSize.medium, ScreenSize.large]));
      expect(mq.orientationEnum, isIn([Orientation.portrait, Orientation.landscape]));
      expect(mq.size.width, equals(mq.width.toDouble()));
      expect(mq.size.height, equals(mq.height.toDouble()));
    });

    test('LayoutBuilder provides valid BoxConstraints', () {
      BoxConstraints? observedConstraints;

      final widget = LayoutBuilder(
        builder: (context, constraints) {
          observedConstraints = constraints;
          return Text('Max width: ${constraints.maxWidth.toInt()}');
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(observedConstraints, isNotNull);
      expect(observedConstraints!.maxWidth, greaterThan(0));
      expect(root.textContent, contains('Max width:'));
    });

    test('OrientationBuilder builds with valid orientation', () {
      Orientation? observedOrientation;

      final widget = OrientationBuilder(
        builder: (context, orientation) {
          observedOrientation = orientation;
          return Text('Orientation: ${orientation.name}');
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(observedOrientation, isNotNull);
      expect(root.textContent, contains('Orientation:'));
    });

    test('ResponsiveLayout selects appropriate builder for screen size', () {
      final widget = ResponsiveLayout(
        small: (context) => const Text('View: Small Mobile'),
        medium: (context) => const Text('View: Medium Tablet'),
        large: (context) => const Text('View: Large Desktop'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final text = root.textContent;
      expect(text, anyOf(
        contains('View: Small Mobile'),
        contains('View: Medium Tablet'),
        contains('View: Large Desktop'),
      ));
    });

    test('ResponsiveLayout builder mode passes context, screenSize, and constraints', () {
      ScreenSize? observedSize;
      BoxConstraints? observedConstraints;

      final widget = ResponsiveLayout(
        builder: (context, size, constraints) {
          observedSize = size;
          observedConstraints = constraints;
          return Text('Screen size: ${size.name}');
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(observedSize, isNotNull);
      expect(observedConstraints, isNotNull);
      expect(root.textContent, contains('Screen size:'));
    });
  });
}
