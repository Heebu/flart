import '../../../flart.dart';

/// A date range picker
class DateRangePicker extends Widget {
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTimeRange>? onChanged;
  final String? label;
  final Map<String, String>? cssStyle;

  DateRangePicker({
    this.startDate,
    this.endDate,
    this.onChanged,
    this.label,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final startId = 'daterange_start_${DateTime.now().microsecondsSinceEpoch}';
    final endId = 'daterange_end_${DateTime.now().microsecondsSinceEpoch}';
    final startValue = startDate != null ? _formatDate(startDate!) : '';
    final endValue = endDate != null ? _formatDate(endDate!) : '';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <div style="display: flex; gap: 8px; align-items: center;">
          <input
            type="date"
            id="$startId"
            value="$startValue"
            style="
              padding: 8px 12px;
              border: 1px solid #cccccc;
              border-radius: 4px;
              font-size: 14px;
              ${cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? ''}
            "
          />
          <span style="color: #666;">to</span>
          <input
            type="date"
            id="$endId"
            value="$endValue"
            style="
              padding: 8px 12px;
              border: 1px solid #cccccc;
              border-radius: 4px;
              font-size: 14px;
              ${cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? ''}
            "
          />
        </div>
      </div>
      
      <script>
        (function() {
          const startInput = document.getElementById('$startId');
          const endInput = document.getElementById('$endId');
          
          function handleChange() {
            if (startInput.value && endInput.value) {
              console.log('Date range:', startInput.value, 'to', endInput.value);
            }
          }
          
          startInput.addEventListener('change', handleChange);
          endInput.addEventListener('change', handleChange);
        })();
      </script>
    ''';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

/// Date time range class
class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange({required this.start, required this.end});
}

/// A month picker
class MonthPicker extends Widget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;
  final String? label;

  MonthPicker({
    this.initialDate,
    this.onChanged,
    this.label,
  });

  @override
  String render(BuildContext context) {
    final id = 'monthpicker_${DateTime.now().microsecondsSinceEpoch}';
    final value = initialDate != null
        ? '${initialDate!.year}-${initialDate!.month.toString().padLeft(2, '0')}'
        : '';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <input
          type="month"
          id="$id"
          value="$value"
          style="
            padding: 8px 12px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 14px;
          "
        />
      </div>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          ${onChanged != null ? '''
            input.addEventListener('change', function(e) {
              console.log('Month selected:', e.target.value);
            });
          ''' : ''}
        })();
      </script>
    ''';
  }
}

/// A week picker
class WeekPicker extends Widget {
  final String? initialWeek;
  final ValueChanged<String>? onChanged;
  final String? label;

  WeekPicker({
    this.initialWeek,
    this.onChanged,
    this.label,
  });

  @override
  String render(BuildContext context) {
    final id = 'weekpicker_${DateTime.now().microsecondsSinceEpoch}';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <input
          type="week"
          id="$id"
          value="${initialWeek ?? ''}"
          style="
            padding: 8px 12px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 14px;
          "
        />
      </div>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          ${onChanged != null ? '''
            input.addEventListener('change', function(e) {
              console.log('Week selected:', e.target.value);
            });
          ''' : ''}
        })();
      </script>
    ''';
  }
}

/// A datetime-local picker
class DateTimePicker extends Widget {
  final DateTime? initialDateTime;
  final ValueChanged<DateTime>? onChanged;
  final String? label;
  final String? helperText;

  DateTimePicker({
    this.initialDateTime,
    this.onChanged,
    this.label,
    this.helperText,
  });

  @override
  String render(BuildContext context) {
    final id = 'datetimepicker_${DateTime.now().microsecondsSinceEpoch}';
    final value =
        initialDateTime != null ? _formatDateTime(initialDateTime!) : '';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <input
          type="datetime-local"
          id="$id"
          value="$value"
          style="
            padding: 8px 12px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 14px;
          "
        />
        
        ${helperText != null ? '<span style="font-size: 12px; color: #666;">$helperText</span>' : ''}
      </div>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          ${onChanged != null ? '''
            input.addEventListener('change', function(e) {
              console.log('DateTime selected:', e.target.value);
            });
          ''' : ''}
        })();
      </script>
    ''';
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}T${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

/// A number range picker
class RangePicker extends Widget {
  final double min;
  final double max;
  final double? startValue;
  final double? endValue;
  final ValueChanged<RangeValues>? onChanged;
  final String? label;

  RangePicker({
    required this.min,
    required this.max,
    this.startValue,
    this.endValue,
    this.onChanged,
    this.label,
  });

  @override
  String render(BuildContext context) {
    final startId = 'range_start_${DateTime.now().microsecondsSinceEpoch}';
    final endId = 'range_end_${DateTime.now().microsecondsSinceEpoch}';
    final displayId = 'range_display_${DateTime.now().microsecondsSinceEpoch}';

    return '''
      <div style="display: flex; flex-direction: column; gap: 8px;">
        ${label != null ? '<label style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <div style="display: flex; gap: 12px; align-items: center;">
          <input
            type="range"
            id="$startId"
            min="$min"
            max="$max"
            value="${startValue ?? min}"
            style="flex: 1;"
          />
          <input
            type="range"
            id="$endId"
            min="$min"
            max="$max"
            value="${endValue ?? max}"
            style="flex: 1;"
          />
        </div>
        
        <div id="$displayId" style="font-size: 14px; color: #666; text-align: center;">
          ${startValue ?? min} - ${endValue ?? max}
        </div>
      </div>
      
      <script>
        (function() {
          const startInput = document.getElementById('$startId');
          const endInput = document.getElementById('$endId');
          const display = document.getElementById('$displayId');
          
          function updateDisplay() {
            display.textContent = startInput.value + ' - ' + endInput.value;
            console.log('Range:', startInput.value, 'to', endInput.value);
          }
          
          startInput.addEventListener('input', updateDisplay);
          endInput.addEventListener('input', updateDisplay);
        })();
      </script>
    ''';
  }
}

/// Range values class
class RangeValues {
  final double start;
  final double end;

  RangeValues(this.start, this.end);
}
