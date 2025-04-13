import 'package:flart_project/flart.dart';
import 'package:flart_project/src/styles/border.dart';
import 'package:flart_project/src/styles/border_radius.dart';

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

  // @override
  // void initState() {
  //   print('initState called');
  // }

  void countFunction(String operator){
    setState((){
    operator == 'add'? count++: count--;;
    });
  }

  @override
  Widget build() {
    return Container(
      width: 1000,
      height: 1000,
      decoration: BoxDecoration(color: FlartColors.green.shade500, border: Border.all(side: BorderSide(color: FlartColors.red, width: 10)), borderRadius: BorderRadius.circular(10) ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Count: $count'),
         Row(children: [
           Button(
             label: 'Tap +',
             onClick: () => countFunction('add'),
           ),
         ]),

          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(6, (index) => Text('Item $index')),
          )

        ],
      )
    );
  }
}
