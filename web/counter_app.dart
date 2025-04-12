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
      decoration: BoxDecoration(color: FlartColors.green.shade500.toString()),
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
           Button(
             label: 'Tap +',
             onClick: () => countFunction('add'),
           ),
         ])
          // Button(
          //   label: 'Tap -',
          //   cssStyle: {
          //     'color': FlartColors.red
          //   },
          //   onClick: () => countFunction('remove'),
          // )
        ],
      )
    );
  }
}
