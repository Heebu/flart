import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// A generic widget that renders directly to a VDOM FlartElementNode.
/// Useful for creating native HTML elements like <input>, <video>, etc.
class FDElement extends Widget {
  final String tag;
  final String? id;
  final Map<String, String>? attributes;
  final Map<String, String>? styles;
  final Map<String, void Function(web.Event)>? events;
  final List<Widget>? children;

  const FDElement({
    required this.tag,
    this.id,
    this.attributes,
    this.styles,
    this.events,
    this.children,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return FlartElementNode(
      tag,
      id: id ?? key?.toString(),
      attributes: attributes,
      styles: styles,
      events: events,
      children: children?.map((child) => child.buildNode(context)).toList(),
    );
  }
}
