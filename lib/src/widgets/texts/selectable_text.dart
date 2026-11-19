import '../../../flartdart.dart';

typedef SelectableText = FDSelectableText;

class FDSelectableText extends Widget {
  final String content;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final VoidCallback? onTap;

  const FDSelectableText(
    this.content, {
    this.style,
    this.textAlign,
    this.maxLines,
    this.onTap,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final themeStyle = Theme.of(context).textStyle;

    final styleMap = <String, String>{
      'box-sizing': 'border-box',
      'user-select': 'text',
      '-webkit-user-select': 'text',
      'cursor': 'text',
      'display': 'block',
      ...themeStyle.toCss(),
      ...(style?.toCss() ?? {}),
      if (textAlign != null) 'text-align': textAlign.toString().split('.').last,
    };

    if (maxLines != null) {
      styleMap['display'] = '-webkit-box';
      styleMap['-webkit-line-clamp'] = maxLines.toString();
      styleMap['-webkit-box-orient'] = 'vertical';
      styleMap['overflow'] = 'hidden';
    }

    return FlartElementNode(
      'span',
      id: key?.toString(),
      styles: styleMap,
      events: onTap != null ? {'click': (_) => onTap!()} : null,
      children: [FlartTextNode(content)],
    );
  }
}
