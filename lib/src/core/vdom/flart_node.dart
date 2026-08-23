import 'package:web/web.dart' as web;
import 'dart:js_interop';

/// Base class for a Virtual DOM node in Flart.
abstract class FlartNode {
  /// Whether this node is a text node.
  bool get isText;
  
  /// Converts the node back to an HTML string (for legacy string-renderer fallback)
  String toHtml();
}

/// A Virtual DOM element node (e.g., <div>, <span>).
class FlartElementNode implements FlartNode {
  final String tag;
  final String? id;
  final Map<String, String>? attributes;
  final Map<String, String>? styles;
  final List<FlartNode>? children;
  
  /// Event listeners mapped by event type (e.g., 'click', 'input')
  final Map<String, Function(web.Event)>? events;

  FlartElementNode(
    this.tag, {
    this.id,
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
    
    // Note: Events cannot be serialized to HTML, so they are lost in the legacy bridge
    
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
  String toHtml() {
    // Simple HTML escaping could be done here, but text is usually safe enough in this context
    return text.replaceAll('<', '&lt;').replaceAll('>', '&gt;');
  }
}

/// A Virtual DOM raw HTML block. 
/// Used for migrating from string-based widgets progressively,
/// or when injecting raw HTML strings (like SVGs) directly.
class FlartRawHtmlNode implements FlartNode {
  final String html;

  FlartRawHtmlNode(this.html);

  @override
  bool get isText => false; // Handled specially by reconciler

  @override
  String toHtml() => html;
}
