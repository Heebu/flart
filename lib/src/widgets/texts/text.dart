import '../../../flartdart.dart';

typedef Text = FDText;

class FDText extends Widget {
  final String content;
  final TextSpan? textSpan;
  final TextStyle? style;
  final TextTag? tag;
  final TextAlign? textAlign;
  final bool selectable;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDirection? textDirection;
  final String? semanticsLabel;

  const FDText(
    this.content, {
    this.style,
    this.tag = TextTag.span,
    this.textAlign,
    this.selectable = false,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    super.key,
  }) : textSpan = null;

  const FDText.rich(
    TextSpan this.textSpan, {
    this.style,
    this.tag = TextTag.span,
    this.textAlign,
    this.selectable = false,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    super.key,
  }) : content = '';

  @override
  FlartNode buildNode(BuildContext context) {
    final themeStyle = Theme.of(context).textStyle;

    final combinedStyle = <String, String>{
      'box-sizing': 'border-box',
      ...themeStyle.toCss(),
      ...(style?.toCss() ?? {}),
      if (!selectable) 'user-select': 'none',
    };

    if (textAlign != null) {
      combinedStyle['text-align'] = textAlign.toString().split('.').last;
      if (tag == TextTag.span) {
        combinedStyle['display'] = 'block';
      }
    }

    if (overflow == TextOverflow.ellipsis && maxLines == null) {
      combinedStyle['white-space'] = 'nowrap';
      combinedStyle['overflow'] = 'hidden';
      combinedStyle['text-overflow'] = 'ellipsis';
      combinedStyle['display'] = 'block';
    } else if (maxLines != null) {
      combinedStyle['display'] = '-webkit-box';
      combinedStyle['-webkit-line-clamp'] = maxLines.toString();
      combinedStyle['-webkit-box-orient'] = 'vertical';
      combinedStyle['overflow'] = 'hidden';
      if (overflow == TextOverflow.ellipsis || overflow == null) {
        combinedStyle['text-overflow'] = 'ellipsis';
      }
    } else if (overflow == TextOverflow.clip) {
      combinedStyle['overflow'] = 'hidden';
    }

    if (softWrap == false) {
      combinedStyle['white-space'] = 'nowrap';
    }

    if (textDirection != null) {
      combinedStyle['direction'] = textDirection!.name;
    }

    final tagName = tag.toString().split('.').last;

    final attributes = <String, String>{
      if (semanticsLabel != null) 'aria-label': semanticsLabel!,
    };

    if (textSpan != null) {
      return FlartElementNode(
        tagName,
        id: key?.toString(),
        attributes: attributes,
        styles: combinedStyle,
        children: [_buildSpanNode(textSpan!)],
      );
    }

    return FlartElementNode(
      tagName,
      id: key?.toString(),
      attributes: attributes,
      styles: combinedStyle,
      children: [FlartTextNode(content)],
    );
  }

  FlartNode _buildSpanNode(TextSpan span) {
    final spanStyles = <String, String>{};
    if (span.style != null) {
      spanStyles.addAll(span.style!.toCss());
    }
    if (span.onTap != null) {
      spanStyles['cursor'] = 'pointer';
    }

    final children = <FlartNode>[];
    if (span.text != null && span.text!.isNotEmpty) {
      children.add(FlartTextNode(span.text!));
    }
    if (span.children != null) {
      for (final child in span.children!) {
        children.add(_buildSpanNode(child));
      }
    }

    return FlartElementNode(
      'span',
      styles: spanStyles,
      events: span.onTap != null ? {'click': (_) => span.onTap!()} : null,
      children: children,
    );
  }
}
