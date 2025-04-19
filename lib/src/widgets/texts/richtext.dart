// import '../../styles/text_style.dart';
// import '../widget.dart';
// import 'text_span.dart';
//
//
// class Text extends Widget {
//   final String? content;
//   final TextStyle? style;
//   final Map<String, String>? cssStyle;
//   final TextSpan? richSpan;
//
//   Text(
//       this.content, {
//         this.style,
//         this.cssStyle,
//       }) : richSpan = null;
//
//   Text.rich(
//       this.richSpan, {
//         this.style,
//         this.cssStyle,
//       }) : content = null;
//
//   @override
//   String render() {
//     if (richSpan != null) {
//       return _renderRichText(richSpan!);
//     }
//
//     final styleMap = {
//       ...(style?.toCss() ?? {}),
//       ...(cssStyle ?? {}),
//     };
//     final styleString = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
//     return '<span style="$styleString">$content</span>';
//   }
//
//   String _renderRichText(TextSpan span) {
//     final buffer = StringBuffer();
//     _buildSpan(buffer, span);
//     return buffer.toString();
//   }
//
//   void _buildSpan(StringBuffer buffer, TextSpan span) {
//     final styleMap = span.style?.toCss() ?? {};
//     final styleString = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
//
//     final openTag = span.onTap != null
//         ? '<span style="$styleString; cursor: pointer;" onclick="${span.onTap!()}">'
//         : '<span style="$styleString">';
//
//     buffer.write(openTag);
//     buffer.write(span.text);
//
//     if (span.children != null && span.children!.isNotEmpty) {
//       for (final child in span.children!) {
//         _buildSpan(buffer, child);
//       }
//     }
//
//     buffer.write('</span>');
//   }
// }
