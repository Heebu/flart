import '../../../flartdart.dart';

/// A Chip widget for displaying compact information
class FDChip extends Widget {
  final Widget label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;
  final FlartColor? backgroundColor;
  final EdgeInsets? padding;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDChip({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.backgroundColor,
    this.padding,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor =
        backgroundColor?.toString() ?? theme.dividerColor.toString();
    final pad =
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6);

    final styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'background-color': bgColor,
      'color': theme.textStyle.color.toString(),
      'border-radius': '16px',
      'padding': pad.toCss(),
      'gap': '8px',
      if (onTap != null) 'cursor': 'pointer',
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

    if (avatar != null) {
      children.add(FlartElementNode(
        'div',
        styles: {
          'width': '24px',
          'height': '24px',
          'border-radius': '50%',
          'overflow': 'hidden',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
        },
        children: [avatar!.buildNode(context)],
      ));
    }

    children.add(label.buildNode(context));

    if (onDeleted != null) {
      final delEvents = <String, void Function(dynamic)>{
        'click': (e) {
          onDeleted!();
        },
      };

      children.add(FlartElementNode(
        'div',
        attributes: {'class': 'flart-chip-delete', 'role': 'button', 'aria-label': 'Delete'},
        styles: {
          'cursor': 'pointer',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '18px',
          'height': '18px',
          'border-radius': '50%',
          'background-color': 'rgba(0,0,0,0.1)',
          'user-select': 'none',
        },
        events: delEvents,
        children: [
          deleteIcon != null
              ? deleteIcon!.buildNode(context)
              : FlartTextNode('×'),
        ],
      ));
    }

    final chipEvents = <String, void Function(dynamic)>{};
    if (onTap != null) {
      chipEvents['click'] = (e) => onTap!();
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-chip'},
      styles: styles,
      events: chipEvents.isNotEmpty ? chipEvents : null,
      children: children,
    );
  }
}

/// A Badge widget for displaying notification counters and badges
class FDBadge extends Widget {
  final Widget child;
  final dynamic label;
  final FlartColor? backgroundColor;
  final FlartColor? textColor;
  final bool isVisible;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDBadge({
    required this.child,
    this.label,
    this.backgroundColor,
    this.textColor,
    this.isVisible = true,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor?.toString() ?? theme.errorColor.toString();
    final color = textColor?.toString() ?? '#ffffff';

    final styles = <String, String>{
      'position': 'relative',
      'display': 'inline-block',
      ...?cssStyle,
    };

    final children = <FlartNode>[child.buildNode(context)];

    if (isVisible && label != null) {
      final labelNode = label is Widget
          ? (label as Widget).buildNode(context)
          : FlartTextNode(label.toString());

      children.add(FlartElementNode(
        'div',
        attributes: {'class': 'flart-badge-label'},
        styles: {
          'position': 'absolute',
          'top': '-8px',
          'right': '-8px',
          'background-color': bgColor,
          'color': color,
          'border-radius': '10px',
          'padding': '2px 6px',
          'font-size': '10px',
          'font-weight': 'bold',
          'min-width': '18px',
          'text-align': 'center',
          'box-shadow': '0 1px 2px rgba(0,0,0,0.3)',
          'user-select': 'none',
        },
        children: [labelNode],
      ));
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-badge-container'},
      styles: styles,
      children: children,
    );
  }
}
