@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

// Sample Counter StatefulWidget
class CounterWidget extends StatefulWidget {
  final int initialCount;
  const CounterWidget({this.initialCount = 0, super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      children: [
        FDText('Count: $count'),
        FDElevatedButton(
          onPressed: increment,
          child: FDText('Increment'),
        ),
      ],
    );
  }
}

// Sample InheritedWidget
class UserInfo extends InheritedWidget {
  final String username;

  const UserInfo({
    required this.username,
    required super.child,
    super.key,
  });

  static UserInfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserInfo>();
  }

  @override
  bool updateShouldNotify(UserInfo oldWidget) => username != oldWidget.username;
}

class UserGreeting extends StatelessWidget {
  const UserGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final info = UserInfo.of(context);
    return FDText('Hello, ${info?.username ?? "Guest"}!');
  }
}

void main() {
  group('State Management & Reactivity', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('StatefulWidget updates DOM on setState', () async {
      final widget = CounterWidget(initialCount: 0);
      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      expect(root.textContent, contains('Count: 0'));

      final button = root.querySelector('button') as web.HTMLElement?;
      expect(button, isNotNull);

      TestUtils.click(button!);
      await TestUtils.pump(30);

      expect(root.textContent, contains('Count: 1'));

      TestUtils.click(button);
      await TestUtils.pump(30);

      expect(root.textContent, contains('Count: 2'));
    });

    test('ValueListenableBuilder rebuilds when ValueNotifier changes', () async {
      final notifier = ValueNotifier<String>('Initial message');

      final widget = ValueListenableBuilder<String>(
        valueListenable: notifier,
        builder: (context, value, child) {
          return FDContainer(
            child: FDText('Message: $value'),
          );
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Message: Initial message'));

      notifier.value = 'Updated reactive message';
      await TestUtils.pump(30);

      expect(root.textContent, contains('Message: Updated reactive message'));

      notifier.value = 'Final update';
      await TestUtils.pump(30);

      expect(root.textContent, contains('Message: Final update'));
    });

    test('InheritedWidget provides data down the widget tree', () {
      final widget = UserInfo(
        username: 'FlartMaster',
        child: const UserGreeting(),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Hello, FlartMaster!'));
    });

    test('FutureBuilder transitions from waiting to withData', () async {
      final widget = FutureBuilder<String>(
        future: Future.delayed(const Duration(milliseconds: 20), () => 'Loaded Data!'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FDText('Loading...');
          }
          if (snapshot.hasData) {
            return FDText('Result: ${snapshot.data}');
          }
          return const FDText('No Data');
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Loading...'));

      await Future<void>.delayed(const Duration(milliseconds: 60));
      expect(root.textContent, contains('Result: Loaded Data!'));
    });

    test('StreamBuilder updates when stream emits events', () async {
      final stream = Stream.fromIterable(['Event 1', 'Event 2', 'Event 3']);

      final widget = StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FDText('Latest: ${snapshot.data}');
          }
          return const FDText('Connecting...');
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      await Future<void>.delayed(const Duration(milliseconds: 60));
      expect(root.textContent, contains('Latest: Event 3'));
    });

    test('Provider and Consumer propagate state changes', () async {
      final model = ValueNotifier<int>(10);

      final widget = ChangeNotifierProvider<ValueNotifier<int>>(
        create: (_) => model,
        child: Consumer<ValueNotifier<int>>(
          builder: (context, val, _) {
            return FDText('Current Val: ${val.value}');
          },
        ),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Current Val: 10'));

      model.value = 42;
      await TestUtils.pump(30);
      expect(root.textContent, contains('Current Val: 42'));
    });

    test('Builder passes valid BuildContext', () {
      final widget = Builder(
        builder: (context) {
          return const FDText('Built with context!');
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Built with context!'));
    });
  });
}
