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
  });
}
