import '../../../flartdart.dart';

typedef RichText = FDRichText;

class FDRichText extends Widget {
  final TextSpan textSpan;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  FDRichText({
    TextSpan? textSpan,
    TextSpan? text,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    super.key,
  }) : textSpan = textSpan ?? text ?? const TextSpan();

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'box-sizing': 'border-box',
      'display': 'block',
      if (textAlign != null) 'text-align': textAlign.toString().split('.').last,
      if (softWrap == false) 'white-space': 'nowrap',
    };

    if (overflow == TextOverflow.ellipsis && maxLines == null) {
      styles['white-space'] = 'nowrap';
      styles['overflow'] = 'hidden';
      styles['text-overflow'] = 'ellipsis';
    } else if (maxLines != null) {
      styles['display'] = '-webkit-box';
      styles['-webkit-line-clamp'] = maxLines.toString();
      styles['-webkit-box-orient'] = 'vertical';
      styles['overflow'] = 'hidden';
      if (overflow == TextOverflow.ellipsis || overflow == null) {
        styles['text-overflow'] = 'ellipsis';
      }
    } else if (overflow == TextOverflow.clip) {
      styles['overflow'] = 'hidden';
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: [_buildSpanNode(textSpan)],
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
