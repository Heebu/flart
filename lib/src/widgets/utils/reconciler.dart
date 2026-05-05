import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// [SmartReconciler] provides FlartDart with Selective Reconciliation capabilities.
/// Instead of a full re-render using innerHTML, it patches the existing DOM
/// to match the new desired state, preserving focus, scroll, and state.
class SmartReconciler {
  /// Reconciles the children of [container] with [newHtml].
  /// This is the primary entry point for framework updates.
  static void reconcile(web.Element container, String? newHtml) {
    final template = web.document.createElement(container.tagName);
    template.setHTMLUnsafe((newHtml ?? '').toJS);

    // Patch the children recursively
    _patchChildren(container, template);
  }

  /// Recursively morphs [oldNode] into [newNode].
  static void _morph(web.Node oldNode, web.Node newNode) {
    // If the node types differ, we must replace.
    if (oldNode.nodeType != newNode.nodeType) {
      oldNode.parentNode?.replaceChild(newNode.cloneNode(true), oldNode);
      return;
    }

    // Text Node Reconciliation
    if (oldNode.nodeType == web.Node.TEXT_NODE) {
      if (oldNode.textContent != newNode.textContent) {
        oldNode.textContent = newNode.textContent ?? '';
      }
      return;
    }

    // Element Reconciliation
    if (oldNode.nodeType == web.Node.ELEMENT_NODE) {
      final oldEl = oldNode as web.Element;
      final newEl = newNode as web.Element;

      // If tag names differ, replace.
      if (oldEl.nodeName != newEl.nodeName) {
        oldNode.parentNode?.replaceChild(newNode.cloneNode(true), oldNode);
        return;
      }

      if (oldEl.id.isNotEmpty &&
          newEl.id.isNotEmpty &&
          oldEl.id != newEl.id) {
        oldNode.parentNode?.replaceChild(newNode.cloneNode(true), oldNode);
        return;
      }

      // 1. Patch Attributes
      _patchAttributes(oldEl, newEl);

      // 2. Patch Children
      _patchChildren(oldEl, newEl);
    }
  }

  static void _patchAttributes(web.Element oldNode, web.Element newNode) {
    final oldAttrs = oldNode.attributes;
    final newAttrs = newNode.attributes;

    // Collect old attribute names
    final oldAttrNames = <String>[];
    for (var i = 0; i < oldAttrs.length; i++) {
      final attr = oldAttrs.item(i);
      if (attr != null) oldAttrNames.add(attr.name);
    }

    // Collect new attribute names and values
    final newAttrMap = <String, String>{};
    for (var i = 0; i < newAttrs.length; i++) {
      final attr = newAttrs.item(i);
      if (attr != null) newAttrMap[attr.name] = attr.value;
    }

    // Remove attributes no longer present
    for (var name in oldAttrNames) {
      if (!newAttrMap.containsKey(name)) {
        oldNode.removeAttribute(name);
      }
    }

    // Add or update attributes
    newAttrMap.forEach((name, value) {
      if (oldNode.getAttribute(name) != value) {
        oldNode.setAttribute(name, value);
      }
    });

    // Handle special input state that attributes don't track
    final tag = oldNode.nodeName.toUpperCase();
    if (tag == 'INPUT') {
      final oldInput = oldNode as web.HTMLInputElement;
      final newInput = newNode as web.HTMLInputElement;
      if (oldInput.value != newInput.value) oldInput.value = newInput.value;
      if (oldInput.checked != newInput.checked) oldInput.checked = newInput.checked;
    } else if (tag == 'TEXTAREA') {
      final oldTA = oldNode as web.HTMLTextAreaElement;
      final newTA = newNode as web.HTMLTextAreaElement;
      if (oldTA.value != newTA.value) oldTA.value = newTA.value;
    } else if (tag == 'SELECT') {
      final oldSel = oldNode as web.HTMLSelectElement;
      final newSel = newNode as web.HTMLSelectElement;
      if (oldSel.value != newSel.value) oldSel.value = newSel.value;
    }
  }

  static void _patchChildren(web.Element oldParent, web.Element newParent) {
    final oldNodes = _childNodesToList(oldParent);
    final newNodes = _childNodesToList(newParent);

    // Keyed optimization: Map existing IDs to nodes
    final Map<String, web.Node> oldKeys = {};
    for (var node in oldNodes) {
      if (node.nodeType == web.Node.ELEMENT_NODE) {
        final el = node as web.Element;
        if (el.id.isNotEmpty) {
          oldKeys[el.id] = node;
        }
      }
    }

    int oldIdx = 0;
    int newIdx = 0;

    while (newIdx < newNodes.length) {
      final newNode = newNodes[newIdx];

      final currentOldChildren = _childNodesToList(oldParent);
      if (oldIdx < currentOldChildren.length) {
        final oldNode = currentOldChildren[oldIdx];

        if (_isCompatible(oldNode, newNode)) {
          _morph(oldNode, newNode);
          oldIdx++;
          newIdx++;
        } else {
          // Attempt to find a moved node by key (ID)
          bool handled = false;
          if (newNode.nodeType == web.Node.ELEMENT_NODE) {
            final newEl = newNode as web.Element;
            if (newEl.id.isNotEmpty) {
              final movedNode = oldKeys[newEl.id];
              if (movedNode != null) {
                oldParent.insertBefore(movedNode, oldNode);
                _morph(movedNode, newNode);
                handled = true;
                newIdx++;
              }
            }
          }

          if (!handled) {
            // No match found, insert brand new node
            oldParent.insertBefore(newNode.cloneNode(true), oldNode);
            newIdx++;
          }
        }
      } else {
        // Just append the remaining nodes
        oldParent.appendChild(newNode.cloneNode(true));
        newIdx++;
      }
    }

    // Cleanup: Remove excess nodes from the end
    while (oldParent.childNodes.length > newNodes.length) {
      final last = oldParent.lastChild;
      if (last != null) {
        oldParent.removeChild(last);
      } else {
        break;
      }
    }
  }

  /// Helper to convert a NodeList into a Dart List for easy iteration.
  static List<web.Node> _childNodesToList(web.Element parent) {
    final list = <web.Node>[];
    final nodes = parent.childNodes;
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes.item(i);
      if (node != null) list.add(node);
    }
    return list;
  }

  static bool _isCompatible(web.Node a, web.Node b) {
    if (a.nodeType != b.nodeType) return false;
    if (a.nodeType == web.Node.ELEMENT_NODE) {
      final aEl = a as web.Element;
      final bEl = b as web.Element;
      if (aEl.nodeName != bEl.nodeName) return false;
      // If both have IDs, they MUST match
      if (aEl.id.isNotEmpty && bEl.id.isNotEmpty) {
        return aEl.id == bEl.id;
      }
      return true; // Fuzzy match for tag names
    }
    return true; // Text nodes compatible
  }
}
