import 'package:flart_project/flart.dart';
import 'package:flart_project/src/widgets/arrangement_widgets/align.dart';
import 'package:flart_project/src/widgets/buttons/icon_button.dart';


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
    return Scaffold(
      drawer: Drawer(child: Column(children: [])),
      appBar: AppBar(leading: IconButton(icon: Icon(icon: Icons.add), onPressed: ()=>
        "toggleDrawer();", ) ,title: Text('Hello World')),
      body: Container(
          width: MediaQuery.of().width.toDouble(),
          height: MediaQuery.of().height.toDouble(),
          decoration: BoxDecoration(color: FlartColors.green.shade500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of().width.toDouble(),
                  height: 100,
                  margin: EdgeInsets.all(30),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(color: FlartColors.blue, borderRadius: BorderRadius.only(bottomLeft: 20)),
                  child: Align(
                      alignment: Aligns.center,
                      child: Text(count.toString(), style: TextStyle(fontWeight: 'bold')))
              ),
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
      ),
    );
  }
}


