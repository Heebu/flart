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
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.primaryColor;

    final styles = <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'space-between',
      'padding': '0 16px',
      'height': '56px',
      'background-color': bg.toString(),
      'transition': 'background-color 0.3s ease, color 0.3s ease',
      'box-shadow': '0 ${elevation}px ${elevation * 2}px rgba(0,0,0,0.15)',
      'color': 'white',
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
      children.add(FlartElementNode(
        'div',
        styles: {'margin-right': '16px'},
        children: [leading!.buildNode(context)],
      ));
    }

    children.add(FlartElementNode(
      'div',
      styles: {'flex': '1', 'font-size': '20px', 'font-weight': '500'},
      children: title != null ? [title!.buildNode(context)] : [],
    ));

    if (actions != null && actions!.isNotEmpty) {
      children.add(FlartElementNode(
        'div',
        styles: {'display': 'flex', 'gap': '8px'},
        children: actions!.map((a) => a.buildNode(context)).toList(),
      ));
    }

    return FlartElementNode(
      'div',
      styles: styles,
      children: children,
    );
  }
}
