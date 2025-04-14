import 'package:flart_project/flart.dart';
import 'package:flart_project/src/helper/theme_manager.dart';
import 'counter_app.dart';
import 'dart:html';

void main() {
  FlartThemeManager.applySystemPreference(); // Apply system theme
  runApp(
  CounterApp());
  //     MaterialApp(
  //   title: 'My Flart App',
  //   home: CounterApp(),
  //   darkMode: false,
  // ));
}



// class MyApp extends StatelessWidget {
//   @override
//   String build() {
//     return MaterialApp(
//       title: 'My Flart App',
//       home: CounterApp(),
//       darkMode: false,
//     ).render();
//   }
// }









