import 'package:flart_project/flart.dart';

class CounterApp extends StatefulWidget {
  const CounterApp();

  @override
  State createState() => _CounterState();

  @override
  String render() {
    // TODO: implement render
    throw UnimplementedError();
  }
}

class _CounterState extends State<CounterApp> {
  int count = 0;

  @override
  void initState() {
    print('initState called');
  }

  @override
  Widget build() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: FlartColors.orange),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Count: $count'),
          Button(
            label: 'Tap +',
            onClick: () => setState(() => count++),
          )
        ],
      )
    );
  }
}
