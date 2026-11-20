import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef TimePicker = FDTimePicker;
typedef TimeCallback = void Function(String time);

/// A time picker input widget.
class FDTimePicker extends Widget {
  final TimeCallback onTimeSelected;
  final String? initialTime;
  final FlartColor? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const FDTimePicker({
    required this.onTimeSelected,
    this.initialTime,
    this.borderColor,
    this.borderRadius,
    this.padding,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final border = borderColor?.toString() ?? theme.dividerColor.toString();
    final radius = borderRadius?.topLeft ?? 4.0;
    final pad = padding?.toCss() ?? '8px 12px';

    final styles = <String, String>{
      'padding': pad,
      'border': '1px solid $border',
      'border-radius': '${radius}px',
      'font-size': '14px',
      'font-family': 'inherit',
      'background-color': theme.cardColor.toString(),
      'color': theme.textStyle.color?.toString() ?? '#333333',
      'outline': 'none',
      'box-sizing': 'border-box',
    };

    void handleTime(web.Event e) {
      final target = e.target as web.HTMLInputElement?;
      if (target != null && target.value.isNotEmpty) {
        onTimeSelected(target.value);
      }
    }

    final events = <String, void Function(web.Event)>{
      'change': handleTime,
      'input': handleTime,
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
