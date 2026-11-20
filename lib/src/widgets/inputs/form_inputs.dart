import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef Checkbox = FDCheckbox;
typedef Radio<T> = FDRadio<T>;
typedef Switch = FDSwitch;

/// A material design checkbox following Flutter's [Checkbox] specification.
class FDCheckbox extends Widget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? checkColor;
  final FlartColor? focusColor;
  final FlartColor? hoverColor;
  final bool tristate;

  const FDCheckbox({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.tristate = false,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor?.toString() ?? theme.primaryColor.toString();
    final disabled = onChanged == null;
    final isChecked = value ?? false;

    final styles = <String, String>{
      'width': '18px',
      'height': '18px',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'accent-color': active,
      'margin': '0',
      'vertical-align': 'middle',
      'transition': 'accent-color 0.2s',
    };

    final events = <String, void Function(web.Event)>{};
    if (onChanged != null) {
      events['change'] = (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        if (tristate) {
          if (value == null) {
            onChanged!(true);
          } else if (value == true) {
            onChanged!(false);
          } else {
            onChanged!(null);
          }
        } else {
          final checked = target?.checked ?? !isChecked;
          onChanged!(checked);
        }
      };
    }

    return FlartElementNode(
      'input',
      id: key?.toString(),
      attributes: {
        'type': 'checkbox',
        if (isChecked) 'checked': 'true',
        if (disabled) 'disabled': 'true',
        'role': 'checkbox',
        'aria-checked':
            value == null ? 'mixed' : (isChecked ? 'true' : 'false'),
      },
      styles: styles,
      events: events,
    );
  }
}

/// A material design radio button following Flutter's [Radio] specification.
class FDRadio<T> extends Widget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? focusColor;
  final FlartColor? hoverColor;

  const FDRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor?.toString() ?? theme.primaryColor.toString();
    final checked = value == groupValue;
    final disabled = onChanged == null;

    final styles = <String, String>{
      'width': '18px',
      'height': '18px',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'accent-color': active,
      'margin': '0',
      'vertical-align': 'middle',
      'transition': 'accent-color 0.2s',
    };

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
        'role': 'radio',
        'aria-checked': checked ? 'true' : 'false',
      },
      styles: styles,
      events: events,
    );
  }
}

/// A material design switch following Flutter's [Switch] specification.
class FDSwitch extends Widget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? activeTrackColor;
  final FlartColor? inactiveThumbColor;
  final FlartColor? inactiveTrackColor;

  const FDSwitch({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final activeThumb =
        activeColor?.toString() ?? theme.primaryColor.toString();
    final activeTrack = activeTrackColor?.toString() ??
        theme.primaryColor.withOpacity(0.5).toString();
    final inactiveThumb = inactiveThumbColor?.toString() ?? '#fafafa';
    final inactiveTrack = inactiveTrackColor?.toString() ?? '#bdbdbd';
    final disabled = onChanged == null;

    final containerStyles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'opacity': disabled ? '0.5' : '1',
      'user-select': 'none',
      'vertical-align': 'middle',
    };

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
            'width': '46px',
            'height': '24px',
            'background-color': value ? activeTrack : inactiveTrack,
            'border-radius': '12px',
            'position': 'relative',
            'transition': 'background-color 0.25s ease',
          },
          children: [
            FlartElementNode(
              'div',
              styles: {
                'width': '20px',
                'height': '20px',
                'background-color': value ? activeThumb : inactiveThumb,
                'border-radius': '50%',
                'position': 'absolute',
                'top': '2px',
                'left': value ? '24px' : '2px',
                'transition': 'left 0.25s ease, background-color 0.25s ease',
                'box-shadow': '0 2px 4px rgba(0,0,0,0.25)',
              },
            ),
          ],
        ),
      ],
    );
  }
}
