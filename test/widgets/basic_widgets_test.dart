@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Basic Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDText renders correctly with styles', () {
      final widget = FDText(
        'Hello Flart',
        style: TextStyle(
          fontSize: 24,
          color: FlartColor('#ff0000'),
          fontWeight: FontWeight.bold,
        ),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.tagName.toLowerCase(), equals('span'));
      expect(root.textContent, equals('Hello Flart'));
      expect(root.style.fontSize, equals('24px'));
      expect(
          root.style.color,
          equals(
              'rgb(255, 0, 0)')); // Browsers convert hex to rgb in computed styles
      expect(root.style.fontWeight, equals('bold'));
    });

    test('FDContainer renders correctly with constraints and decoration', () {
      final widget = FDContainer(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          color: FlartColor('#00ff00'),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FDText('Inside'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.tagName.toLowerCase(), equals('div'));
      expect(root.style.width, equals('100px'));
      expect(root.style.height, equals('200px'));
      expect(root.style.backgroundColor, equals('rgb(0, 255, 0)'));
      expect(root.style.borderRadius, equals('10px'));

      // Check child rendering
      final childSpan = root.firstElementChild as web.HTMLElement;
      expect(childSpan.tagName.toLowerCase(), equals('span'));
      expect(childSpan.textContent, equals('Inside'));
    });

    test('FDIcon renders correctly', () {
      final widget = FDIcon(
        icon: FDIcons.home,
        size: 32,
        color: FlartColor('#0000ff'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.tagName.toLowerCase(), equals('i'));
      expect(root.className, contains('material-icons'));
      expect(root.textContent?.trim(), equals('home'));
      expect(root.style.fontSize, equals('32px'));
      expect(root.style.color, equals('rgb(0, 0, 255)'));
    });
  });
}
