import 'package:flart_project/flart.dart';
import 'package:flart_project/src/widgets/utils/build_context.dart';

class CounterApp extends StatefulWidget {
  const CounterApp();

  @override
  State createState() => _CounterState();
}

class _CounterState extends State<CounterApp> {
  int count = 0;

  void countFunction(String operator) {
    setState(() {
      operator == 'add' ? count++ : count--;
    });
  }


  @override
  String build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}



