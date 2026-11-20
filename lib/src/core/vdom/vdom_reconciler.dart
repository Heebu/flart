import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'flart_node.dart';
import '../../widgets/stateful_widget.dart';

/// The VDOM Reconciler handles patching real DOM nodes with new VDOM state.
class VDOMReconciler {
  static final _elementListeners = Expando<Map<String, JSFunction>>();
  static final _nodeKeys = Expando<String>();

  /// Mounts or updates a VDOM node onto a real DOM container.
  static void reconcile(web.Element container, FlartNode vnode) {
    _patchChildren(container, [vnode]);
  }

  /// Disposes state and detaches event listeners when a DOM subtree is removed.
  static void _cleanUpDomNode(web.Node node) {
    if (node.nodeType == web.Node.ELEMENT_NODE) {
      final el = node as web.Element;
      _elementListeners[el] = null;
      _nodeKeys[el] = null;
      if (el.id.isNotEmpty) {
        StatefulWidget.disposeState(el.id);
      }
      final elementsWithId = el.querySelectorAll('[id]');
      for (var i = 0; i < elementsWithId.length; i++) {
        final childNode = elementsWithId.item(i);
        if (childNode is web.Element && childNode.id.isNotEmpty) {
          _elementListeners[childNode] = null;
          _nodeKeys[childNode] = null;
          StatefulWidget.disposeState(childNode.id);
        }
      }
    }
  }

  static String? _getDomKey(web.Node domNode) {
    if (domNode.nodeType != web.Node.ELEMENT_NODE) return null;
    final el = domNode as web.Element;
    final expKey = _nodeKeys[el];
    if (expKey != null && expKey.isNotEmpty) return expKey;
    final dataKey = el.getAttribute('data-key');
    if (dataKey != null && dataKey.isNotEmpty) return dataKey;
    if (el.id.isNotEmpty) return el.id;
    return null;
  }

  static String? _getVNodeKey(FlartNode vnode) {
    if (vnode is FlartElementNode) {
      if (vnode.key != null && vnode.key!.isNotEmpty) return vnode.key;
      if (vnode.id != null && vnode.id!.isNotEmpty) return vnode.id;
    }
    return null;
  }

  static web.Node _patchNode(web.Node parent, web.Node oldDomNode, FlartNode newVNode) {
    if (newVNode is FlartTextNode) {
      if (oldDomNode.nodeType != web.Node.TEXT_NODE) {
        _cleanUpDomNode(oldDomNode);
        final newNode = web.document.createTextNode(newVNode.text);
        parent.replaceChild(newNode, oldDomNode);
        return newNode;
      } else {
        if (oldDomNode.textContent != newVNode.text) {
          oldDomNode.textContent = newVNode.text;
        }
        return oldDomNode;
      }
    } else if (newVNode is FlartRawHtmlNode) {
      _cleanUpDomNode(oldDomNode);
      final template = web.document.createElement('div');
      template.setHTMLUnsafe(newVNode.html.toJS);
      final newNode = template.childNodes.length == 1 ? template.firstChild! : template;
      parent.replaceChild(newNode, oldDomNode);
      return newNode;
    } else if (newVNode is FlartElementNode) {
      if (oldDomNode.nodeType != web.Node.ELEMENT_NODE) {
        _cleanUpDomNode(oldDomNode);
        final newNode = _createRealNode(newVNode);
        parent.replaceChild(newNode, oldDomNode);
        return newNode;
      } else {
        final oldEl = oldDomNode as web.Element;
        final isDifferentTag =
            oldEl.tagName.toLowerCase() != newVNode.tag.toLowerCase();
        final oldKey = _getDomKey(oldEl);
        final newKey = _getVNodeKey(newVNode);
        final isDifferentKey =
            newKey != null && oldKey != null && newKey != oldKey;
        final isDifferentId =
            newVNode.id != null && oldEl.id.isNotEmpty && oldEl.id != newVNode.id;

        if (isDifferentTag || isDifferentKey || isDifferentId) {
          _cleanUpDomNode(oldDomNode);
          final newNode = _createRealNode(newVNode);
          parent.replaceChild(newNode, oldDomNode);
          return newNode;
        } else {
          if (newVNode.id != null && oldEl.id != newVNode.id) {
            oldEl.id = newVNode.id!;
          } else if (newVNode.id == null && oldEl.id.isNotEmpty) {
            oldEl.removeAttribute('id');
          }

          final k = newVNode.key ?? (newVNode.id?.isNotEmpty == true ? newVNode.id : null);
          if (k != null) {
            _nodeKeys[oldEl] = k;
            oldEl.setAttribute('data-key', k);
          } else {
            _nodeKeys[oldEl] = null;
            oldEl.removeAttribute('data-key');
          }

          _patchAttributes(oldEl, newVNode);
          _patchStyles(oldEl, newVNode);
          _patchEvents(oldEl, newVNode);
          _patchChildren(oldEl, newVNode.children);
          return oldEl;
        }
      }
    }
    throw Exception('Unknown VDOM node type');
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

      final k = vnode.key ?? (vnode.id?.isNotEmpty == true ? vnode.id : null);
      if (k != null) {
        _nodeKeys[el] = k;
        el.setAttribute('data-key', k);
      }
      
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
    
    final oldAttrNames = <String>[];
    for (var i = 0; i < el.attributes.length; i++) {
      final attr = el.attributes.item(i);
      if (attr != null && attr.name != 'style' && attr.name != 'id' && attr.name != 'data-key') {
        oldAttrNames.add(attr.name);
      }
    }
    
    for (final name in oldAttrNames) {
      if (!newAttrs.containsKey(name)) {
        el.removeAttribute(name);
      }
    }

    for (final entry in newAttrs.entries) {
      if (el.getAttribute(entry.key) != entry.value) {
        el.setAttribute(entry.key, entry.value);
      }
    }

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
        if (input.type == 'checkbox' || input.type == 'radio') {
          input.checked = false;
        }
      }
    }
  }

  static void _patchStyles(web.Element el, FlartElementNode vnode) {
    final newStyles = vnode.styles ?? {};
    final currentStyleStr = el.getAttribute('style') ?? '';
    
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

    final toRemove = <String>[];
    currentListeners.forEach((type, jsFunc) {
      if (!newEvents.containsKey(type)) {
        el.removeEventListener(type, jsFunc);
        toRemove.add(type);
      }
    });
    for (var type in toRemove) {
      currentListeners.remove(type);
    }

    newEvents.forEach((type, handler) {
      if (currentListeners.containsKey(type)) {
        el.removeEventListener(type, currentListeners[type]);
      }
      
      final jsFunc = (web.Event e) {
        handler(e);
      }.toJS;
      
      el.addEventListener(type, jsFunc);
      currentListeners[type] = jsFunc;
    });

    if (currentListeners.isEmpty) {
      _elementListeners[el] = null;
    } else {
      _elementListeners[el] = currentListeners;
    }
  }

  static void _patchChildren(web.Element parent, List<FlartNode>? newChildren) {
    newChildren ??= [];
    final domChildren = _childNodesToList(parent);

    bool hasKeys = false;
    for (final v in newChildren) {
      if (_getVNodeKey(v) != null) {
        hasKeys = true;
        break;
      }
    }
    if (!hasKeys) {
      for (final d in domChildren) {
        if (_getDomKey(d) != null) {
          hasKeys = true;
          break;
        }
      }
    }

    if (!hasKeys) {
      int i = 0;
      while (i < newChildren.length) {
        if (i < domChildren.length) {
          _patchNode(parent, domChildren[i], newChildren[i]);
        } else {
          parent.appendChild(_createRealNode(newChildren[i]));
        }
        i++;
      }

      while (i < domChildren.length) {
        _cleanUpDomNode(domChildren[i]);
        if (domChildren[i].parentNode == parent) {
          parent.removeChild(domChildren[i]);
        }
        i++;
      }
      return;
    }

    final oldKeyToNode = <String, web.Node>{};
    for (final node in domChildren) {
      final key = _getDomKey(node);
      if (key != null) {
        oldKeyToNode.putIfAbsent(key, () => node);
      }
    }

    final matchedOldNodes = <web.Node>{};
    final unkeyedOldNodes = <web.Node>[];
    for (final node in domChildren) {
      if (_getDomKey(node) == null) {
        unkeyedOldNodes.add(node);
      }
    }
    int unkeyedCursor = 0;

    for (var newIndex = 0; newIndex < newChildren.length; newIndex++) {
      final newVNode = newChildren[newIndex];
      final newKey = _getVNodeKey(newVNode);
      web.Node? matchedNode;

      if (newKey != null) {
        matchedNode = oldKeyToNode.remove(newKey);
      } else {
        while (unkeyedCursor < unkeyedOldNodes.length) {
          final candidate = unkeyedOldNodes[unkeyedCursor++];
          if (!matchedOldNodes.contains(candidate)) {
            matchedNode = candidate;
            break;
          }
        }
      }

      if (matchedNode != null) {
        matchedOldNodes.add(matchedNode);
        final activeNode = _patchNode(parent, matchedNode, newVNode);
        if (activeNode != matchedNode) {
          matchedOldNodes.remove(matchedNode);
          matchedOldNodes.add(activeNode);
        }

        final currentNodeAtIndex = parent.childNodes.item(newIndex);
        if (currentNodeAtIndex != activeNode) {
          parent.insertBefore(activeNode, currentNodeAtIndex);
        }
      } else {
        final newRealNode = _createRealNode(newVNode);
        final currentNodeAtIndex = parent.childNodes.item(newIndex);
        parent.insertBefore(newRealNode, currentNodeAtIndex);
      }
    }

    for (final oldNode in domChildren) {
      if (!matchedOldNodes.contains(oldNode)) {
        _cleanUpDomNode(oldNode);
        if (oldNode.parentNode == parent) {
          parent.removeChild(oldNode);
        }
      }
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
