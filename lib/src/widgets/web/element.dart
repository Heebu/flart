import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Flutter / Web compatibility typedef
typedef HtmlElement = FDElement;

/// A generic widget that renders directly to a VDOM [FlartElementNode].
/// Useful for creating custom or native HTML elements like `<canvas>`, `<section>`, etc.
class FDElement extends Widget {
  final String tag;
  final String? id;
  final Map<String, String>? attributes;
  final Map<String, String>? styles;
  final Map<String, void Function(web.Event)>? events;
  final List<Widget>? children;
  final String? textContent;

  const FDElement({
    required this.tag,
    this.id,
    this.attributes,
    this.styles,
    this.events,
    this.children,
    this.textContent,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    List<FlartNode>? nodes;
    if (textContent != null) {
      nodes = [FlartTextNode(textContent!)];
    } else if (children != null) {
      nodes = children!.map((child) => child.buildNode(context)).toList();
    }
    return FlartElementNode(
      tag,
      id: id,
      key: key?.toString(),
      attributes: attributes,
      styles: styles,
      events: events,
      children: nodes,
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
