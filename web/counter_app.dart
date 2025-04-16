import 'package:flart_project/flart.dart';
import 'package:flart_project/src/enums/axis.dart';
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

  void countFunction(String operator) {
    setState(() {
      operator == 'add' ? count++ : count--;
      ;
    });
  }

  List<String> imageLists = [
    'https://w7.pngwing.com/pngs/670/159/png-transparent-facebook-logo-social-media-facebook-computer-icons-linkedin-logo-facebook-icon-media-internet-facebook-icon-thumbnail.png',
    'https://i.pinimg.com/736x/69/a6/2a/69a62a5edc08d755dd8a4ef017e14c63.jpg'
    'https://static.vecteezy.com/system/resources/previews/018/930/480/non_2x/linkedin-logo-linkedin-icon-transparent-free-png.png'
    'https://i.pinimg.com/736x/3d/74/f9/3d74f98793e06e413eb658b769633cd7.jpg',
    'https://i.pinimg.com/736x/3a/36/20/3a36206f35352b4230d5fc9f17fcea92.jpg',
    'https://i.pinimg.com/736x/72/52/a7/7252a7a2b8fa3ab9bd2294b0edfe96ba.jpg'
        'https://w7.pngwing.com/pngs/591/906/png-transparent-x-logo-new-twitter-logo-thumbnail.png',
    'https://i.pinimg.com/736x/38/9d/51/389d513ef0975e2a42dc7460fb79d1b2.jpg'
  ];

  @override
  Widget build() {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(left: 100),
            margin: EdgeInsets.all(100),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 977.5,
                      width: 720,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            offsetX: -1,
                            offsetY: -1,
                            blurRadius: 10,
                            color: FlartColors.black)
                      ], borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Center(
                          child: FlartImage.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2mm9gw0ZuV4m8nC2wlJSbua2kD6Oaev45tw&s'),
                        ),

                        Divider(thickness: 10, color: FlartColors.black),

                        Container(
                            padding: EdgeInsets.all(50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Hi Idris,',
                                    style: TextStyle(fontSize: 18)),
                                Container(height: 20),
                                Text(
                                    'Thanks for reaching out to us! We appreciate your feedback and will get back to you as soon as possible.',
                                    style: TextStyle(fontSize: 18)),

                                Container(height: 20),

                                Text('Here is a copy of your message:',
                                    style: TextStyle(fontSize: 18)),

                                Container(
                                  width: 592,
                                  height: 395,
                                  padding: EdgeInsets.all(30),
                                  margin: EdgeInsets.only(top: 50, bottom: 50),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        offsetX: 1,
                                        offsetY: 1,
                                        blurRadius: 5,
                                        color: FlartColors.black)
                                  ], borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            'Thank you for the opportunity to test the IntelRegion email system. I’m pleased to share that the email delivery was smooth, timely, and well-structured. The formatting was clear, the branding was consistent, and all embedded links and visuals loaded correctly across different devices. It’s great to see the attention to detail and professionalism reflected in the test emails.',
                                            style: TextStyle(fontSize: 18)),

                                        Container(height: 50),

                                        Text(
                                            'That said, I noticed a minor delay in the initial delivery time on one of the test emails, and a slight formatting inconsistency when viewed in dark mode. These are relatively small issues but could be worth looking into for optimal performance. Overall, it was a solid test, and I look forward to seeing the system fully implemented. Well done to the team!',
                                            style: TextStyle(fontSize: 18)),
                                      ]),
                                ),

                                Text('Thanks.',
                                    style: TextStyle(fontSize: 18)),

                                Divider(thickness: 10, color: FlartColors.black),

                                Container(
                                    width: 650, height: 87.5,
                                    padding: EdgeInsets.only(top: 24, bottom: 24),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(children: [
                                            Text('CONTACT WITH US', style: TextStyle(fontSize: 10)),
                                            Row(children: [
                                              ListView.separated(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: imageLists.length, itemBuilder: (context, index) => Container(height: 20, width: 20, child: FlartImage.network(imageLists[index], height: 20, width: 20)), separatorBuilder: (context, index) => Container(width: 10),)
                                            ]),
                                          ]),

                                          FlartImage.network(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2mm9gw0ZuV4m8nC2wlJSbua2kD6Oaev45tw&s',
                                              height: 70),

                                        ])
                                )
                              ],
                            )),




                      ]))
                ])));
  }
}
