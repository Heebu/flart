import 'package:flart/flart.dart';

void main() {
  runApp(
    Container(
      cssStyle: {
        'padding': '40px',
        'background-color': '#eee',
      },
      child: Column(
        children: [
          Text('Flart for Web!', cssStyle: {
            'font-size': '24px',
            'color': 'darkblue',
          }),
          Container(
            cssStyle: {
              'margin-top': '20px',
              'padding': '10px',
              'border': '1px solid #ccc'
            },
            child: Text('This is built entirely in Dart 😎'),
          ),
        ],
      ),
    ),
  );
}
