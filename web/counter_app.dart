import 'package:flart_project/flart.dart';
import 'package:flart_project/src/widgets/stateful_widget.dart';



class CounterApp extends StatefulWidget {
  const CounterApp();

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  @override
  String build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flart Counter',
              textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Count: $count',
              textStyle: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('-'),
                  onPressed: decrement,
                  cssStyle: {'margin-right': '10px'},
                ),
                ElevatedButton(
                  child: Text('+'),
                  onPressed: increment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



