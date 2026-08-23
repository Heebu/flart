import 'package:web/web.dart';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

void setupFlartPickersBridge() {
  globalContext.setProperty(
      '__flartDateSelected'.toJS,
      ((String id) {
        final input = document.getElementById(id) as HTMLInputElement?;
        if (input != null && input.value != '') {
          final date = DateTime.parse(input.value);
          print('📅 Date picked globally: $date');
        }
      }).toJS);

  globalContext.setProperty(
      '__flartTimeSelected'.toJS,
      ((String id) {
        final input = document.getElementById(id) as HTMLInputElement?;
        if (input != null && input.value != '') {
          final time = input.value;
          print('⏰ Time picked globally: $time');
        }
      }).toJS);
}
