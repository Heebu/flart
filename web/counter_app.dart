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
      width: MediaQuery.of().width.toDouble(),
      height: MediaQuery.of().height.toDouble(),
      decoration: BoxDecoration(color: FlartColors.green.shade500),
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
