import 'dart:html';
import '../../../flartdart.dart';

typedef TimeCallback = void Function(String time); // or Duration

class FDTimePicker extends Widget {
  final TimeCallback onTimeSelected;
  final String? initialTime;
  final Map<String, String>? cssStyle;

  FDTimePicker({
    required this.onTimeSelected,
    this.initialTime,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'timepicker_${DateTime.now().millisecondsSinceEpoch}';
    final style =
        cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? '';

    return '''
      <input type="time" id="$id" value="${initialTime ?? ''}" style="$style" />
      <script>
        document.getElementById('$id').addEventListener('change', function() {
          window.__flartTimeSelected('$id');
        });
      </script>
    ''';
  }

  static void attachHandler(String id, TimeCallback callback) {
    final input = document.getElementById(id) as InputElement?;
    input?.onChange.listen((_) {
      final value = input.value;
      if (value != null && value.isNotEmpty) {
        callback(value); // You can parse to Duration or DateTime if needed
      }
    });
  }
}



