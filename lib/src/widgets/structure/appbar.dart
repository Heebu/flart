import 'package:flart_project/flart.dart';

class AppBar extends Widget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final FlartColor backgroundColor;
  final double elevation;

  AppBar({
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor = FlartColors.blue,
    this.elevation = 4.0,
  });

  @override
  String render(BuildContext context) {
    final buffer = StringBuffer();

    buffer.writeln('''
    <div style="
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 16px;
      height: 56px;
      background-color: $backgroundColor;
      box-shadow: 0 ${elevation}px ${elevation * 2}px rgba(0,0,0,0.2);
      color: white;
    ">
    ''');

    // Leading (e.g., menu icon)
    buffer.write('<div style="margin-right: 16px;">${leading?.render(context) ?? ''}</div>');

    // Title
    buffer.write('<div style="flex: 1; font-size: 20px; font-weight: 500;">${title?.render(context) ?? ''}</div>');

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
