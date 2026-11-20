@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

// --- Test Widgets for StatefulWidget Positional Keys ---
class ParentTestWidget extends StatefulWidget {
  final int value;
  const ParentTestWidget({this.value = 0, super.key});

  @override
  State<ParentTestWidget> createState() => _ParentTestWidgetState();
}

class _ParentTestWidgetState extends State<ParentTestWidget> {
  int parentCount = 0;

  void bumpParent() {
    setState(() {
      parentCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      children: [
        FDText('Parent: $parentCount (prop: ${widget.value})'),
        const ChildUnkeyedWidget(name: 'FirstChild'),
        const ChildUnkeyedWidget(name: 'SecondChild'),
        FDElevatedButton(
          onPressed: bumpParent,
          child: const FDText('Bump Parent'),
        ),
      ],
    );
  }
}

class ChildUnkeyedWidget extends StatefulWidget {
  final String name;
  const ChildUnkeyedWidget({required this.name, super.key});

  @override
  State<ChildUnkeyedWidget> createState() => _ChildUnkeyedWidgetState();
}

class _ChildUnkeyedWidgetState extends State<ChildUnkeyedWidget> {
  int initCount = 0;
  int localCount = 0;

  @override
  void initState() {
    super.initState();
    initCount++;
  }

  void bumpLocal() {
    setState(() {
      localCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDContainer(
      child: FDColumn(
        children: [
          FDText('${widget.name} Inits: $initCount, Local: $localCount'),
          FDElevatedButton(
            onPressed: bumpLocal,
            child: FDText('Bump ${widget.name}'),
          ),
        ],
      ),
    );
  }
}

// --- Test Widgets for Unmount Disposal ---
class ConditionalParentWidget extends StatefulWidget {
  const ConditionalParentWidget({super.key});

  @override
  State<ConditionalParentWidget> createState() =>
      _ConditionalParentWidgetState();
}

class _ConditionalParentWidgetState extends State<ConditionalParentWidget> {
  bool showChild = true;

  void toggleChild() {
    setState(() {
      showChild = !showChild;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      children: [
        if (showChild) const DisposableChildWidget(),
        FDElevatedButton(
          onPressed: toggleChild,
          child: const FDText('Toggle Child'),
        ),
      ],
    );
  }
}

int disposableChildDisposeCount = 0;
bool? lastDisposableChildMountedStatus;

class DisposableChildWidget extends StatefulWidget {
  const DisposableChildWidget({super.key});

  @override
  State<DisposableChildWidget> createState() => _DisposableChildWidgetState();
}

class _DisposableChildWidgetState extends State<DisposableChildWidget> {
  @override
  void dispose() {
    disposableChildDisposeCount++;
    lastDisposableChildMountedStatus = mounted;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const FDText('Disposable Child Present');
  }
}

// --- Test Widgets for InheritedWidget Reactivity ---
class TestThemeData {
  final String primaryName;
  const TestThemeData(this.primaryName);
}

class TestThemeScope extends InheritedWidget {
  final TestThemeData data;

  const TestThemeScope({
    required this.data,
    required super.child,
    super.key,
  });

  static TestThemeScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TestThemeScope>();
  }

  @override
  bool updateShouldNotify(TestThemeScope oldWidget) =>
      data.primaryName != oldWidget.data.primaryName;
}

class ThemeConsumerWidget extends StatefulWidget {
  const ThemeConsumerWidget({super.key});

  @override
  State<ThemeConsumerWidget> createState() => _ThemeConsumerWidgetState();
}

class _ThemeConsumerWidgetState extends State<ThemeConsumerWidget> {
  int depChanges = 0;
  String currentTheme = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    depChanges++;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TestThemeScope.of(context);
    currentTheme = theme?.data.primaryName ?? 'None';
    return FDText('Theme: $currentTheme (depChanges: $depChanges)');
  }
}

class ThemeControllerWidget extends StatefulWidget {
  const ThemeControllerWidget({super.key});

  @override
  State<ThemeControllerWidget> createState() => _ThemeControllerWidgetState();
}

class _ThemeControllerWidgetState extends State<ThemeControllerWidget> {
  String themeName = 'Dark';

  void changeTheme(String newName) {
    setState(() {
      themeName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TestThemeScope(
      data: TestThemeData(themeName),
      child: FDColumn(
        children: [
          const ThemeConsumerWidget(),
          FDElevatedButton(
            onPressed: () => changeTheme('Light'),
            child: const FDText('Set Light'),
          ),
          FDElevatedButton(
            onPressed: () => changeTheme('Light'), // Same value
            child: const FDText('Set Light Again'),
          ),
        ],
      ),
    );
  }
}

abstract class BaseShowState {
  String get message;
}

class BaseStateParentWidget extends StatefulWidget {
  const BaseStateParentWidget({super.key});

  @override
  State<BaseStateParentWidget> createState() => _BaseStateParentWidgetState();
}

class _BaseStateParentWidgetState extends State<BaseStateParentWidget>
    implements BaseShowState {
  @override
  String get message => 'Hello from BaseState';

  @override
  Widget build(BuildContext context) {
    return const BaseStateChildWidget();
  }
}

class BaseStateChildWidget extends StatelessWidget {
  const BaseStateChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseState = context.findAncestorStateOfType<BaseShowState>();
    return FDText(baseState?.message ?? 'Missing');
  }
}

void main() {
  group('Foundation Architectural Fixes', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test(
        '1. StatefulWidget stable positional keys persist across parent setState passes',
        () async {
      final widget = const ParentTestWidget();
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.textContent, contains('Parent: 0'));
      expect(root.textContent, contains('FirstChild Inits: 1, Local: 0'));
      expect(root.textContent, contains('SecondChild Inits: 1, Local: 0'));

      web.Element findButton(String text) =>
          TestUtils.querySelectorAll('button')
              .firstWhere((b) => b.textContent?.contains(text) == true);

      // Bump FirstChild local state
      TestUtils.click(findButton('Bump FirstChild'));
      await TestUtils.pump(30);

      expect(root.textContent, contains('FirstChild Inits: 1, Local: 1'));

      // Bump parent multiple times
      TestUtils.click(findButton('Bump Parent'));
      await TestUtils.pump(30);

      expect(root.textContent, contains('Parent: 1'));
      // Verify child state was preserved: Inits is still 1, Local is still 1!
      expect(root.textContent, contains('FirstChild Inits: 1, Local: 1'));
      expect(root.textContent, contains('SecondChild Inits: 1, Local: 0'));

      TestUtils.click(findButton('Bump Parent'));
      await TestUtils.pump(30);

      expect(root.textContent, contains('Parent: 2'));
      expect(root.textContent, contains('FirstChild Inits: 1, Local: 1'));
      expect(root.textContent, contains('SecondChild Inits: 1, Local: 0'));
    });

    test('2. FDGestureDetector does not hard replace DOM node on render passes',
        () async {
      int clickCount = 0;

      // Find an unkeyed gesture detector or element
      final gestureWidget = FDGestureDetector(
        onTap: () => clickCount++,
        child: const FDText('TapMe'),
      );

      final container = TestUtils.container;
      // Mount gesture detector
      final context = BuildContext(widget: gestureWidget);
      final node = gestureWidget.buildNode(context);
      VDOMReconciler.reconcile(container, node);

      final firstElement = container.firstElementChild;
      expect(firstElement, isNotNull);

      // Re-reconcile another identical gesture detector
      final newGestureWidget = FDGestureDetector(
        onTap: () => clickCount++,
        child: const FDText('TapMe'),
      );
      final newContext = BuildContext(widget: newGestureWidget);
      final newNode = newGestureWidget.buildNode(newContext);
      VDOMReconciler.reconcile(container, newNode);

      final secondElement = container.firstElementChild;
      // Must be the exact same DOM node (soft patched, not hard replaced)
      expect(identical(firstElement, secondElement), isTrue);

      // Click still triggers
      TestUtils.click(secondElement!);
      expect(clickCount, equals(1));
    });

    test('3. State lifecycle calls dispose() on unmounted stateful widgets',
        () async {
      disposableChildDisposeCount = 0;
      lastDisposableChildMountedStatus = null;

      final widget = const ConditionalParentWidget();
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.textContent, contains('Disposable Child Present'));
      expect(disposableChildDisposeCount, equals(0));

      // Toggle child off
      final toggleBtn = TestUtils.querySelector('button')!;
      TestUtils.click(toggleBtn);
      await TestUtils.pump(30);

      expect(root.textContent, isNot(contains('Disposable Child Present')));
      expect(disposableChildDisposeCount, equals(1));
    });

    test(
        '4. InheritedWidget updateShouldNotify triggers didChangeDependencies and rebuild',
        () async {
      final widget = const ThemeControllerWidget();
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.textContent, contains('Theme: Dark (depChanges: 1)'));

      web.Element findButton(String text) =>
          TestUtils.querySelectorAll('button')
              .firstWhere((b) => b.textContent?.contains(text) == true);

      // Change theme to Light (updateShouldNotify returns true)
      TestUtils.click(findButton('Set Light'));
      await TestUtils.pump(30);

      expect(root.textContent, contains('Theme: Light (depChanges: 2)'));

      // Click Set Light Again (same data, updateShouldNotify returns false)
      TestUtils.click(findButton('Set Light Again'));
      await TestUtils.pump(30);

      // depChanges should NOT have incremented!
      expect(root.textContent, contains('Theme: Light (depChanges: 2)'));
    });

    test('5. Migrated FDAnimate renders VDOM and retains child event listeners',
        () async {
      bool buttonClicked = false;
      final widget = FDAnimate(
        fadeIn: true,
        duration: const Duration(milliseconds: 300),
        child: FDElevatedButton(
          onPressed: () => buttonClicked = true,
          child: const FDText('Animated Clickable'),
        ),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final button = root.querySelector('button') as web.HTMLElement?;
      expect(button, isNotNull);

      TestUtils.click(button!);
      await TestUtils.pump(10);
      expect(buttonClicked, isTrue);
    });

    test(
        '6. Navigation & FDMaterialApp renders home at root and supports pushNamed',
        () async {
      PageNavigator.reset();

      const homeWidget = FDText('Home Screen');
      const detailWidget = FDText('Detail Screen');

      final app = FDMaterialApp(
        title: 'Nav Test',
        home: homeWidget,
        routes: {
          '/detail': detailWidget,
        },
      );

      final root = TestUtils.mountWidget(app) as web.HTMLElement;
      expect(root.textContent, contains('Home Screen'));

      // Push named detail route
      PageNavigator.pushNamed('/detail');
      await TestUtils.pump(30);

      expect(PageNavigator.current, equals(detailWidget));

      // Pop back to home
      PageNavigator.pop();
      await TestUtils.pump(30);

      expect(PageNavigator.current, equals(homeWidget));
    });

    test('7. FDScaffold drawer toggles directly in Dart without script tags',
        () async {
      const scaffold = FDScaffold(
        drawer: FDDrawer(
          child: FDText('Drawer Contents'),
        ),
        body: FDText('Scaffold Body'),
      );

      final root = TestUtils.mountWidget(scaffold) as web.HTMLElement;
      expect(root.textContent, contains('Drawer Contents'));

      final drawerEl =
          web.document.getElementById('flart-drawer') as web.HTMLElement?;
      expect(drawerEl, isNotNull);
      expect(drawerEl!.style.transform, equals('translateX(-100%)'));

      // Toggle open
      toggleDrawer();
      expect(drawerEl.style.transform, equals('translateX(0%)'));

      // Toggle closed
      toggleDrawer();
      expect(drawerEl.style.transform, equals('translateX(-100%)'));

      // Open and Close
      openDrawer();
      expect(drawerEl.style.transform, equals('translateX(0%)'));
      closeDrawer();
      expect(drawerEl.style.transform, equals('translateX(-100%)'));
    });

    test('8. Keyed Children Diffing matches, reorders, and preserves DOM nodes',
        () async {
      final container = TestUtils.container;

      final itemA = FlartElementNode('div',
          key: 'key_A', children: [FlartTextNode('Item A')]);
      final itemB = FlartElementNode('div',
          key: 'key_B', children: [FlartTextNode('Item B')]);
      final itemC = FlartElementNode('div',
          key: 'key_C', children: [FlartTextNode('Item C')]);

      final listNode1 = FlartElementNode('div',
          id: 'parent-list', children: [itemA, itemB, itemC]);
      VDOMReconciler.reconcile(container, listNode1);

      final parentEl = web.document.getElementById('parent-list')!;
      final originalNodeA = parentEl.childNodes.item(0);
      final originalNodeB = parentEl.childNodes.item(1);
      final originalNodeC = parentEl.childNodes.item(2);

      expect(originalNodeA?.textContent, equals('Item A'));
      expect(originalNodeB?.textContent, equals('Item B'));
      expect(originalNodeC?.textContent, equals('Item C'));

      // Reorder to [C, A, B]
      final listNode2 = FlartElementNode('div',
          id: 'parent-list', children: [itemC, itemA, itemB]);
      VDOMReconciler.reconcile(container, listNode2);

      final reorderedNode0 = parentEl.childNodes.item(0);
      final reorderedNode1 = parentEl.childNodes.item(1);
      final reorderedNode2 = parentEl.childNodes.item(2);

      // DOM nodes must be preserved!
      expect(identical(reorderedNode0, originalNodeC), isTrue);
      expect(identical(reorderedNode1, originalNodeA), isTrue);
      expect(identical(reorderedNode2, originalNodeB), isTrue);
    });

    test(
        '9. FDGestureDetector combines onTapDown and onLongPress without dropping callbacks',
        () async {
      bool tapDownFired = false;
      bool longPressFired = false;

      final gesture = FDGestureDetector(
        onTapDown: () => tapDownFired = true,
        onLongPress: () => longPressFired = true,
        child: const FDText('Combined Press'),
      );

      final root = TestUtils.mountWidget(gesture) as web.HTMLElement;
      final mousedownEvent = web.MouseEvent('mousedown');
      root.dispatchEvent(mousedownEvent);

      expect(tapDownFired, isTrue);
      await TestUtils.pump(750);
      expect(longPressFired, isTrue);
    });

    test(
        '10. VDOMReconciler handles tag replacement in mixed keyed list without duplication',
        () async {
      final container = TestUtils.container;

      final nodeA = FlartElementNode('div',
          key: 'k_A', children: [FlartTextNode('Div A')]);
      final nodeB = FlartElementNode('div', children: [FlartTextNode('Div B')]);

      final list1 =
          FlartElementNode('div', id: 'mixed-list', children: [nodeA, nodeB]);
      VDOMReconciler.reconcile(container, list1);

      final parentEl = web.document.getElementById('mixed-list')!;
      expect(parentEl.childNodes.length, equals(2));
      expect(
          parentEl.childNodes.item(1)?.nodeName.toLowerCase(), equals('div'));

      // Replace unkeyed div with unkeyed span
      final nodeBAsSpan =
          FlartElementNode('span', children: [FlartTextNode('Span B')]);
      final list2 = FlartElementNode('div',
          id: 'mixed-list', children: [nodeA, nodeBAsSpan]);
      VDOMReconciler.reconcile(container, list2);

      expect(parentEl.childNodes.length, equals(2));
      expect(parentEl.childNodes.item(0)?.textContent, equals('Div A'));
      expect(
          parentEl.childNodes.item(1)?.nodeName.toLowerCase(), equals('span'));
      expect(parentEl.childNodes.item(1)?.textContent, equals('Span B'));
    });

    test(
        '11. InheritedRegistry notifyDependents updates registered dependent states',
        () async {
      final widget = const ThemeControllerWidget();
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Theme: Dark (depChanges: 1)'));

      // Directly notify via InheritedRegistry
      InheritedRegistry.notifyDependents(
        TestThemeScope,
        const TestThemeScope(
          data: TestThemeData('Emerald'),
          child: FDText(''),
        ),
      );
      await TestUtils.pump(30);

      expect(root.textContent, contains('Theme: Emerald (depChanges: 2)'));
    });

    test(
        '12. BuildContext findAncestorStateOfType resolves abstract interface state',
        () async {
      final widget = const BaseStateParentWidget();
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Hello from BaseState'));
    });
  });
}
