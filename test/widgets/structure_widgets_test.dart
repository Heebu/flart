@TestOn('browser')

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
  });
}
