import '../../../flartdart.dart';

/// A dropdown/select widget
class DropdownButton<T> extends Widget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;
  final double? width;

  DropdownButton({
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.width,
  });

  @override
  String render(BuildContext context) {
    final id = 'dropdown_${DateTime.now().microsecondsSinceEpoch}';
    final disabled = onChanged == null;

    return '''
      <select id="$id" ${disabled ? 'disabled' : ''} style="
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: white;
        cursor: ${disabled ? 'not-allowed' : 'pointer'};
        ${width != null ? 'width: ${width}px;' : ''}
      ">
        ${hint != null && value == null ? '<option value="" disabled selected>${hint!.render(context)}</option>' : ''}
        ${items.map((item) => '''
          <option value="${item.value}" ${item.value == value ? 'selected' : ''}>
            ${item.child.render(context)}
          </option>
        ''').join()}
      </select>
      ${!disabled ? '''
        <script>
          document.getElementById('$id').addEventListener('change', function(e) {
            console.log('Dropdown changed:', e.target.value);
          });
        </script>
      ''' : ''}
    ''';
  }
}

class DropdownMenuItem<T> extends Widget {
  final T value;
  final Widget child;

  DropdownMenuItem({
    required this.value,
    required this.child,
  });

  @override
  String render(BuildContext context) {
    return child.render(context);
  }
}

/// A slider widget
class Slider extends Widget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? inactiveColor;

  Slider({
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'slider_${DateTime.now().microsecondsSinceEpoch}';
    final active = activeColor?.toString() ?? '#6200ea';
    final disabled = onChanged == null;
    final step = divisions != null ? (max - min) / divisions! : 'any';

    return '''
      <input 
        type="range" 
        id="$id" 
        min="$min" 
        max="$max" 
        value="$value" 
        step="$step"
        ${disabled ? 'disabled' : ''}
        style="
          width: 100%;
          height: 4px;
          border-radius: 2px;
          outline: none;
          cursor: ${disabled ? 'not-allowed' : 'pointer'};
          accent-color: $active;
        "
      />
      ${!disabled ? '''
        <script>
          document.getElementById('$id').addEventListener('input', function(e) {
            console.log('Slider value:', parseFloat(e.target.value));
          });
        </script>
      ''' : ''}
    ''';
  }
}
