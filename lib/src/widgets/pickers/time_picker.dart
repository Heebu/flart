import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef TimeCallback = void Function(String time);

class FDTimePicker extends Widget {
  final TimeCallback onTimeSelected;
  final String? initialTime;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTimePicker({
    required this.onTimeSelected,
    this.initialTime,
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

    final events = <String, void Function(web.Event)>{
      'change': (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        if (target != null && target.value.isNotEmpty) {
          onTimeSelected(target.value);
        }
      },
      'input': (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        if (target != null && target.value.isNotEmpty) {
          onTimeSelected(target.value);
        }
      },
    };

    return FlartElementNode(
      'input',
      id: key?.toString(),
      attributes: {
        'type': 'time',
        if (initialTime != null) 'value': initialTime!,
      },
      styles: styles,
      events: events,
    );
  }
}
