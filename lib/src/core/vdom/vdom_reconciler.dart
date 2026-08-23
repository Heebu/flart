import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'flart_node.dart';

/// The VDOM Reconciler handles patching real DOM nodes with new VDOM state.
class VDOMReconciler {
  /// We store active event listeners on the real DOM elements using a weak map or expando,
  /// but in package:web we can just attach/detach directly if we track the references,
  /// or simply attach a generic delegated event listener per element.
  /// For simplicity, we will track attached listeners on the JS object via properties
  /// or we just wipe and re-add them if they change.
  
  static final _elementListeners = Expando<Map<String, JSFunction>>();

  /// Mounts or updates a VDOM node onto a real DOM container.
  static void reconcile(web.Element container, FlartNode vnode) {
    final existingChild = container.firstChild;

    if (existingChild == null) {
      // First mount
      final newNode = _createRealNode(vnode);
      container.appendChild(newNode);
    } else {
      // Patch existing
      _patchNode(container, existingChild, vnode);
    }
  }

  static void _patchNode(web.Node parent, web.Node oldDomNode, FlartNode newVNode) {
    if (newVNode is FlartTextNode) {
      if (oldDomNode.nodeType != web.Node.TEXT_NODE) {
        final newNode = web.document.createTextNode(newVNode.text);
        parent.replaceChild(newNode, oldDomNode);
      } else {
        if (oldDomNode.textContent != newVNode.text) {
          oldDomNode.textContent = newVNode.text;
        }
      }
    } else if (newVNode is FlartRawHtmlNode) {
      // Raw HTML nodes are a migration step. We create a span/div and set innerHTML.
      if (oldDomNode.nodeType == web.Node.ELEMENT_NODE) {
        final el = oldDomNode as web.Element;
        // If it was already a raw html container, just update if changed (though string diffing is hard here without caching)
        // We'll just replace it fully to be safe if it's Raw HTML
      }
      final template = web.document.createElement('div');
      template.setHTMLUnsafe(newVNode.html.toJS);
      if (template.childNodes.length == 1) {
        parent.replaceChild(template.firstChild!, oldDomNode);
      } else {
        // If multiple children, wrap them in a fragment or span
        parent.replaceChild(template, oldDomNode);
      }
    } else if (newVNode is FlartElementNode) {
      if (oldDomNode.nodeType != web.Node.ELEMENT_NODE) {
        final newNode = _createRealNode(newVNode);
        parent.replaceChild(newNode, oldDomNode);
      } else {
        final oldEl = oldDomNode as web.Element;
        if (oldEl.tagName.toLowerCase() != newVNode.tag.toLowerCase() || 
            (newVNode.id != null && oldEl.id != newVNode.id)) {
          // Hard replace
          final newNode = _createRealNode(newVNode);
          parent.replaceChild(newNode, oldDomNode);
        } else {
          // Soft patch
          _patchAttributes(oldEl, newVNode);
          _patchStyles(oldEl, newVNode);
          _patchEvents(oldEl, newVNode);
          _patchChildren(oldEl, newVNode.children);
        }
      }
    }
  }

  static web.Node _createRealNode(FlartNode vnode) {
    if (vnode is FlartTextNode) {
      return web.document.createTextNode(vnode.text);
    } else if (vnode is FlartRawHtmlNode) {
      final div = web.document.createElement('div');
      div.setHTMLUnsafe(vnode.html.toJS);
      return div.childNodes.length == 1 ? div.firstChild! : div;
    } else if (vnode is FlartElementNode) {
      final el = web.document.createElement(vnode.tag);
      if (vnode.id != null) el.id = vnode.id!;
      
      _patchAttributes(el, vnode);
      _patchStyles(el, vnode);
      _patchEvents(el, vnode);

      if (vnode.children != null) {
        for (final child in vnode.children!) {
          el.appendChild(_createRealNode(child));
        }
      }
      return el;
    }
    throw Exception('Unknown VDOM node type');
  }

  static void _patchAttributes(web.Element el, FlartElementNode vnode) {
    final newAttrs = vnode.attributes ?? {};
    
    // Remove old attributes that are no longer present
    final oldAttrNames = <String>[];
    for (var i = 0; i < el.attributes.length; i++) {
      final attr = el.attributes.item(i);
      if (attr != null && attr.name != 'style' && attr.name != 'id') {
        oldAttrNames.add(attr.name);
      }
    }
    
    for (final name in oldAttrNames) {
      if (!newAttrs.containsKey(name)) {
        el.removeAttribute(name);
      }
    }

    // Set new attributes
    for (final entry in newAttrs.entries) {
      if (el.getAttribute(entry.key) != entry.value) {
        el.setAttribute(entry.key, entry.value);
      }
    }

    // Input state handling (checked, value)
    if (el.tagName.toUpperCase() == 'INPUT') {
      final input = el as web.HTMLInputElement;
      if (newAttrs.containsKey('value') && input.value != newAttrs['value']) {
        input.value = newAttrs['value']!;
      }
      if (newAttrs.containsKey('checked')) {
        final checkedStr = newAttrs['checked'];
        final shouldBeChecked = checkedStr == 'true' || checkedStr == 'checked' || checkedStr == '';
        if (input.checked != shouldBeChecked) {
          input.checked = shouldBeChecked;
        }
      } else {
        // If not in attributes, maybe it should be false?
        // Wait, if it's a checkbox, and no checked attribute, it should be false.
        if (input.type == 'checkbox' || input.type == 'radio') {
            input.checked = false;
        }
      }
    }
  }

  static void _patchStyles(web.Element el, FlartElementNode vnode) {
    final newStyles = vnode.styles ?? {};
    final currentStyleStr = el.getAttribute('style') ?? '';
    
    // Quick equality check
    final newStyleStr = newStyles.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    if (currentStyleStr != newStyleStr) {
      if (newStyleStr.isEmpty) {
        el.removeAttribute('style');
      } else {
        el.setAttribute('style', newStyleStr);
      }
    }
  }

  static void _patchEvents(web.Element el, FlartElementNode vnode) {
    final newEvents = vnode.events ?? {};
    final currentListeners = _elementListeners[el] ?? {};

    // Remove obsolete listeners
    final toRemove = <String>[];
    currentListeners.forEach((type, jsFunc) {
      if (!newEvents.containsKey(type)) {
        el.removeEventListener(type, jsFunc);
        toRemove.add(type);
      }
    });
    for (var type in toRemove) currentListeners.remove(type);

    // Add or update listeners
    // To properly "update" a listener, we actually just remove the old one and add the new one,
    // because closures might capture new state.
    newEvents.forEach((type, handler) {
      if (currentListeners.containsKey(type)) {
        el.removeEventListener(type, currentListeners[type]);
      }
      
      // We must wrap the Dart handler to JS
      final jsFunc = (web.Event e) {
        handler(e);
      }.toJS;
      
      el.addEventListener(type, jsFunc);
      currentListeners[type] = jsFunc;
    });

    if (currentListeners.isEmpty) {
      _elementListeners[el] = null; // Clear expando entry
    } else {
      _elementListeners[el] = currentListeners;
    }
  }

  static void _patchChildren(web.Element parent, List<FlartNode>? newChildren) {
    newChildren ??= [];
    final domChildren = _childNodesToList(parent);
    
    int i = 0;
    while (i < newChildren.length) {
      if (i < domChildren.length) {
        _patchNode(parent, domChildren[i], newChildren[i]);
      } else {
        parent.appendChild(_createRealNode(newChildren[i]));
      }
      i++;
    }

    // Remove excess children
    while (i < domChildren.length) {
      parent.removeChild(domChildren[i]);
      i++;
    }
  }

  static List<web.Node> _childNodesToList(web.Element parent) {
    final list = <web.Node>[];
    final nodes = parent.childNodes;
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes.item(i);
      if (node != null) list.add(node);
    }
    return list;
  }
}
