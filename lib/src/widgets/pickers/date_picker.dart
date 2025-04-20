import 'dart:html';
import '../widget.dart';

typedef DateCallback = void Function(DateTime date);

class DatePicker extends Widget {
  final DateCallback onDateSelected;
  final String? initialDate;
  final Map<String, String>? cssStyle;

  DatePicker({
    required this.onDateSelected,
    this.initialDate,
    this.cssStyle,
  });

  @override
  String render() {
    final id = 'datepicker_${DateTime.now().millisecondsSinceEpoch}';
    final style = cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? '';

    return '''
      <input type="date" id="$id" value="${initialDate ?? ''}" style="$style" />
      <script>
        document.getElementById('$id').addEventListener('change', function() {
          window.__flartDateSelected('$id');
        });
      </script>
    ''';
  }

  static void attachHandler(String id, DateCallback callback) {
    final input = document.getElementById(id) as InputElement?;
    input?.onChange.listen((_) {
      final value = input.value;
      if (value != null && value.isNotEmpty) {
        callback(DateTime.parse(value));
      }
    });
  }
}
