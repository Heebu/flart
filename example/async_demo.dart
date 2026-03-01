import 'package:flartdart/flartdart.dart';
import 'dart:async';

void main() {
  runApp(const AsyncDemoApp());
}

class AsyncDemoApp extends StatelessWidget {
  const AsyncDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flart Async Demos',
      theme: ThemeData.light(),
      home: const AsyncDemoPage(),
    );
  }
}

class AsyncDemoPage extends StatelessWidget {
  const AsyncDemoPage({Key? key}) : super(key: key);

  Stream<int> _timerStream() async* {
    int i = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield i++;
    }
  }

  Future<String> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Flart Power! ⚡';
  }

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      appBar: const FDAppBar(
        title: FDText('Async & Builders'),
      ),
      body: FDPadding(
        padding: const EdgeInsets.all(24),
        child: FDColumn(
          spacing: 20,
          children: [
            const FDText(
              'StreamBuilder Demo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FDContainer(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: FlartColors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FDStreamBuilder<int>(
                stream: _timerStream(),
                initialData: 0,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const FDText('Connecting...');
                  }
                  return FDRow(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FDIcon(
                          icon: FDIcons.refresh, color: FlartColors.blue),
                      const FDSizedBox(width: 10),
                      FDText(
                        'Seconds elapsed: ${snapshot.data}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ),
            const FDSizedBox(height: 20),
            const FDText(
              'FutureBuilder Demo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FDFutureBuilder<String>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const FDContainer(
                    height: 50,
                    child: FDCenter(child: FDText('Fetching data...')),
                  );
                }
                if (snapshot.hasError) {
                  return FDText('Error: ${snapshot.error}');
                }
                return FDAnimate(
                  fadeIn: true,
                  slideY: 10,
                  child: FDContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: FlartColors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FDText(
                      'Result: ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: FlartColors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
            const FDSizedBox(height: 20),
            const FDText(
              'Builder Demo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FDBuilder(
              builder: (context) {
                // Using the builder to access theme via context in a nested way
                final theme = Theme.of(context);
                return FDContainer(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.primaryColor, width: 1),
                  ),
                  child: FDText(
                      'This container uses theme from FDBuilder context'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
