import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const StackedShowcase());
}

// 1. A clean ViewModel that inherits from our new ViewModel base
class CounterViewModel extends ViewModel {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Rebuilds only the view using this model
  }
}

class StackedShowcase extends StatelessWidget {
  const StackedShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Stacked Architecture Demo',
      home: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2. Using ViewModelBuilder (No need for manual Provider injection/registration)
    return FDViewModelBuilder<CounterViewModel>(
      viewModelBuilder: () => CounterViewModel(),
      builder: (context, model, child) => FDScaffold(
        appBar: FDAppBar(
          title: FDText('Stacked in Flart'),
        ),
        body: FDCenter(
          child: FDColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FDText('Modern State Management 🚀'),
              FDSizedBox(height: 20),
              FDText(
                '${model.counter}',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              FDSizedBox(height: 40),
              FDElevatedButton(
                onPressed: model.increment,
                child: FDText('Increment Count'),
              ),
              FDSizedBox(height: 40),
              FDText('Features Used:'),
              _featureChip('Zero-Config State'),
              _featureChip('Auto-Disposal'),
              _featureChip('Isolated Rebuilds'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureChip(String label) {
    return FDPadding(
      padding: EdgeInsets.only(top: 8),
      child: FDChip(
        label: FDText(label),
        backgroundColor: FlartColors.blue[100],
      ),
    );
  }
}
