import '../../../flartdart.dart';

enum ListTileControlAffinity {
  leading,
  trailing,
  platform,
}

typedef ListTile = FDListTile;
typedef CheckboxListTile = FDCheckboxListTile;
typedef SwitchListTile = FDSwitchListTile;
typedef RadioListTile<T> = FDRadioListTile<T>;

/// A single fixed-height row that typically contains some text as well as a leading or trailing icon.
class FDListTile extends Widget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool dense;
  final bool enabled;
  final bool selected;
  final EdgeInsets? contentPadding;
  final FlartColor? tileColor;
  final FlartColor? selectedTileColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.dense = false,
    this.enabled = true,
    this.selected = false,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final pad = contentPadding ??
        EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: dense ? 4.0 : 8.0,
        );

    final bg = selected
        ? (selectedTileColor?.toString() ??
            theme.primaryColor.withOpacity(0.1).toString())
        : (tileColor?.toString() ?? 'transparent');

    final styles = <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'padding': pad.toCss(),
      'background-color': bg,
      'min-height': dense ? '40px' : '48px',
      'cursor': enabled && onTap != null ? 'pointer' : 'default',
      'user-select': 'none',
      'transition': 'background-color 0.2s',
      'box-sizing': 'border-box',
      if (!enabled) 'opacity': '0.5',
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

    final children = <FlartNode>[];

    if (leading != null) {
      children.add(
        FlartElementNode(
          'div',
          styles: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'margin-right': '16px',
            'flex-shrink': '0',
          },
          children: [leading!.buildNode(context)],
        ),
      );
    }

    // Title & Subtitle column
    final textChildren = <FlartNode>[];
    if (title != null) {
      textChildren.add(
        FlartElementNode(
          'div',
          styles: {
            'font-size': dense ? '14px' : '16px',
            'font-weight': '500',
            'color': selected
                ? theme.primaryColor.toString()
                : (theme.textStyle.color?.toString() ?? '#212121'),
            'line-height': '1.3',
          },
          children: [title!.buildNode(context)],
        ),
      );
    }
    if (subtitle != null) {
      textChildren.add(
        FlartElementNode(
          'div',
          styles: {
            'font-size': dense ? '12px' : '14px',
            'color': '#757575',
            'margin-top': '2px',
            'line-height': '1.3',
          },
          children: [subtitle!.buildNode(context)],
        ),
      );
    }

    children.add(
      FlartElementNode(
        'div',
        styles: {
          'flex': '1',
          'min-width': '0',
          'display': 'flex',
          'flex-direction': 'column',
          'justify-content': 'center',
        },
        children: textChildren,
      ),
    );

    if (trailing != null) {
      children.add(
        FlartElementNode(
          'div',
          styles: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'margin-left': '16px',
            'flex-shrink': '0',
          },
          children: [trailing!.buildNode(context)],
        ),
      );
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {
        'role': 'listitem',
        'class': 'flart-list-tile',
      },
      styles: styles,
      events: {
        if (enabled && onTap != null) 'click': (_) => onTap!(),
      },
      children: children,
    );
  }
}

/// A [FDListTile] with a [FDCheckbox].
class FDCheckboxListTile extends Widget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final FlartColor? activeColor;
  final FlartColor? checkColor;
  final bool dense;
  final bool selected;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets? contentPadding;

  const FDCheckboxListTile({
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.checkColor,
    this.dense = false,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.contentPadding,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final checkbox = FDCheckbox(
      value: value ?? false,
      onChanged: onChanged != null ? (v) => onChanged!(v) : null,
      activeColor: activeColor,
      checkColor: checkColor,
    );

    final isLeading = controlAffinity == ListTileControlAffinity.leading;

    return FDListTile(
      key: key,
      leading: isLeading ? checkbox : secondary,
      title: title,
      subtitle: subtitle,
      trailing: isLeading ? secondary : checkbox,
      dense: dense,
      selected: selected,
      contentPadding: contentPadding,
      onTap: onChanged != null ? () => onChanged!(!(value ?? false)) : null,
    ).buildNode(context);
  }
}

/// A [FDListTile] with a [FDSwitch].
class FDSwitchListTile extends Widget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final FlartColor? activeColor;
  final bool dense;
  final bool selected;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets? contentPadding;

  const FDSwitchListTile({
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.dense = false,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.contentPadding,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final switchWidget = FDSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );

    final isLeading = controlAffinity == ListTileControlAffinity.leading;

    return FDListTile(
      key: key,
      leading: isLeading ? switchWidget : secondary,
      title: title,
      subtitle: subtitle,
      trailing: isLeading ? secondary : switchWidget,
      dense: dense,
      selected: selected,
      contentPadding: contentPadding,
      onTap: onChanged != null ? () => onChanged!(!value) : null,
    ).buildNode(context);
  }
}

/// A [FDListTile] with a [FDRadio].
class FDRadioListTile<T> extends Widget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final FlartColor? activeColor;
  final bool dense;
  final bool selected;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets? contentPadding;

  const FDRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.dense = false,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.contentPadding,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final radio = FDRadio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor,
    );

    final isLeading = controlAffinity == ListTileControlAffinity.leading;

    return FDListTile(
      key: key,
      leading: isLeading ? radio : secondary,
      title: title,
      subtitle: subtitle,
      trailing: isLeading ? secondary : radio,
      dense: dense,
      selected: selected,
      contentPadding: contentPadding,
      onTap: onChanged != null ? () => onChanged!(value) : null,
    ).buildNode(context);
  }
}
