import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// A Checkbox widget
class FDCheckbox extends Widget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? checkColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDCheckbox({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor?.toString() ?? theme.primaryColor.toString();
    final disabled = onChanged == null;

    final styles = <String, String>{
      'width': '20px',
      'height': '20px',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'accent-color': active,
      'transition': 'accent-color 0.2s',
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

    final events = <String, void Function(web.Event)>{};
    if (onChanged != null) {
      events['change'] = (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        final isChecked = target?.checked ?? !value;
        onChanged!(isChecked);
      };
    }

    return FlartElementNode(
      'input',
      id: key?.toString(),
      attributes: {
        'type': 'checkbox',
        if (value) 'checked': 'true',
        if (disabled) 'disabled': 'true',
      },
      styles: styles,
      events: events,
    );
  }
}

/// A Radio Button widget
class FDRadio<T> extends Widget {
  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final FlartColor? activeColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor?.toString() ?? theme.primaryColor.toString();
    final checked = value == groupValue;
    final disabled = onChanged == null;

    final styles = <String, String>{
      'width': '20px',
      'height': '20px',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'accent-color': active,
      'transition': 'accent-color 0.2s',
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

    final events = <String, void Function(web.Event)>{};
    if (onChanged != null) {
      events['change'] = (web.Event e) {
        onChanged!(value);
      };
    }

    return FlartElementNode(
      'input',
      id: key?.toString(),
      attributes: {
        'type': 'radio',
        if (checked) 'checked': 'true',
        if (disabled) 'disabled': 'true',
      },
      styles: styles,
      events: events,
    );
  }
}

/// A switch/toggle widget
class FDSwitch extends Widget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? inactiveColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDSwitch({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor?.toString() ?? theme.primaryColor.toString();
    final inactive = inactiveColor?.toString() ?? theme.dividerColor.toString();
    final disabled = onChanged == null;

    final containerStyles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'opacity': disabled ? '0.5' : '1',
      'user-select': 'none',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          containerStyles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final events = <String, void Function(web.Event)>{};
    if (onChanged != null) {
      events['click'] = (web.Event e) {
        onChanged!(!value);
      };
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {
        'class': 'flart-switch',
        'role': 'switch',
        'aria-checked': value ? 'true' : 'false',
      },
      styles: containerStyles,
      events: events,
      children: [
        FlartElementNode(
          'div',
          styles: {
            'width': '50px',
            'height': '26px',
            'background-color': value ? active : inactive,
            'border-radius': '13px',
            'position': 'relative',
            'transition': 'background-color 0.3s',
          },
          children: [
            FlartElementNode(
              'div',
              styles: {
                'width': '22px',
                'height': '22px',
                'background-color': 'white',
                'border-radius': '50%',
                'position': 'absolute',
                'top': '2px',
                'left': value ? '26px' : '2px',
                'transition': 'left 0.3s',
                'box-shadow': '0 2px 4px rgba(0,0,0,0.2)',
              },
            ),
          ],
        ),
      ],
    );
  }
}
