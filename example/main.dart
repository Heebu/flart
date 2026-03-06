import 'package:flartdart/flartdart.dart';

void main() {
  // Initialize Responsive Utility with desktop design size (1440x900)
  ScreenUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final CounterViewModel _model = CounterViewModel();

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Entry animation for the header
            FDAnimate(
              fadeIn: true,
              slideY: -20,
              duration: Duration(milliseconds: 800),
              child: FDColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FDText(
                    'Flart Experience',
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: FlartColors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  FDSizedBox(height: 8),
                  FDText(
                    'Reactive Counter',
                    style: TextStyle(
                      fontSize: 32.0.sp,
                      fontWeight: FontWeight.bold,
                      color: FlartColor('#6366f1'),
                    ),
                  ),
                ],
              ),
            ),

            FDSizedBox(height: 60.h),

            // The animated counter value wrapper
            FDAnimate(
              fadeIn: true,
              slideY: 10,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 100),
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
                // THIS tightly scoped widget is the only thing that updates!
                child: _CounterDisplay(model: _model),
              ),
            ),

            FDSizedBox(height: 60.h),

            // Control buttons
            FDAnimate(
              fadeIn: true,
              slideY: 20,
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: FDRow(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  _ActionButton(
                    icon: FDIcons.remove,
                    onPressed: _model.decrement,
                    color: FlartColors.red,
                    isLarge: true,
                  ),
                  _ActionButton(
                    icon: FDIcons.add,
                    onPressed: _model.increment,
                    color: const FlartColor('#6366f1'),
                    isLarge: true,
                  ),
                ],
              ),
            ),

            FDSizedBox(height: 40.h),

            FDAnimate(
              fadeIn: true,
              delay: const Duration(milliseconds: 800),
              child: FDChip(
                label: const FDText('v1.3.0 Stable'),
                backgroundColor: FlartColors.green.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Scoped stateful widget exclusively for rebuilding the text
class _CounterDisplay extends StatefulWidget {
  final CounterViewModel model;
  const _CounterDisplay({required this.model});

  @override
  State<_CounterDisplay> createState() => _CounterDisplayState();
}

class _CounterDisplayState extends State<_CounterDisplay> {
  @override
  void initState() {
    super.initState();
    widget.model.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.model.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FDText(
      '${widget.model.count}',
      style: const TextStyle(
        fontSize: 80.0,
        fontWeight: FontWeight.w900,
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
  });

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
            size: isLarge ? 40.0 : 30.0,
          ),
        ),
      ),
    );
  }
}
