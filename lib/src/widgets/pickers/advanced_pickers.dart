import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Date time range class
class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange({required this.start, required this.end});
}

/// Range values class
class RangeValues {
  final double start;
  final double end;

  RangeValues(this.start, this.end);
}

/// A date range picker
class FDDateRangePicker extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTimeRange>? onChanged;
  final String? label;
  final Map<String, String>? cssStyle;

  const FDDateRangePicker({
    this.startDate,
    this.endDate,
    this.onChanged,
    this.label,
    this.cssStyle,
    super.key,
  });

  @override
  State<FDDateRangePicker> createState() => _FDDateRangePickerState();
}

class _FDDateRangePickerState extends State<FDDateRangePicker> {
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
    _start = widget.startDate;
    _end = widget.endDate;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _notify() {
    if (_start != null && _end != null && widget.onChanged != null) {
      widget.onChanged!(DateTimeRange(start: _start!, end: _end!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final startValue = _start != null ? _formatDate(_start!) : '';
    final endValue = _end != null ? _formatDate(_end!) : '';

    final inputStyles = <String, String>{
      'padding': '8px 12px',
      'border': '1px solid #cccccc',
      'border-radius': '4px',
      'font-size': '14px',
      ...?widget.cssStyle,
    };

    final children = <FlartNode>[
      if (widget.label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(widget.label!)],
        ),
      FlartElementNode(
        'div',
        styles: {
          'display': 'flex',
          'gap': '8px',
          'align-items': 'center',
        },
        children: [
          FlartElementNode(
            'input',
            attributes: {
              'type': 'date',
              if (startValue.isNotEmpty) 'value': startValue,
              'aria-label': 'Start Date',
            },
            styles: inputStyles,
            events: {
              'change': (e) {
                final target = e.target as web.HTMLInputElement?;
                if (target != null && target.value.isNotEmpty) {
                  final parsed = DateTime.tryParse(target.value);
                  if (parsed != null) {
                    setState(() {
                      _start = parsed;
                    });
                    _notify();
                  }
                }
              },
            },
          ),
          FlartElementNode(
            'span',
            styles: {'color': '#666'},
            children: [FlartTextNode('to')],
          ),
          FlartElementNode(
            'input',
            attributes: {
              'type': 'date',
              if (endValue.isNotEmpty) 'value': endValue,
              'aria-label': 'End Date',
            },
            styles: inputStyles,
            events: {
              'change': (e) {
                final target = e.target as web.HTMLInputElement?;
                if (target != null && target.value.isNotEmpty) {
                  final parsed = DateTime.tryParse(target.value);
                  if (parsed != null) {
                    setState(() {
                      _end = parsed;
                    });
                    _notify();
                  }
                }
              },
            },
          ),
        ],
      ),
    ];

    return _RawFlartNodeWidget(
      FlartElementNode(
        'div',
        id: widget.key?.toString(),
        styles: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '4px',
        },
        children: children,
      ),
    );
  }
}

/// Internal helper to embed a raw FlartNode from a State widget
class _RawFlartNodeWidget extends Widget {
  final FlartNode node;
  const _RawFlartNodeWidget(this.node);

  @override
  FlartNode buildNode(BuildContext context) => node;
}

/// A month picker
class FDMonthPicker extends Widget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;
  final String? label;

  const FDMonthPicker({
    this.initialDate,
    this.onChanged,
    this.label,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final value = initialDate != null
        ? '${initialDate!.year}-${initialDate!.month.toString().padLeft(2, '0')}'
        : '';

    final children = <FlartNode>[
      if (label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(label!)],
        ),
      FlartElementNode(
        'input',
        attributes: {
          'type': 'month',
          if (value.isNotEmpty) 'value': value,
        },
        styles: {
          'padding': '8px 12px',
          'border': '1px solid #cccccc',
          'border-radius': '4px',
          'font-size': '14px',
        },
        events: {
          'change': (e) {
            final target = e.target as web.HTMLInputElement?;
            if (target != null && target.value.isNotEmpty) {
              final parsed = DateTime.tryParse('${target.value}-01');
              if (parsed != null) {
                onChanged?.call(parsed);
              }
            }
          },
        },
      ),
    ];

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
      },
      children: children,
    );
  }
}

/// A week picker
class FDWeekPicker extends Widget {
  final String? initialWeek;
  final ValueChanged<String>? onChanged;
  final String? label;

  const FDWeekPicker({
    this.initialWeek,
    this.onChanged,
    this.label,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final children = <FlartNode>[
      if (label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(label!)],
        ),
      FlartElementNode(
        'input',
        attributes: {
          'type': 'week',
          if (initialWeek != null && initialWeek!.isNotEmpty) 'value': initialWeek!,
        },
        styles: {
          'padding': '8px 12px',
          'border': '1px solid #cccccc',
          'border-radius': '4px',
          'font-size': '14px',
        },
        events: {
          'change': (e) {
            final target = e.target as web.HTMLInputElement?;
            if (target != null && target.value.isNotEmpty) {
              onChanged?.call(target.value);
            }
          },
        },
      ),
    ];

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
      },
      children: children,
    );
  }
}

/// A datetime-local picker
class DateTimePicker extends Widget {
  final DateTime? initialDateTime;
  final ValueChanged<DateTime>? onChanged;
  final String? label;
  final String? helperText;

  const DateTimePicker({
    this.initialDateTime,
    this.onChanged,
    this.label,
    this.helperText,
    super.key,
  });

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}T${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  FlartNode buildNode(BuildContext context) {
    final value = initialDateTime != null ? _formatDateTime(initialDateTime!) : '';

    final children = <FlartNode>[
      if (label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(label!)],
        ),
      FlartElementNode(
        'input',
        attributes: {
          'type': 'datetime-local',
          if (value.isNotEmpty) 'value': value,
        },
        styles: {
          'padding': '8px 12px',
          'border': '1px solid #cccccc',
          'border-radius': '4px',
          'font-size': '14px',
        },
        events: {
          'change': (e) {
            final target = e.target as web.HTMLInputElement?;
            if (target != null && target.value.isNotEmpty) {
              final parsed = DateTime.tryParse(target.value);
              if (parsed != null) {
                onChanged?.call(parsed);
              }
            }
          },
        },
      ),
      if (helperText != null)
        FlartElementNode(
          'span',
          styles: {'font-size': '12px', 'color': '#666'},
          children: [FlartTextNode(helperText!)],
        ),
    ];

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
      },
      children: children,
    );
  }
}

/// A number range picker
class RangePicker extends StatefulWidget {
  final double min;
  final double max;
  final double? startValue;
  final double? endValue;
  final ValueChanged<RangeValues>? onChanged;
  final String? label;

  const RangePicker({
    required this.min,
    required this.max,
    this.startValue,
    this.endValue,
    this.onChanged,
    this.label,
    super.key,
  });

  @override
  State<RangePicker> createState() => _RangePickerState();
}

class _RangePickerState extends State<RangePicker> {
  late double _start;
  late double _end;

  @override
  void initState() {
    super.initState();
    _start = widget.startValue ?? widget.min;
    _end = widget.endValue ?? widget.max;
  }

  void _notify() {
    widget.onChanged?.call(RangeValues(_start, _end));
  }

  @override
  Widget build(BuildContext context) {
    final children = <FlartNode>[
      if (widget.label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(widget.label!)],
        ),
      FlartElementNode(
        'div',
        styles: {
          'display': 'flex',
          'gap': '12px',
          'align-items': 'center',
        },
        children: [
          FlartElementNode(
            'input',
            attributes: {
              'type': 'range',
              'min': widget.min.toString(),
              'max': widget.max.toString(),
              'value': _start.toString(),
            },
            styles: {'flex': '1'},
            events: {
              'input': (e) {
                final target = e.target as web.HTMLInputElement?;
                if (target != null) {
                  final val = double.tryParse(target.value);
                  if (val != null) {
                    setState(() {
                      _start = val;
                    });
                    _notify();
                  }
                }
              },
            },
          ),
          FlartElementNode(
            'input',
            attributes: {
              'type': 'range',
              'min': widget.min.toString(),
              'max': widget.max.toString(),
              'value': _end.toString(),
            },
            styles: {'flex': '1'},
            events: {
              'input': (e) {
                final target = e.target as web.HTMLInputElement?;
                if (target != null) {
                  final val = double.tryParse(target.value);
                  if (val != null) {
                    setState(() {
                      _end = val;
                    });
                    _notify();
                  }
                }
              },
            },
          ),
        ],
      ),
      FlartElementNode(
        'div',
        styles: {
          'font-size': '14px',
          'color': '#666',
          'text-align': 'center',
        },
        children: [
          FlartTextNode('${_start.toStringAsFixed(0)} - ${_end.toStringAsFixed(0)}'),
        ],
      ),
    ];

    return _RawFlartNodeWidget(
      FlartElementNode(
        'div',
        id: widget.key?.toString(),
        styles: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '8px',
        },
        children: children,
      ),
    );
  }
}
