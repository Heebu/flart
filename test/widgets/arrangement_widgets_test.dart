@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Arrangement & Layout Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDRow arranges children horizontally in a flex container', () {
      final widget = FDRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FDText('Item 1'),
          FDText('Item 2'),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.display, equals('flex'));
      expect(root.style.flexDirection, equals('row'));
      expect(root.style.justifyContent, equals('space-between'));
      expect(root.style.alignItems, equals('center'));
      expect(root.children.length, equals(2));
    });

    test('FDColumn arranges children vertically in a flex container', () {
      final widget = FDColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FDText('Top'),
          FDText('Bottom'),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.display, equals('flex'));
      expect(root.style.flexDirection, equals('column'));
      expect(root.style.justifyContent, equals('center'));
      expect(root.style.alignItems, equals('stretch'));
      expect(root.children.length, equals(2));
    });

    test('FDStack and FDPositioned position children accurately', () {
      final widget = FDStack(
        children: [
          FDContainer(width: 300, height: 300, color: FlartColors.grey),
          FDPositioned(
            top: 20,
            left: 30,
            width: 50,
            height: 50,
            child: FDText('Positioned 1'),
          ),
          FDPositioned.fill(
            child: FDText('Filled child'),
          ),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.position, equals('relative'));

      final posChild = root.children.item(1) as web.HTMLElement;
      expect(posChild.style.position, equals('absolute'));
      expect(posChild.style.top, equals('20px'));
      expect(posChild.style.left, equals('30px'));
      expect(posChild.style.width, equals('50px'));
      expect(posChild.style.height, equals('50px'));

      final fillChild = root.children.item(2) as web.HTMLElement;
      expect(fillChild.style.top, equals('0px'));
      expect(fillChild.style.left, equals('0px'));
      expect(fillChild.style.right, equals('0px'));
      expect(fillChild.style.bottom, equals('0px'));
    });

    test('FDAlign aligns children using Alignment', () {
      final widget = FDAlign(
        alignment: Alignment.topRight,
        child: FDText('Aligned'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.display, equals('flex'));
      expect(root.style.justifyContent, equals('flex-end'));
      expect(root.style.alignItems, equals('flex-start'));
    });

    test('FDWrap wraps children with spacing and runSpacing', () {
      final widget = FDWrap(
        spacing: 12.0,
        runSpacing: 8.0,
        alignment: MainAxisAlignment.center,
        children: [
          FDText('Tag 1'),
          FDText('Tag 2'),
          FDText('Tag 3'),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.display, equals('flex'));
      expect(root.style.flexWrap, equals('wrap'));
      expect(root.style.columnGap, equals('12px'));
      expect(root.style.rowGap, equals('8px'));
      expect(root.children.length, equals(3));
    });

    test('FDCenter centers content both horizontally and vertically', () {
      final widget = FDCenter(
        child: FDText('Centered'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.display, equals('flex'));
      expect(root.style.justifyContent, equals('center'));
      expect(root.style.alignItems, equals('center'));
    });

    test('FDPadding sets padding around child', () {
      final widget = FDPadding(
        padding: const EdgeInsets.all(16.0),
        child: FDText('Padded'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.padding, contains('16px'));
    });

    test('SizedBox enforces exact dimensions', () {
      final widget = SizedBox(
        width: 150,
        height: 80,
        child: FDText('Fixed'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.style.width, equals('150px'));
      expect(root.style.height, equals('80px'));
    });

    test('Expanded assigns flex factor', () {
      final widget = FDRow(
        children: [
          Expanded(flex: 2, child: FDText('Double space')),
          Expanded(flex: 1, child: FDText('Single space')),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final child1 = root.children.item(0) as web.HTMLElement;
      final child2 = root.children.item(1) as web.HTMLElement;

      expect(child1.style.flex, contains('2'));
      expect(child2.style.flex, contains('1'));
    });

    test('FDRow and FDColumn support MainAxisSize.min and MainAxisSize.max', () {
      final rowMin = const FDRow(
        mainAxisSize: MainAxisSize.min,
        children: [FDText('A'), FDText('B')],
      );
      final rootRowMin = TestUtils.mountWidget(rowMin) as web.HTMLElement;
      expect(rootRowMin.style.width, equals('fit-content'));

      final rowMax = const FDRow(
        mainAxisSize: MainAxisSize.max,
        children: [FDText('A'), FDText('B')],
      );
      final rootRowMax = TestUtils.mountWidget(rowMax) as web.HTMLElement;
      expect(rootRowMax.style.width, equals('100%'));

      final colMin = const FDColumn(
        mainAxisSize: MainAxisSize.min,
        children: [FDText('1'), FDText('2')],
      );
      final rootColMin = TestUtils.mountWidget(colMin) as web.HTMLElement;
      expect(rootColMin.style.height, equals('fit-content'));
    });

    test('FDCenter and FDAlign support widthFactor and heightFactor', () {
      final centerWithFactors = const FDCenter(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: FDText('Half Centered'),
      );
      final rootCenter = TestUtils.mountWidget(centerWithFactors) as web.HTMLElement;
      expect(rootCenter.style.width, equals('50%'));
      expect(rootCenter.style.height, equals('50%'));
      expect(rootCenter.style.boxSizing, equals('border-box'));

      final alignWithFactors = const FDAlign(
        alignment: Alignment.bottomRight,
        widthFactor: 0.8,
        heightFactor: 0.6,
        child: FDText('Aligned'),
      );
      final rootAlign = TestUtils.mountWidget(alignWithFactors) as web.HTMLElement;
      expect(rootAlign.style.width, equals('80%'));
      expect(rootAlign.style.height, equals('60%'));
    });

    test('FDStack supports fit and clipBehavior', () {
      final stack = const FDStack(
        fit: StackFit.expand,
        clipBehavior: Clip.antiAlias,
        children: [
          FDText('Layer 1'),
          FDPositioned(top: 0, left: 0, child: FDText('Layer 2')),
        ],
      );
      final rootStack = TestUtils.mountWidget(stack) as web.HTMLElement;
      expect(rootStack.style.width, equals('100%'));
      expect(rootStack.style.height, equals('100%'));
      expect(rootStack.style.overflow, equals('hidden'));
      expect(rootStack.style.boxSizing, equals('border-box'));
    });

    test('FDListView supports shrinkWrap and reverse', () {
      final listShrink = FDListView(
        shrinkWrap: true,
        children: const [FDText('Item 1'), FDText('Item 2')],
      );
      final rootShrink = TestUtils.mountWidget(listShrink) as web.HTMLElement;
      expect(rootShrink.style.height, equals('auto'));
      expect(rootShrink.style.overflow, equals('visible'));

      final listReverse = FDListView(
        reverse: true,
        children: const [FDText('1'), FDText('2')],
      );
      final rootReverse = TestUtils.mountWidget(listReverse) as web.HTMLElement;
      expect(rootReverse.style.flexDirection, equals('column-reverse'));
    });

    test('FDListView.separated generates separators between items', () {
      final separated = FDListView.separated(
        itemCount: 3,
        itemBuilder: (context, i) => FDText('Item $i'),
        separatorBuilder: (context, i) => const FDDivider(),
      );
      final root = TestUtils.mountWidget(separated) as web.HTMLElement;
      // 3 items + 2 dividers = 5 elements
      expect(root.children.length, equals(5));
    });
  });
}
