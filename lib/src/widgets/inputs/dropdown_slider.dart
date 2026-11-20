import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef DropdownButton<T> = FDDropdownButton<T>;
typedef DropdownMenuItem<T> = FDDropdownMenuItem<T>;
typedef Slider = FDSlider;

/// A dropdown / select widget following Flutter's [DropdownButton] specification.
class FDDropdownButton<T> extends Widget {
  final T? value;
  final List<FDDropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;
  final Widget? disabledHint;
  final double? width;
  final FlartColor? dropdownColor;
  final BorderRadius? borderRadius;
  final TextStyle? style;
  final bool isExpanded;

  const FDDropdownButton({
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.disabledHint,
    this.width,
    this.dropdownColor,
    this.borderRadius,
    this.style,
    this.isExpanded = false,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final disabled = onChanged == null;
    final radius = borderRadius?.topLeft ?? 4.0;

    final styles = <String, String>{
      'padding': '8px 12px',
      'border': '1px solid ${theme.dividerColor}',
      'border-radius': '${radius}px',
      'background-color':
          dropdownColor?.toString() ?? theme.cardColor.toString(),
      'color': style?.color?.toString() ??
          theme.textStyle.color?.toString() ??
          '#333333',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'font-size': '${style?.fontSize ?? 14}px',
      'font-family': 'inherit',
      'outline': 'none',
      if (isExpanded)
        'width': '100%'
      else if (width != null)
        'width': '${width}px',
      'box-sizing': 'border-box',
    };

    final options = <FlartNode>[];

    if (hint != null && value == null) {
      options.add(FlartElementNode(
        'option',
        attributes: {'value': '', 'disabled': 'true', 'selected': 'true'},
        children: [hint!.buildNode(context)],
      ));
    } else if (disabledHint != null && disabled) {
      options.add(FlartElementNode(
        'option',
        attributes: {'value': '', 'disabled': 'true', 'selected': 'true'},
        children: [disabledHint!.buildNode(context)],
      ));
    }

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final isSelected = item.value == value;

      options.add(FlartElementNode(
        'option',
        attributes: {
          'value': '$i',
          if (isSelected) 'selected': 'true',
        },
        children: [item.child.buildNode(context)],
      ));
    }

    final events = <String, void Function(web.Event)>{};
    if (onChanged != null) {
      events['change'] = (web.Event e) {
        final target = e.target as web.HTMLSelectElement?;
        if (target != null) {
          final selectedIdx = int.tryParse(target.value);
          if (selectedIdx != null &&
              selectedIdx >= 0 &&
              selectedIdx < items.length) {
            onChanged!(items[selectedIdx].value);
          }
        }
      };
    }

    return FlartElementNode(
      'select',
      id: key?.toString(),
      attributes: {
        'class': 'flart-dropdown-select',
        if (disabled) 'disabled': 'true',
      },
      styles: styles,
      events: events,
      children: options,
    );
  }
}

/// An item in a [FDDropdownButton] menu.
class FDDropdownMenuItem<T> extends Widget {
  final T value;
  final Widget child;

  const FDDropdownMenuItem({
    required this.value,
    required this.child,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) => child.buildNode(context);
}

/// A slider input widget following Flutter's [Slider] specification.
class FDSlider extends Widget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final FlartColor? activeColor;
  final FlartColor? inactiveColor;

  const FDSlider({
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.activeColor,
    this.inactiveColor,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor?.toString() ?? theme.primaryColor.toString();
    final disabled = onChanged == null;
    final step = divisions != null ? '${(max - min) / divisions!}' : 'any';

    final styles = <String, String>{
      'width': '100%',
      'height': '6px',
      'border-radius': '3px',
      'outline': 'none',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'accent-color': active,
      'margin': '8px 0',
      'vertical-align': 'middle',
    };

    final events = <String, void Function(web.Event)>{};
    if (onChanged != null) {
      events['input'] = (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        if (target != null) {
          final val = double.tryParse(target.value);
          if (val != null) {
            onChanged!(val);
          }
        }
      };
      events['change'] = (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        if (target != null) {
          final val = double.tryParse(target.value);
          if (val != null) {
            onChangeEnd?.call(val);
          }
        }
      };
    }

    return FlartElementNode(
      'input',
      id: key?.toString(),
      attributes: {
        'type': 'range',
        'min': '$min',
        'max': '$max',
        'value': '$value',
        'step': step,
        if (label != null) 'title': label!,
        if (disabled) 'disabled': 'true',
        'role': 'slider',
        'aria-valuenow': '$value',
        'aria-valuemin': '$min',
        'aria-valuemax': '$max',
      },
      styles: styles,
      events: events,
    );
  }
}
