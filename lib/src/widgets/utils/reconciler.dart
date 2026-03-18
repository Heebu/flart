import 'dart:html';

/// [SmartReconciler] provides FlartDart with Selective Reconciliation capabilities.
/// Instead of a full re-render using innerHTML, it patches the existing DOM
/// to match the new desired state, preserving focus, scroll, and state.
class SmartReconciler {
  /// Reconciles the children of [container] with [newHtml].
  /// This is the primary entry point for framework updates.
  static void reconcile(Element container, String? newHtml) {
    final template = document.createElement(container.tagName);
    template.setInnerHtml(newHtml ?? '', treeSanitizer: NodeTreeSanitizer.trusted);

    // 2. Patch the children recursively
    _patchChildren(container, template);
  }

  /// Recursively morphs [oldNode] into [newNode].
  static void _morph(Node oldNode, Node newNode) {
    // If the node types differ, we must replace.
    if (oldNode.nodeType != newNode.nodeType) {
      oldNode.replaceWith(newNode.clone(true));
      return;
    }

    // Text Node Reconciliation
    if (oldNode is Text && newNode is Text) {
      if (oldNode.text != newNode.text) {
        oldNode.text = newNode.text ?? '';
      }
      return;
    }

    // Element Reconciliation
    if (oldNode is Element && newNode is Element) {
      // If tag names differ, replace.
      if (oldNode.nodeName != newNode.nodeName) {
        oldNode.replaceWith(newNode.clone(true));
        return;
      }

      if (oldNode.id.isNotEmpty &&
          newNode.id.isNotEmpty &&
          oldNode.id != newNode.id) {
          oldNode.replaceWith(newNode.clone(true));
          return;
      }

      // 1. Patch Attributes
      _patchAttributes(oldNode, newNode);

      // 2. Patch Children
      _patchChildren(oldNode, newNode);
    }
  }

  static void _patchAttributes(Element oldNode, Element newNode) {
    final oldAttrs = oldNode.attributes;
    final newAttrs = newNode.attributes;

    // Remove attributes no longer present
    final keysToRemove = oldAttrs.keys.where((k) => !newAttrs.containsKey(k)).toList();
    for (var key in keysToRemove) {
      oldNode.attributes.remove(key);
    }

    // Add or update attributes
    newAttrs.forEach((key, value) {
      if (oldAttrs[key] != value) {
        oldNode.setAttribute(key, value);
      }
    });

    // Handle special input state that attributes don't track
    if (oldNode is InputElement && newNode is InputElement) {
      if (oldNode.value != newNode.value) oldNode.value = newNode.value ?? '';
      if (oldNode.checked != newNode.checked) oldNode.checked = newNode.checked ?? false;
    } else if (oldNode is TextAreaElement && newNode is TextAreaElement) {
      if (oldNode.value != newNode.value) oldNode.value = newNode.value ?? '';
    } else if (oldNode is SelectElement && newNode is SelectElement) {
      if (oldNode.value != newNode.value) oldNode.value = newNode.value ?? '';
    }
  }

  static void _patchChildren(Element oldParent, Element newParent) {
    final oldNodes = oldParent.childNodes.toList();
    final newNodes = newParent.childNodes.toList();

    // Keyed optimization: Map existing IDs to nodes
    final Map<String, Node> oldKeys = {};
    for (var node in oldNodes) {
      if (node is Element && node.id.isNotEmpty) {
        oldKeys[node.id] = node;
      }
    }

    int oldIdx = 0;
    int newIdx = 0;

    while (newIdx < newNodes.length) {
      final newNode = newNodes[newIdx];
      
      if (oldIdx < oldParent.childNodes.length) {
        final oldNode = oldParent.childNodes[oldIdx];

        if (_isCompatible(oldNode, newNode)) {
          _morph(oldNode, newNode);
          oldIdx++;
          newIdx++;
        } else {
          // Attempt to find a moved node by key (ID)
          bool handled = false;
          if (newNode is Element && newNode.id.isNotEmpty) {
            final movedNode = oldKeys[newNode.id];
            if (movedNode != null) {
              oldParent.insertBefore(movedNode, oldNode);
              _morph(movedNode, newNode);
              handled = true;
              // We don't increment oldIdx because we moved a node INTO this position
            }
          }

          if (!handled) {
            // No match found, insert brand new node
            oldParent.insertBefore(newNode.clone(true), oldNode);
            newIdx++;
          }
        }
      } else {
        // Just append the remaining nodes
        oldParent.append(newNode.clone(true));
        newIdx++;
      }
    }

    // Cleanup: Remove excess nodes from the end
    while (oldParent.childNodes.length > newNodes.length) {
      oldParent.childNodes.last.remove();
    }
  }

  static bool _isCompatible(Node a, Node b) {
    if (a.nodeType != b.nodeType) return false;
    if (a is Element && b is Element) {
      if (a.nodeName != b.nodeName) return false;
      // If both have IDs, they MUST match
      final aId = a.id;
      final bId = b.id;
      if (aId.isNotEmpty && bId.isNotEmpty) {
        return aId == bId;
      }
      return true; // Fuzzy match for tag names
    }
    return true; // Text nodes compatible
  }
}
