import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// A dropdown/select widget
class FDDropdownButton<T> extends Widget {
  final T? value;
  final List<FDDropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;
  final double? width;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDropdownButton({
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.width,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final disabled = onChanged == null;

    final styles = <String, String>{
      'padding': '8px 12px',
      'border': '1px solid #ccc',
      'border-radius': '4px',
      'background-color': 'white',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'font-size': '14px',
      if (width != null) 'width': '${width}px',
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

    final options = <FlartNode>[];

    if (hint != null && value == null) {
      options.add(FlartElementNode(
        'option',
        attributes: {'value': '', 'disabled': 'true', 'selected': 'true'},
        children: [hint!.buildNode(context)],
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
          if (selectedIdx != null && selectedIdx >= 0 && selectedIdx < items.length) {
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

typedef DropdownButton<T> = FDDropdownButton<T>;

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

typedef DropdownMenuItem<T> = FDDropdownMenuItem<T>;

/// A Slider widget
class FDSlider extends Widget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final FlartColor? activeColor;
  final FlartColor? inactiveColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDSlider({
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final active = activeColor?.toString() ?? '#6200ea';
    final disabled = onChanged == null;
    final step = divisions != null ? '${(max - min) / divisions!}' : 'any';

    final styles = <String, String>{
      'width': '100%',
      'height': '6px',
      'border-radius': '3px',
      'outline': 'none',
      'cursor': disabled ? 'not-allowed' : 'pointer',
      'accent-color': active,
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
            onChanged!(val);
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
        if (disabled) 'disabled': 'true',
      },
      styles: styles,
      events: events,
    );
  }
}
