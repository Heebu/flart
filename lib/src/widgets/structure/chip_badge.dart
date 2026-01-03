import '../../../flartdart.dart';

/// A chip widget for displaying compact information
class Chip extends Widget {
  final Widget label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final VoidCallback? onDeleted;
  final FlartColor? backgroundColor;
  final EdgeInsets? padding;

  Chip({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.backgroundColor,
    this.padding,
  });

  @override
  String render(BuildContext context) {
    final id = 'chip_${DateTime.now().microsecondsSinceEpoch}';
    final bgColor = backgroundColor?.toString() ?? '#e0e0e0';
    final pad = padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 6);

    return '''
      <div id="$id" style="
        display: inline-flex;
        align-items: center;
        background-color: $bgColor;
        border-radius: 16px;
        padding: ${pad.toCss()};
        gap: 8px;
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
            ${deleteIcon?.render(context) ?? '×'}
          </div>
        ''' : ''}
      </div>
    ''';
  }
}

/// A badge widget for displaying notifications
class Badge extends Widget {
  final Widget child;
  final String? label;
  final FlartColor? backgroundColor;
  final FlartColor? textColor;
  final bool isVisible;

  Badge({
    required this.child,
    this.label,
    this.backgroundColor,
    this.textColor,
    this.isVisible = true,
  });

  @override
  String render(BuildContext context) {
    final bgColor = backgroundColor?.toString() ?? '#f44336';
    final color = textColor?.toString() ?? '#ffffff';

    return '''
      <div style="position: relative; display: inline-block;">
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
            font-size: 12px;
            font-weight: bold;
            min-width: 20px;
            text-align: center;
          ">$label</div>
        ''' : ''}
      </div>
    ''';
  }
}
