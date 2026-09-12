@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Basic & Display Widgets', () {
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
      expect(root.style.color, equals('rgb(255, 0, 0)'));
      expect(root.style.fontWeight, equals('bold'));
    });

    test('FDRichText renders formatted text spans', () {
      final widget = FDRichText(
        text: TextSpan(
          text: 'Hello ',
          style: TextStyle(fontSize: 16, color: FlartColor('#000000')),
          children: [
            TextSpan(
              text: 'World',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: FlartColor('#ff0000')),
            ),
          ],
        ),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, equals('Hello World'));
      final spans = root.getElementsByTagName('span');
      expect(spans.length, greaterThanOrEqualTo(1));
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

      final childSpan = root.firstElementChild as web.HTMLElement;
      expect(childSpan.tagName.toLowerCase(), equals('span'));
      expect(childSpan.textContent, equals('Inside'));
    });

    test('FDIcon renders correctly with icon name and size', () {
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

    test('FDCard renders with shadow and border radius', () {
      final card = FDCard(
        elevation: 4.0,
        color: FlartColor('#ffffff'),
        child: FDText('Card content'),
      );

      final root = TestUtils.mountWidget(card) as web.HTMLElement;
      expect(root.textContent, contains('Card content'));
      expect(root.style.borderRadius, isNotEmpty);
      expect(root.style.boxShadow, isNotEmpty);
    });

    test('FDDivider and FDVerticalDivider render lines', () {
      final divider = FDDivider(thickness: 2.0, color: FlartColor('#cccccc'));
      final rootH = TestUtils.mountWidget(divider) as web.HTMLElement;
      expect(rootH.tagName.toLowerCase(), equals('hr'));

      TestUtils.unmountWidget();

      final vDivider = FDVerticalDivider(width: 10.0, thickness: 2.0, color: FlartColor('#cccccc'));
      final rootV = TestUtils.mountWidget(vDivider) as web.HTMLElement;
      expect(rootV.style.width, equals('2px'));
      expect(rootV.style.display, equals('inline-block'));
    });

    test('FDChip and FDBadge render with text and event triggers', () {
      bool deleted = false;
      final chip = FDChip(
        label: FDText('Filter'),
        onDeleted: () {
          deleted = true;
        },
      );

      final rootChip = TestUtils.mountWidget(chip) as web.HTMLElement;
      expect(rootChip.textContent, contains('Filter'));

      final deleteBtn = rootChip.querySelector('.flart-chip-delete') as web.HTMLElement?;
      expect(deleteBtn, isNotNull);
      TestUtils.click(deleteBtn!);
      expect(deleted, isTrue);

      TestUtils.unmountWidget();

      final badge = FDBadge(
        label: FDText('3'),
        child: FDIcon(icon: FDIcons.notifications),
      );
      final rootBadge = TestUtils.mountWidget(badge) as web.HTMLElement;
      expect(rootBadge.textContent, contains('3'));
    });

    test('FDCircularProgressIndicator and FDLinearProgressIndicator render', () {
      final circular = FDCircularProgressIndicator(value: 0.75);
      final rootCirc = TestUtils.mountWidget(circular) as web.HTMLElement;
      expect(rootCirc.getAttribute('role'), equals('progressbar'));

      TestUtils.unmountWidget();

      final linear = FDLinearProgressIndicator(value: 0.5);
      final rootLin = TestUtils.mountWidget(linear) as web.HTMLElement;
      expect(rootLin.getElementsByTagName('div').length, greaterThanOrEqualTo(1));
    });

    test('FDAspectRatio sets correct aspect ratio CSS', () {
      final widget = FDAspectRatio(
        aspectRatio: 16 / 9,
        child: FDText('16:9 box'),
      );
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.aspectRatio, contains('1.777'));
    });

    test('FDClipRRect and FDClipOval apply overflow hidden and border radius', () {
      final clipRRect = FDClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FDText('Clipped'),
      );
      final rootRRect = TestUtils.mountWidget(clipRRect) as web.HTMLElement;
      expect(rootRRect.style.overflow, equals('hidden'));
      expect(rootRRect.style.borderRadius, contains('12px'));

      TestUtils.unmountWidget();

      final clipOval = FDClipOval(child: FDText('Oval'));
      final rootOval = TestUtils.mountWidget(clipOval) as web.HTMLElement;
      expect(rootOval.style.borderRadius, equals('50%'));
      expect(rootOval.style.overflow, equals('hidden'));
    });

    test('FDOpacity sets opacity CSS', () {
      final widget = FDOpacity(
        opacity: 0.65,
        child: FDText('Semi transparent'),
      );
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.opacity, equals('0.65'));
    });

    test('FDRotatedBox applies rotate transform', () {
      final widget = FDRotatedBox(
        quarterTurns: 2,
        child: FDText('Rotated'),
      );
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.transform, contains('rotate(180deg)'));
    });

    test('FDPlaceholder renders SVG box with fallback dimensions', () {
      final widget = FDPlaceholder(
        fallbackWidth: 200,
        fallbackHeight: 150,
      );
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.width, equals('200px'));
      expect(root.style.height, equals('150px'));
      expect(root.getElementsByTagName('svg').length, equals(1));
    });
  });
}
