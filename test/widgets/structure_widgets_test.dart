@TestOn('browser')

import 'dart:async';
import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Structure & Composite Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDListTile renders leading, title, subtitle, trailing and handles onTap', () {
      bool tapped = false;
      final widget = FDListTile(
        leading: FDIcon(icon: FDIcons.person),
        title: FDText('John Doe'),
        subtitle: FDText('Software Engineer'),
        trailing: FDIcon(icon: FDIcons.chevron_right),
        onTap: () {
          tapped = true;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('John Doe'));
      expect(root.textContent, contains('Software Engineer'));
      expect(root.getAttribute('role'), equals('listitem'));

      TestUtils.click(root);
      expect(tapped, isTrue);
    });

    test('FDCheckboxListTile toggles when clicked', () {
      bool checked = false;
      final widget = FDCheckboxListTile(
        value: checked,
        title: FDText('Accept terms'),
        onChanged: (val) {
          checked = val ?? false;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Accept terms'));

      TestUtils.click(root);
      expect(checked, isTrue);
    });

    test('FDSwitchListTile toggles switch when clicked', () {
      bool enabled = false;
      final widget = FDSwitchListTile(
        value: enabled,
        title: FDText('Dark mode'),
        onChanged: (val) {
          enabled = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Dark mode'));

      TestUtils.click(root);
      expect(enabled, isTrue);
    });

    test('FDAlertDialog renders title, content and action buttons', () {
      bool actionClicked = false;
      final widget = FDAlertDialog(
        title: FDText('Confirm Delete'),
        content: FDText('Are you sure you want to permanently delete this item?'),
        actions: [
          FDTextButton(
            onPressed: () {
              actionClicked = true;
            },
            child: FDText('Delete'),
          ),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.getAttribute('role'), equals('alertdialog'));
      expect(root.textContent, contains('Confirm Delete'));
      expect(root.textContent, contains('Are you sure'));

      final btn = root.querySelector('button') as web.HTMLElement?;
      expect(btn, isNotNull);
      TestUtils.click(btn!);
      expect(actionClicked, isTrue);
    });

    test('FDScaffold and FDAppBar render navigation and body', () {
      final widget = FDScaffold(
        appBar: FDAppBar(
          title: FDText('My Flart App'),
        ),
        body: FDCenter(
          child: FDText('Page Content'),
        ),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('My Flart App'));
      expect(root.textContent, contains('Page Content'));
    });

    test('FDBottomNavigationBar handles item selection', () {
      int? selectedIndex;
      final widget = FDBottomNavigationBar(
        currentIndex: 0,
        onTap: (idx) {
          selectedIndex = idx;
        },
        items: [
          FDBottomNavigationBarItem(icon: FDIcon(icon: FDIcons.home), label: 'Home'),
          FDBottomNavigationBarItem(icon: FDIcon(icon: FDIcons.settings), label: 'Settings'),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Home'));
      expect(root.textContent, contains('Settings'));

      final items = root.children;
      expect(items.length, equals(2));

      final settingsItem = items.item(1) as web.HTMLElement;
      TestUtils.click(settingsItem);
      expect(selectedIndex, equals(1));
    });

    test('FDDataTable renders columns and rows', () {
      final widget = FDDataTable<dynamic>(
        columns: const [
          FDDataColumn(label: FDText('Name')),
          FDDataColumn(label: FDText('Age')),
        ],
        rows: const [
          FDDataRow(cells: [
            FDDataCell(FDText('Alice')),
            FDDataCell(FDText('28')),
          ]),
          FDDataRow(cells: [
            FDDataCell(FDText('Bob')),
            FDDataCell(FDText('34')),
          ]),
        ],
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.querySelector('table'), isNotNull);
      expect(root.textContent, contains('Alice'));
      expect(root.textContent, contains('Bob'));
      expect(root.getElementsByTagName('tr').length, equals(3)); // header + 2 rows
    });

    test('showDialog opens overlay and closeDialog closes it returning result', () async {
      String? dialogResult;
      unawaited(showDialog<String>(
        builder: FDAlertDialog(
          title: const FDText('Alert Title'),
          actions: [
            FDTextButton(
              onPressed: () => closeDialog('Confirmed'),
              child: const FDText('OK'),
            ),
          ],
        ),
      ).then((res) => dialogResult = res));

      final overlay = web.document.querySelector('.flart-dialog-overlay') as web.HTMLElement?;
      expect(overlay, isNotNull);
      expect(overlay!.textContent, contains('Alert Title'));

      final okBtn = overlay.querySelector('button') as web.HTMLElement?;
      expect(okBtn, isNotNull);
      TestUtils.click(okBtn!);

      await TestUtils.pump(30);
      expect(web.document.querySelector('.flart-dialog-overlay'), isNull);
      expect(dialogResult, equals('Confirmed'));
    });

    test('FDMaterialApp updates activePage when home updates without active named routes', () {
      PageNavigator.reset();

      const homeV1 = FDText('Catalog Page 0');
      const homeV2 = FDText('Catalog Page 1');

      final appV1 = FDMaterialApp(
        title: 'Catalog',
        home: homeV1,
      );

      final root1 = TestUtils.mountWidget(appV1) as web.HTMLElement;
      expect(root1.textContent, contains('Catalog Page 0'));
      expect(PageNavigator.stackLength, equals(1));
      expect(PageNavigator.current, equals(homeV1));

      // Simulate parent setState (CatalogApp selectedIndex changed)
      final appV2 = FDMaterialApp(
        title: 'Catalog',
        home: homeV2,
      );

      final root2 = TestUtils.mountWidget(appV2) as web.HTMLElement;
      expect(root2.textContent, contains('Catalog Page 1'));
      expect(PageNavigator.stackLength, equals(1));
      expect(PageNavigator.current, equals(homeV2));
    });

    test('FDContainer enforces box-sizing and applies BoxConstraints', () {
      final container = FDContainer(
        width: 120,
        height: 80,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        child: const FDText('Bounded'),
      );

      final root = TestUtils.mountWidget(container) as web.HTMLElement;
      expect(root.style.boxSizing, equals('border-box'));
      expect(root.style.width, equals('120px'));
      expect(root.style.height, equals('80px'));
      expect(root.style.overflow, equals('hidden'));
    });

    test('FDDecoratedBox and FDColoredBox apply styles with box-sizing', () {
      final decBox = FDDecoratedBox(
        decoration: BoxDecoration(
          color: const FlartColor('#ff0000'),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const FDText('Decorated'),
      );

      final rootDec = TestUtils.mountWidget(decBox) as web.HTMLElement;
      expect(rootDec.style.boxSizing, equals('border-box'));
      expect(rootDec.style.backgroundColor, equals('rgb(255, 0, 0)'));
      expect(rootDec.style.borderRadius, equals('8px'));

      final colBox = const FDColoredBox(
        color: FlartColor('#00ff00'),
        child: FDText('Colored'),
      );

      final rootCol = TestUtils.mountWidget(colBox) as web.HTMLElement;
      expect(rootCol.style.boxSizing, equals('border-box'));
      expect(rootCol.style.backgroundColor, equals('rgb(0, 255, 0)'));
    });

    test('FDSizedBox supports named constructors shrink, expand, and square', () {
      final shrink = const FDSizedBox.shrink();
      final rootShrink = TestUtils.mountWidget(shrink) as web.HTMLElement;
      expect(rootShrink.style.width, equals('0px'));
      expect(rootShrink.style.height, equals('0px'));
      expect(rootShrink.style.boxSizing, equals('border-box'));

      final expand = const FDSizedBox.expand();
      final rootExpand = TestUtils.mountWidget(expand) as web.HTMLElement;
      expect(rootExpand.style.width, equals('100%'));
      expect(rootExpand.style.height, equals('100%'));

      final square = const FDSizedBox.square(dimension: 48);
      final rootSquare = TestUtils.mountWidget(square) as web.HTMLElement;
      expect(rootSquare.style.width, equals('48px'));
      expect(rootSquare.style.height, equals('48px'));
    });

    test('FDCard supports clipBehavior and border', () {
      final card = FDCard(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        border: Border.all(color: const FlartColor('#cccccc'), width: 1),
        child: const FDText('Clipped Card'),
      );

      final root = TestUtils.mountWidget(card) as web.HTMLElement;
      expect(root.style.boxSizing, equals('border-box'));
      expect(root.style.overflow, equals('hidden'));
      expect(root.style.borderRadius, equals('12px'));
      expect(root.style.border, contains('1px solid rgb(204, 204, 204)'));
    });

    test('FDFloatingActionButton renders circular standard, mini, and extended FAB', () {
      bool pressed = false;
      final fab = FDFloatingActionButton(
        onPressed: () => pressed = true,
        child: const FDIcon(icon: FDIcons.add),
      );

      final root = TestUtils.mountWidget(fab) as web.HTMLElement;
      expect(root.style.minWidth, equals('56px'));
      expect(root.style.minHeight, equals('56px'));
      expect(root.style.borderRadius, equals('28px'));
      expect(root.style.boxSizing, equals('border-box'));

      TestUtils.click(root);
      expect(pressed, isTrue);

      final miniFab = const FDFloatingActionButton(
        mini: true,
        child: FDIcon(icon: FDIcons.edit),
      );
      final rootMini = TestUtils.mountWidget(miniFab) as web.HTMLElement;
      expect(rootMini.style.minWidth, equals('40px'));
      expect(rootMini.style.minHeight, equals('40px'));

      final extFab = FDFloatingActionButton.extended(
        icon: const FDIcon(icon: FDIcons.send),
        label: const FDText('Send'),
      );
      final rootExt = TestUtils.mountWidget(extFab) as web.HTMLElement;
      expect(rootExt.textContent, contains('Send'));
      expect(rootExt.style.borderRadius, equals('16px'));
    });

    test('FDDivider and FDVerticalDivider enforce proper box model', () {
      const divider = FDDivider(thickness: 2, indent: 16, endIndent: 16);
      final rootH = TestUtils.mountWidget(divider) as web.HTMLElement;
      expect(rootH.style.height, equals('2px'));
      expect(rootH.style.boxSizing, equals('border-box'));
      expect(rootH.style.marginLeft, equals('16px'));
      expect(rootH.style.marginRight, equals('16px'));

      const vDivider = FDVerticalDivider(thickness: 1, width: 10);
      final rootV = TestUtils.mountWidget(vDivider) as web.HTMLElement;
      expect(rootV.style.width, equals('1px'));
      expect(rootV.style.alignSelf, equals('stretch'));
      expect(rootV.style.boxSizing, equals('border-box'));
    });

    test('FDGridView applies childAspectRatio to item containers', () {
      final grid = FDGridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: const [
          FDText('Item 1'),
          FDText('Item 2'),
        ],
      );

      final root = TestUtils.mountWidget(grid) as web.HTMLElement;
      expect(root.style.display, equals('grid'));
      expect(root.style.boxSizing, equals('border-box'));

      final items = root.querySelectorAll('div');
      expect(items.length, greaterThanOrEqualTo(2));
      final firstItem = items.item(0) as web.HTMLElement;
      expect(firstItem.style.aspectRatio, contains('1.5'));
    });
  });
}
