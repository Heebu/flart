import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const CounterApp());
}

class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDChangeNotifierProvider<CounterNotifier>(
      create: (context) => CounterNotifier(),
      child: FDMaterialApp(
        title: 'Reactive Counter',
        home: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FDScaffold(
      appBar: FDAppBar(
        title: FDText('Reactive Framework Demo'),
        backgroundColor: theme.primaryColor,
      ),
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDText('Pushing the button rebuilds only the count below:'),
            FDSizedBox(height: 20),

            // This consumer only rebuilds its builder when notifier changes
            FDConsumer<CounterNotifier>(
              builder: (context, counter, child) {
                return FDAnimate(
                  key: ValueKey(
                      counter.count), // Re-animate on every count change
                  fadeIn: true,
                  slideY: 10,
                  duration: Duration(milliseconds: 200),
                  child: FDText(
                    '${counter.count}',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                );
              },
            ),

            FDSizedBox(height: 40),
            FDElevatedButton(
              onPressed: () {
                FDProvider.of<CounterNotifier>(context).increment();
              },
              child: FDText('Increment Count'),
            ),
          ],
        ),
      ),
    );
  }
}
