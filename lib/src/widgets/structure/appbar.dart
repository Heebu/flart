import '../../../flartdart.dart';

class FDAppBar extends Widget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final FlartColor? backgroundColor;
  final double elevation;
  final String? rawCss;

  const FDAppBar({
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 4.0,
    this.rawCss,
    super.key,
  });

  @override
  String render(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.primaryColor;
    final buffer = StringBuffer();

    buffer.writeln('''
    <div style="
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 16px;
      height: 56px;
      background-color: $bg;
      transition: background-color 0.3s ease, color 0.3s ease;
      box-shadow: 0 ${elevation}px ${elevation * 2}px rgba(0,0,0,0.15);
      color: white;
      ${rawCss ?? ''}
    ">
    ''');

    // Leading (e.g., menu FDIcon)
    if (leading != null) {
      buffer.write(
          '<div style="margin-right: 16px;">${leading!.render(context)}</div>');
    }

    // Title
    buffer.write(
        '<div style="flex: 1; font-size: 20px; font-weight: 500;">${title?.render(context) ?? ''}</div>');

    // Actions
    if (actions != null && actions!.isNotEmpty) {
      buffer.write('<div style="display: flex; gap: 8px;">');
      for (var action in actions!) {
        buffer.write(action.render(context));
      }
      buffer.write('</div>');
    }

    buffer.writeln('</div>');
    return buffer.toString();
  }
}
