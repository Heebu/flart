import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef DateCallback = void Function(DateTime date);

class FDDatePicker extends Widget {
  final DateCallback onDateSelected;
  final String? initialDate;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDatePicker({
    required this.onDateSelected,
    this.initialDate,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'padding': '8px 12px',
      'border': '1px solid #ccc',
      'border-radius': '4px',
      'font-size': '14px',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    void handleDate(web.Event e) {
      final target = e.target as web.HTMLInputElement?;
      if (target != null && target.value.isNotEmpty) {
        final dt = DateTime.tryParse(target.value);
        if (dt != null) {
          onDateSelected(dt);
        }
      }
    }

    final events = <String, void Function(web.Event)>{
      'change': handleDate,
      'input': handleDate,
    };

    return FlartElementNode(
      'input',
      id: key?.toString(),
      attributes: {
        'type': 'date',
        if (initialDate != null) 'value': initialDate!,
      },
      styles: styles,
      events: events,
    );
  }
}
