import 'package:flart_project/bridge.dart';
import 'package:flart_project/flart.dart';
import 'package:flart_project/src/helper/theme_manager.dart';
import 'counter_app.dart';

void main() {
  FlartThemeManager.applySystemPreference();
  setupFlartPickersBridge();
  runApp(
    CounterApp(),
  );
}
