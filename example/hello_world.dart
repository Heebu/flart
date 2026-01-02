import 'package:flart/flart.dart';

void main() {
  runApp(HelloFlartApp());
}

class HelloFlartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Flart!'),
          backgroundColor: FlartColor.hex('#007bff'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: AxisAlignment.center,
            children: [
              Text(
                'Welcome to Flart! 🎨',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: 'bold',
                  color: '#007bff',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'A Flutter-inspired UI framework for Dart Web',
                style: TextStyle(
                  fontSize: 16,
                  color: '#666666',
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => print('Button clicked!'),
                child: Text('Click Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
