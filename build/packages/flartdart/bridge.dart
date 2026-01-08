import 'dart:html';
import 'dart:js' as js;

void setupFlartPickersBridge() {
  js.context['__flartDateSelected'] = js.allowInterop((String id) {
    final input = document.getElementById(id) as InputElement?;
    if (input != null && input.value != null) {
      final date = DateTime.parse(input.value!);
      print("📅 Date picked globally: $date");
    }
  });

  js.context['__flartTimeSelected'] = js.allowInterop((String id) {
    final input = document.getElementById(id) as InputElement?;
    if (input != null && input.value != null) {
      final time = input.value!;
      print("⏰ Time picked globally: $time");
    }
  });
}
