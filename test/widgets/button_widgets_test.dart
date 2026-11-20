@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Category 5: Button & Interaction Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDElevatedButton triggers onPressed and applies ButtonStyle', () {
      bool pressed = false;
      final btn = FDElevatedButton(
        onPressed: () {
          pressed = true;
        },
        style: ButtonStyle(
          backgroundColor: FlartColor('#2563eb'),
          foregroundColor: FlartColor('#ffffff'),
          elevation: 4.0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: BorderRadius.circular(8),
        ),
        child: FDText('Submit'),
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('button'));
      expect(root.textContent, contains('Submit'));
      expect(root.style.backgroundColor, contains('rgb(37, 99, 235)'));
      expect(root.style.boxShadow, contains('rgba(0, 0, 0, 0.18)'));
      expect(root.style.cursor, equals('pointer'));

      TestUtils.click(root);
      expect(pressed, isTrue);
    });

    test('FDElevatedButton disabled state when onPressed is null', () {
      final btn = FDElevatedButton(
        onPressed: null,
        child: FDText('Disabled'),
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.hasAttribute('disabled'), isTrue);
      expect(root.style.cursor, equals('not-allowed'));
      expect(root.style.opacity, equals('0.7'));
    });

    test('FDElevatedButton.icon creates composite row with icon and label', () {
      bool pressed = false;
      final btn = FDElevatedButton.icon(
        onPressed: () => pressed = true,
        icon: FDIcon(icon: FDIcons.favorite, size: 18),
        label: FDText('Like'),
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.textContent, contains('Like'));
      expect(root.getElementsByTagName('i').length, greaterThanOrEqualTo(1));

      TestUtils.click(root);
      expect(pressed, isTrue);
    });

    test('FDOutlinedButton renders outline border and handles tap', () {
      bool pressed = false;
      final btn = FDOutlinedButton(
        onPressed: () => pressed = true,
        style: ButtonStyle(
          foregroundColor: FlartColor('#059669'),
          side: BorderSide(color: FlartColor('#059669'), width: 2),
          shape: BorderRadius.circular(10),
        ),
        child: FDText('Save Draft'),
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('button'));
      expect(root.style.border, contains('2px solid'));
      expect(root.style.borderRadius, equals('10px'));

      TestUtils.click(root);
      expect(pressed, isTrue);
    });

    test('FDOutlinedButton.icon creates composite outlined button', () {
      final btn = FDOutlinedButton.icon(
        onPressed: () {},
        icon: FDIcon(icon: FDIcons.star, size: 18),
        label: FDText('Star'),
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.textContent, contains('Star'));
      expect(root.getElementsByTagName('i').length, greaterThanOrEqualTo(1));
    });

    test('FDTextButton renders text action with no border and transparent bg',
        () {
      bool pressed = false;
      final btn = FDTextButton(
        onPressed: () => pressed = true,
        label: 'Cancel Action',
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('button'));
      expect(root.textContent, contains('Cancel Action'));
      expect(root.style.border.isEmpty || root.style.border.contains('none'),
          isTrue);
      expect(root.style.backgroundColor, equals('transparent'));

      TestUtils.click(root);
      expect(pressed, isTrue);
    });

    test('FDIconButton renders circular button with tooltip and icon', () {
      bool pressed = false;
      final btn = FDIconButton(
        icon: FDIcon(icon: FDIcons.settings, size: 24),
        tooltip: 'Application Settings',
        onPressed: () => pressed = true,
      );

      final root = TestUtils.mountWidget(btn) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('button'));
      expect(root.getAttribute('title'), equals('Application Settings'));
      expect(root.style.borderRadius, equals('50%'));

      TestUtils.click(root);
      expect(pressed, isTrue);
    });

    test('FDInkWell triggers onTap, onDoubleTap, and onHover callbacks', () {
      bool tapped = false;
      bool doubleTapped = false;
      bool? hoverState;

      final inkWell = FDInkWell(
        onTap: () => tapped = true,
        onDoubleTap: () => doubleTapped = true,
        onHover: (val) => hoverState = val,
        borderRadius: BorderRadius.circular(12),
        child: FDText('Interactive Tile'),
      );

      final root = TestUtils.mountWidget(inkWell) as web.HTMLElement;
      expect(root.style.cursor, equals('pointer'));
      expect(root.style.borderRadius, equals('12px'));

      TestUtils.click(root);
      expect(tapped, isTrue);

      root.dispatchEvent(web.MouseEvent('dblclick'));
      expect(doubleTapped, isTrue);

      root.dispatchEvent(web.MouseEvent('mouseenter'));
      expect(hoverState, isTrue);

      root.dispatchEvent(web.MouseEvent('mouseleave'));
      expect(hoverState, isFalse);
    });

    test('FDGestureDetector handles tap, double tap, and contextmenu', () {
      bool tapped = false;
      bool doubleTapped = false;
      bool menuOpened = false;

      final detector = FDGestureDetector(
        onTap: () => tapped = true,
        onDoubleTap: () => doubleTapped = true,
        onContextMenu: () => menuOpened = true,
        behavior: HitTestBehavior.opaque,
        child: FDText('Gesture Target'),
      );

      final root = TestUtils.mountWidget(detector) as web.HTMLElement;
      expect(root.style.pointerEvents, equals('all'));
      expect(root.style.cursor, equals('pointer'));

      TestUtils.click(root);
      expect(tapped, isTrue);

      root.dispatchEvent(web.MouseEvent('dblclick'));
      expect(doubleTapped, isTrue);

      root.dispatchEvent(web.MouseEvent('contextmenu'));
      expect(menuOpened, isTrue);
    });

    test('ButtonStyle copyWith and styleFrom create and merge properties', () {
      final style = ButtonStyle.styleFrom(
        backgroundColor: FlartColor('#ff0000'),
        elevation: 2.0,
      );
      final derived = style.copyWith(
        elevation: 6.0,
        foregroundColor: FlartColor('#ffffff'),
      );

      expect(style.backgroundColor, equals(FlartColor('#ff0000')));
      expect(style.elevation, equals(2.0));
      expect(style.foregroundColor, isNull);

      expect(derived.backgroundColor, equals(FlartColor('#ff0000')));
      expect(derived.elevation, equals(6.0));
      expect(derived.foregroundColor, equals(FlartColor('#ffffff')));
    });
  });
}
