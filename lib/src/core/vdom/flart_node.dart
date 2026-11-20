import 'package:web/web.dart' as web;

/// Base class for a Virtual DOM node in Flart.
abstract class FlartNode {
  /// Whether this node is a text node.
  bool get isText;

  /// Optional key for reconciler diffing.
  String? get key => null;
  
  /// Converts the node back to an HTML string (for legacy string-renderer fallback)
  String toHtml();
}

/// A Virtual DOM element node (e.g., <div>, <span>).
class FlartElementNode implements FlartNode {
  final String tag;
  final String? id;
  @override
  final String? key;
  final Map<String, String>? attributes;
  final Map<String, String>? styles;
  final List<FlartNode>? children;
  
  /// Event listeners mapped by event type (e.g., 'click', 'input')
  final Map<String, void Function(web.Event)>? events;

  FlartElementNode(
    this.tag, {
    this.id,
    this.key,
    this.attributes,
    this.styles,
    this.events,
    this.children,
  });

  @override
  bool get isText => false;

  @override
  String toHtml() {
    final buffer = StringBuffer();
    buffer.write('<$tag');
    if (id != null) {
      buffer.write(' id="$id"');
    }
    
    if (attributes != null) {
      for (final entry in attributes!.entries) {
        if (entry.key != 'id' && entry.key != 'style') {
          buffer.write(' ${entry.key}="${entry.value}"');
        }
      }
    }
    
    if (styles != null && styles!.isNotEmpty) {
      final styleStr = styles!.entries.map((e) => '${e.key}: ${e.value};').join(' ');
      buffer.write(' style="$styleStr"');
    }
    
    if (children == null || children!.isEmpty) {
      buffer.write('></$tag>');
    } else {
      buffer.write('>');
      for (final child in children!) {
        buffer.write(child.toHtml());
      }
      buffer.write('</$tag>');
    }
    
    return buffer.toString();
  }
}

/// A Virtual DOM text node.
class FlartTextNode implements FlartNode {
  final String text;

  FlartTextNode(this.text);

  @override
  bool get isText => true;

  @override
  String? get key => null;

  @override
  String toHtml() {
    return text.replaceAll('<', '&lt;').replaceAll('>', '&gt;');
  }
}

/// A Virtual DOM raw HTML block. 
/// Used for injecting raw HTML strings directly.
class FlartRawHtmlNode implements FlartNode {
  final String html;

  FlartRawHtmlNode(this.html);

  @override
  bool get isText => false;

  @override
  String? get key => null;

  @override
  String toHtml() => html;
}
