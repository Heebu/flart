import '../../../flartdart.dart';

typedef AlertDialog = FDAlertDialog;

class FDAlertDialog extends Widget {
  final Widget? icon;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsets? contentPadding;
  final EdgeInsets? actionsPadding;
  final FlartColor? backgroundColor;
  final BorderRadius? borderRadius;
  final String? rawCss;

  const FDAlertDialog({
    this.icon,
    this.title,
    this.content,
    this.actions,
    this.contentPadding,
    this.actionsPadding,
    this.backgroundColor,
    this.borderRadius,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor?.toString() ?? '#ffffff';
    final radius = borderRadius ?? const BorderRadius.all(8.0);
    final cPad = contentPadding ?? const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0);
    final aPad = actionsPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

    final dialogChildren = <FlartNode>[];

    if (icon != null) {
      dialogChildren.add(
        FlartElementNode(
          'div',
          styles: {
            'display': 'flex',
            'justify-content': 'center',
            'padding-top': '24px',
            'padding-bottom': '16px',
          },
          children: [icon!.buildNode(context)],
        ),
      );
    }

    if (title != null) {
      dialogChildren.add(
        FlartElementNode(
          'div',
          styles: {
            'font-size': '20px',
            'font-weight': '600',
            'color': theme.textStyle.color?.toString() ?? '#212121',
            'padding': '24px 24px 12px 24px',
          },
          children: [title!.buildNode(context)],
        ),
      );
    }

    if (content != null) {
      dialogChildren.add(
        FlartElementNode(
          'div',
          styles: {
            'font-size': '15px',
            'color': '#616161',
            'padding': cPad.toCss(),
            'line-height': '1.4',
            'flex': '1',
            'overflow-y': 'auto',
          },
          children: [content!.buildNode(context)],
        ),
      );
    }

    if (actions != null && actions!.isNotEmpty) {
      dialogChildren.add(
        FlartElementNode(
          'div',
          styles: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'flex-end',
            'gap': '8px',
            'padding': aPad.toCss(),
            'border-top': '1px solid ${theme.dividerColor}',
          },
          children: actions!.map((a) => a.buildNode(context)).toList(),
        ),
      );
    }

    final styles = <String, String>{
      'background-color': bg,
      'border-radius': radius.toCss(),
      'box-shadow': '0 11px 15px -7px rgba(0,0,0,0.2), 0 24px 38px 3px rgba(0,0,0,0.14), 0 9px 46px 8px rgba(0,0,0,0.12)',
      'min-width': '280px',
      'max-width': '560px',
      'display': 'flex',
      'flex-direction': 'column',
      'overflow': 'hidden',
      'box-sizing': 'border-box',
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

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {
        'role': 'alertdialog',
        'aria-modal': 'true',
        'class': 'flart-alert-dialog',
      },
      styles: styles,
      children: dialogChildren,
    );
  }
}
