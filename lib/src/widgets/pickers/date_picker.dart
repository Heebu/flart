import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef DatePicker = FDDatePicker;
typedef DateCallback = void Function(DateTime date);

/// A date picker input widget.
class FDDatePicker extends Widget {
  final DateCallback onDateSelected;
  final String? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FlartColor? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const FDDatePicker({
    required this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.borderColor,
    this.borderRadius,
    this.padding,
    super.key,
  });

  String? _formatDate(DateTime? dt) {
    if (dt == null) return null;
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

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
        if (firstDate != null) 'min': _formatDate(firstDate)!,
        if (lastDate != null) 'max': _formatDate(lastDate)!,
      },
      styles: styles,
      events: events,
    );
  }
}
