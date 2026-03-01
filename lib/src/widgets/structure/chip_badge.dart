import '../../../flartdart.dart';

/// A FDChip widget for displaying compact information
class FDChip extends Widget {
  final Widget label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final VoidCallback? onDeleted;
  final FlartColor? backgroundColor;
  final EdgeInsets? padding;
  final String? rawCss;

  const FDChip({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.backgroundColor,
    this.padding,
    this.rawCss,
    Key? key,
  }) : super(key: key);

  @override
  String render(BuildContext context) {
    final theme = Theme.of(context);
    final id = 'chip_${DateTime.now().microsecondsSinceEpoch}';
    final bgColor =
        backgroundColor?.toString() ?? theme.dividerColor.toString();
    final pad =
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6);

    return '''
      <div id="$id" style="
        display: inline-flex;
        align-items: center;
        background-color: $bgColor;
        color: ${theme.textStyle.color};
        border-radius: 16px;
        padding: ${pad.toCss()};
        gap: 8px;
        ${rawCss ?? ''}
      ">
        ${avatar != null ? '<div style="width: 24px; height: 24px; border-radius: 50%; overflow: hidden;">${avatar!.render(context)}</div>' : ''}
        ${label.render(context)}
        ${onDeleted != null ? '''
          <div onclick="document.getElementById('$id').remove()" style="
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background-color: rgba(0,0,0,0.1);
          ">
            ${deleteIcon?.render(context) ?? 'Ã—'}
          </div>
        ''' : ''}
      </div>
    ''';
  }
}

/// A FDBadge widget for displaying notifications
class FDBadge extends Widget {
  final Widget child;
  final String? label;
  final FlartColor? backgroundColor;
  final FlartColor? textColor;
  final bool isVisible;
  final String? rawCss;

  const FDBadge({
    required this.child,
    this.label,
    this.backgroundColor,
    this.textColor,
    this.isVisible = true,
    this.rawCss,
    Key? key,
  }) : super(key: key);

  @override
  String render(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor?.toString() ?? theme.errorColor.toString();
    final color = textColor?.toString() ?? '#ffffff';

    return '''
      <div style="position: relative; display: inline-block; ${rawCss ?? ''}">
        ${child.render(context)}
        ${isVisible && label != null ? '''
          <div style="
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: $bgColor;
            color: $color;
            border-radius: 10px;
            padding: 2px 6px;
            font-size: 10px;
            font-weight: bold;
            min-width: 18px;
            text-align: center;
            box-shadow: 0 1px 2px rgba(0,0,0,0.3);
          ">$label</div>
        ''' : ''}
      </div>
    ''';
  }
}
