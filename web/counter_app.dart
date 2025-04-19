import 'package:flart_project/flart.dart';
import 'package:flart_project/src/widgets/buttons/elevated_button.dart';

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

  void countFunction(String operator) {
    setState(() {
      operator == 'add' ? count++ : count--;
      ;
    });
  }

  final controller = AnimationController(
    duration: Duration(seconds: 1),
    onCompleted: () {
      print("Done");
    },
  );




  List<String> imageLists = [
    'https://w7.pngwing.com/pngs/670/159/png-transparent-facebook-logo-social-media-facebook-computer-icons-linkedin-logo-facebook-icon-media-internet-facebook-icon-thumbnail.png',
    'https://static.vecteezy.com/system/resources/previews/018/930/480/non_2x/linkedin-logo-linkedin-icon-transparent-free-png.png',
    'https://i.pinimg.com/736x/3d/74/f9/3d74f98793e06e413eb658b769633cd7.jpg',
    'https://i.pinimg.com/736x/3a/36/20/3a36206f35352b4230d5fc9f17fcea92.jpg',
    'https://w7.pngwing.com/pngs/591/906/png-transparent-x-logo-new-twitter-logo-thumbnail.png',
    'https://i.pinimg.com/736x/38/9d/51/389d513ef0975e2a42dc7460fb79d1b2.jpg',
  ];


  @override
  Widget build() {



     controller.forward();
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(left: 100),
            margin: EdgeInsets.all(100),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


            ElevatedButton(child: Text('Tap'), ),

                  AnimatedContainer(
                controller: controller,
                beginColor: FlartColors.black,
                endColor: FlartColors.red,
                beginWidth: 100,
                endWidth: 300,
                beginHeight: 100,
                endHeight: 150,
              ),

                  SelectableText('This text can be selected'),
                  SizedBox(height: 20),
                  LinkText(label: 'Go to docs', href: 'https://docs.flart.dev'),
                  SizedBox(height: 20),
                  TextButton(label: 'Click Me', onPressed: () => print('Tapped'))



                ])));
  }
}
