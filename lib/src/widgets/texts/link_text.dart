import '../../../flartdart.dart';

typedef LinkText = FDLinkText;

class FDLinkText extends Widget {
  final String label;
  final String? href;
  final String target;
  final VoidCallback? onPressed;
  final TextStyle? style;

  const FDLinkText({
    String? label,
    String? text,
    String? href,
    String? url,
    this.target = '_blank',
    this.onPressed,
    this.style,
    super.key,
  })  : label = label ?? text ?? '',
        href = href ?? url;

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = context.theme;

    final styleMap = <String, String>{
      'box-sizing': 'border-box',
      'color': style?.color?.toString() ?? theme.primaryColor.toString(),
      'font-size': style?.fontSize != null ? '${style!.fontSize}px' : '16px',
      'text-decoration': 'underline',
      'cursor': 'pointer',
      'transition': 'opacity 0.2s ease',
      'display': 'inline',
      ...(style?.toCss() ?? {}),
    };

    final events = <String, void Function(dynamic)>{};
    if (onPressed != null) {
      events['click'] = (e) => onPressed!();
    }

    if (href != null) {
      return FlartElementNode(
        'a',
        id: key?.toString(),
        attributes: {
          'href': href!,
          'target': target,
          'rel': 'noopener noreferrer',
        },
        styles: styleMap,
        events: events.isNotEmpty ? events : null,
        children: [FlartTextNode(label)],
      );
    }

    return FlartElementNode(
      'span',
      id: key?.toString(),
      styles: styleMap,
      events: events.isNotEmpty ? events : null,
      children: [FlartTextNode(label)],
    );
  }
}
