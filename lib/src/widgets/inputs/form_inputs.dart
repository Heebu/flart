import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

/// A checkbox widget
class Checkbox extends Widget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? checkColor;

  Checkbox({
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'checkbox_${DateTime.now().microsecondsSinceEpoch}';
    final active = activeColor?.toString() ?? '#6200ea';
    final check = checkColor?.toString() ?? '#ffffff';
    final disabled = onChanged == null;

    String onChangeAttr = '';
    if (onChanged != null) {
      // Capture the NEXT state (toggle)
      final cbId = FlartCallbackManager.register(() => onChanged!(!value));
      onChangeAttr = 'onchange="window.__flartHandleClick(\'$cbId\')"';
    }

    return '''
      <input 
        type="checkbox" 
        id="$id" 
        ${value ? 'checked' : ''} 
        ${disabled ? 'disabled' : ''}
        style="
          width: 20px;
          height: 20px;
          cursor: ${disabled ? 'not-allowed' : 'pointer'};
          accent-color: $active;
        "
        $onChangeAttr
      />
    ''';
  }
}

/// A radio button widget
class Radio<T> extends Widget {
  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final FlartColor? activeColor;

  Radio({
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.activeColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'radio_${DateTime.now().microsecondsSinceEpoch}';
    final active = activeColor?.toString() ?? '#6200ea';
    final checked = value == groupValue;
    final disabled = onChanged == null;

    String onChangeAttr = '';
    if (onChanged != null) {
      // Radio only triggers if not already checked (usually)
      final cbId = FlartCallbackManager.register(() => onChanged!(value));
      onChangeAttr = 'onchange="window.__flartHandleClick(\'$cbId\')"';
    }

    return '''
      <input 
        type="radio" 
        id="$id" 
        ${checked ? 'checked' : ''} 
        ${disabled ? 'disabled' : ''}
        style="
          width: 20px;
          height: 20px;
          cursor: ${disabled ? 'not-allowed' : 'pointer'};
          accent-color: $active;
        "
        $onChangeAttr
      />
    ''';
  }
}

/// A switch/toggle widget
class Switch extends Widget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? inactiveColor;

  Switch({
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'switch_${DateTime.now().microsecondsSinceEpoch}';
    final active = activeColor?.toString() ?? '#6200ea';
    final inactive = inactiveColor?.toString() ?? '#cccccc';
    final disabled = onChanged == null;

    String onChangeAttr = '';
    if (onChanged != null) {
      // Toggle
      final cbId = FlartCallbackManager.register(() => onChanged!(!value));
      onChangeAttr = 'onchange="window.__flartHandleClick(\'$cbId\')"';
    }

    return '''
      <label style="
        display: inline-flex;
        align-items: center;
        cursor: ${disabled ? 'not-allowed' : 'pointer'};
        opacity: ${disabled ? '0.5' : '1'};
      ">
        <input 
          type="checkbox" 
          id="$id" 
          ${value ? 'checked' : ''} 
          ${disabled ? 'disabled' : ''}
          style="display: none;"
          $onChangeAttr
        />
        <div style="
          width: 50px;
          height: 26px;
          background-color: ${value ? active : inactive};
          border-radius: 13px;
          position: relative;
          transition: background-color 0.3s;
        ">
          <div style="
            width: 22px;
            height: 22px;
            background-color: white;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: ${value ? '26px' : '2px'};
            transition: left 0.3s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
          "></div>
        </div>
      </label>
    ''';
  }
}
