import '../../../flartdart.dart';

/// Flutter / Web compatibility typedefs
typedef RawHtml = FDRawHTML;
typedef Html = FDRawHTML;

/// A widget that safely injects raw HTML into the Virtual DOM hierarchy.
class FDRawHTML extends Widget {
  final String html;

  const FDRawHTML(this.html, {super.key});

  @override
  FlartNode buildNode(BuildContext context) => FlartRawHtmlNode(html);

  @override
  String render(BuildContext context) {
    return html;
  }
}
