import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flart Counter 🚀',
      theme: ThemeData.light().copyWith(
        primaryColor: const FlartColor('#6366f1'), // Indigo
      ),
      home: const CounterPage(),
    );
  }
}

class CounterViewModel extends ViewModel {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDViewModelBuilder<CounterViewModel>(
      viewModelBuilder: () => CounterViewModel(),
      builder: (context, model, child) => FDScaffold(
        body: FDCenter(
          child: FDColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Entry animation for the header
              const FDAnimate(
                fadeIn: true,
                slideY: -20,
                duration: Duration(milliseconds: 800),
                child: FDColumn(
                  children: [
                    FDText(
                      'Flart Experience',
                      style: TextStyle(
                        fontSize: 16,
                        color: FlartColors.grey,
                        letterSpacing: 2,
                      ),
                    ),
                    FDSizedBox(height: 8),
                    FDText(
                      'Reactive Counter',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: FlartColor('#6366f1'),
                      ),
                    ),
                  ],
                ),
              ),

              const FDSizedBox(height: 60),

              // The animated counter value
              FDAnimate(
                key: ValueKey(model.count), // Re-trigger animation on change
                scale: 0.8,
                fadeIn: true,
                duration: const Duration(milliseconds: 400),
                child: FDContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: FlartColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: FlartColors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: FDText(
                    '${model.count}',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              const FDSizedBox(height: 60),

              // Control buttons
              FDRow(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  _ActionButton(
                    icon: FDIcons.remove,
                    onPressed: model.decrement,
                    color: FlartColors.red,
                  ),
                  _ActionButton(
                    icon: FDIcons.add,
                    onPressed: model.increment,
                    color: const FlartColor('#6366f1'),
                    isLarge: true,
                  ),
                ],
              ),

              const FDSizedBox(height: 40),

              FDAnimate(
                fadeIn: true,
                delay: const Duration(milliseconds: 1000),
                child: FDChip(
                  label: const FDText('v1.3.0 Stable'),
                  backgroundColor: FlartColors.green.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  final FlartColor color;
  final bool isLarge;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
    required this.color,
    this.isLarge = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = isLarge ? 80.0 : 60.0;

    return FDGestureDetector(
      onTap: onPressed,
      child: FDContainer(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: FDCenter(
          child: FDIcon(
            icon: icon,
            color: FlartColors.white,
            size: isLarge ? 40 : 30,
          ),
        ),
      ),
    );
  }
}
