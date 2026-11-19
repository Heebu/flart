@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Animation & Effect Widgets (Category 7)', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDAnimatedContainer renders CSS transitions and properties', () {
      final widget = FDAnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: const FlartColor('#3b82f6'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const FDText('Animated Box'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.width, equals('150px'));
      expect(root.style.height, equals('100px'));
      expect(root.style.backgroundColor, contains('rgb(59, 130, 246)'));
      expect(root.style.transition, contains('500ms'));
      expect(root.textContent, contains('Animated Box'));
    });

    test('AnimatedOpacity renders CSS transitions for opacity', () {
      final widget = AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        opacity: 0.65,
        child: const FDText('Fading Text'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.opacity, equals('0.65'));
      expect(root.style.transition, contains('opacity 300ms'));
      expect(root.textContent, contains('Fading Text'));
    });

    test('AnimatedPositioned sets absolute position and transition', () {
      final widget = AnimatedPositioned(
        duration: const Duration(milliseconds: 400),
        left: 25,
        top: 50,
        width: 80,
        height: 80,
        child: const FDText('Positioned Box'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.position, equals('absolute'));
      expect(root.style.left, equals('25px'));
      expect(root.style.top, equals('50px'));
      expect(root.style.width, equals('80px'));
      expect(root.style.height, equals('80px'));
      expect(root.style.transition, contains('400ms'));
    });

    test('AnimatedRotation rotates child with CSS transform', () {
      final widget = AnimatedRotation(
        duration: const Duration(milliseconds: 250),
        turns: 0.5, // 180 degrees
        alignment: Alignment.center,
        child: const FDText('Rotated Text'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.transform, contains('rotate(180deg)'));
      expect(root.style.transition, contains('transform 250ms'));
      expect(root.style.transformOrigin, contains('center'));
    });

    test('AnimatedScale scales child with CSS transform', () {
      final widget = AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: 1.75,
        child: const FDText('Scaled Text'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.transform, contains('scale(1.75)'));
      expect(root.style.transition, contains('transform 200ms'));
    });

    test('AnimatedSlide translates child with CSS percent transform', () {
      final widget = AnimatedSlide(
        duration: const Duration(milliseconds: 350),
        offset: const Offset(0.5, -0.25),
        child: const FDText('Slide Text'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.transform, contains('translate(50%, -25%)'));
      expect(root.style.transition, contains('transform 350ms'));
    });

    test('AnimatedSize sets CSS width and height transitions', () {
      final widget = const AnimatedSize(
        duration: Duration(milliseconds: 300),
        child: FDText('Sized Content'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.transition, contains('width 300ms'));
      expect(root.style.transition, contains('height 300ms'));
      expect(root.style.overflow, equals('hidden'));
    });

    test('AnimatedCrossFade cross-fades between two children using VDOM', () {
      final widget1 = AnimatedCrossFade(
        duration: const Duration(milliseconds: 400),
        crossFadeState: CrossFadeState.showFirst,
        firstChild: const FDText('First Child'),
        secondChild: const FDText('Second Child'),
      );

      final root1 = TestUtils.mountWidget(widget1) as web.HTMLElement;
      final divs1 = root1.querySelectorAll('div');
      expect(divs1.length, greaterThanOrEqualTo(2));
      final firstDiv1 = divs1.item(0) as web.HTMLElement;
      final secondDiv1 = divs1.item(1) as web.HTMLElement;
      expect(firstDiv1.style.opacity, equals('1'));
      expect(secondDiv1.style.opacity, equals('0'));

      TestUtils.unmountWidget();

      final widget2 = AnimatedCrossFade(
        duration: const Duration(milliseconds: 400),
        crossFadeState: CrossFadeState.showSecond,
        firstChild: const FDText('First Child'),
        secondChild: const FDText('Second Child'),
      );

      final root2 = TestUtils.mountWidget(widget2) as web.HTMLElement;
      final divs2 = root2.querySelectorAll('div');
      final firstDiv2 = divs2.item(0) as web.HTMLElement;
      final secondDiv2 = divs2.item(1) as web.HTMLElement;
      expect(firstDiv2.style.opacity, equals('0'));
      expect(secondDiv2.style.opacity, equals('1'));
    });

    test('Curves extension serializes accurately to CSS', () {
      expect(Curves.linear.toCss(), equals('linear'));
      expect(Curves.easeInOut.toCss(), contains('cubic-bezier'));
      expect(Curves.fastOutSlowIn.toCss(), contains('cubic-bezier(0.4, '));
      expect(Curves.decelerate.toCss(), contains('0.2, 1'));
    });

    test('Hero renders child and registers DOM reference', () {
      final widget = const Hero(
        tag: 'profile-pic',
        child: FDText('Hero Content'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Hero Content'));
    });
  });
}
