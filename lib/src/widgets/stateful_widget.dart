import 'dart:html';
import '../../flartdart.dart';

// Global state registry to persist state across renders
final Map<String, State> _stateRegistry = {};

/// Base class for State objects.
abstract class State<T extends StatefulWidget> {
  late T widget;
  late BuildContext context;
  String? _stateKey;
  bool _mounted = true;

  bool get mounted => _mounted;

  /// Called once when the state object is created.
  void initState() {}

  /// Called whenever the framework wants to re-build the state.
  void didUpdateWidget(covariant T oldWidget) {}

  /// Called when a dependency of this State object changes.
  void didChangeDependencies() {}

  /// Called when the state object is removed permanently.
  void dispose() {
    _mounted = false;
  }

  /// Call inside event handlers to update state and trigger a rebuild.
  void setState(void Function() fn) {
    fn();
    _performScopedUpdate();
  }

  void _performScopedUpdate() {
    if (_stateKey == null) {
      reRenderApp();
      return;
    }

    final element = document.getElementById(_stateKey!);
    if (element != null) {
      // 1. Capture scroll positions and focus before update
      final activeElement = document.activeElement;
      String? focusedId;
      int? cursorStart;
      int? cursorEnd;
      if (activeElement != null && element.contains(activeElement)) {
        focusedId = activeElement.id;
        if (activeElement is InputElement) {
          cursorStart = activeElement.selectionStart;
          cursorEnd = activeElement.selectionEnd;
        } else if (activeElement is TextAreaElement) {
          cursorStart = activeElement.selectionStart;
          cursorEnd = activeElement.selectionEnd;
        }
      }

      final scrollState = <String, Point<int>>{};
      final scrollableElements = element.querySelectorAll('*');
      for (final el in scrollableElements) {
        if (el.scrollTop > 0 || el.scrollLeft > 0) {
          scrollState[_getElementPath(el, element)] =
              Point(el.scrollLeft, el.scrollTop);
        }
      }

      // Re-render only this widget
      final newHtml = build(context).render(context);
      // We perform an innerHTML replacement on the wrapping FDContainer
      // This preserves the wrapper itself with the ID
      element.setInnerHtml(newHtml, treeSanitizer: NodeTreeSanitizer.trusted);

      // 2. Restore scroll positions
      scrollState.forEach((path, point) {
        final el = _getElementByPath(element, path);
        if (el != null) {
          el.scrollLeft = point.x;
          el.scrollTop = point.y;
        }
      });

      // 3. Restore focus and cursor
      if (focusedId != null && focusedId.isNotEmpty) {
        final el = document.getElementById(focusedId);
        if (el != null) {
          el.focus();
          if (el is InputElement && cursorStart != null && cursorEnd != null) {
            el.setSelectionRange(cursorStart, cursorEnd);
          } else if (el is TextAreaElement &&
              cursorStart != null &&
              cursorEnd != null) {
            el.setSelectionRange(cursorStart, cursorEnd);
          }
        }
      }
    } else {
      // Fallback if element not found in DOM
      reRenderApp();
    }
  }

  String _getElementPath(Element target, Element root) {
    if (target == root) return '';
    final parent = target.parent;
    if (parent == null) return '';

    final index = parent.children.indexOf(target);
    final parentPath = _getElementPath(parent, root);
    return parentPath.isEmpty ? '$index' : '$parentPath/$index';
  }

  Element? _getElementByPath(Element root, String path) {
    if (path.isEmpty) return root;
    try {
      final indices = path.split('/').map(int.parse).toList();
      Element current = root;
      for (final index in indices) {
        if (index < 0 || index >= current.children.length) return null;
        current = current.children[index];
      }
      return current;
    } catch (e) {
      return null;
    }
  }

  /// Subclasses must produce a Widget representing their UI.
  Widget build(BuildContext context);
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget({Key? key}) : super(key: key);

  State<StatefulWidget> createState();

  @override
  String render(BuildContext context) {
    // Generate a unique key for this widget instance.
    // If a key is provided, we use it to maintain state across re-renders.
    final safeRuntimeType = runtimeType.toString().replaceAll(RegExp(r'[<>]'), '_');
    final stateKey = key != null
        ? '${safeRuntimeType}_${key.toString()}'
        : '${safeRuntimeType}_${hashCode}';

    // Get or create state
    State state;
    if (_stateRegistry.containsKey(stateKey)) {
      state = _stateRegistry[stateKey]!;
      // Update widget reference
      final oldWidget = state.widget;
      state.widget = this;
      state.context = context;
      state.didUpdateWidget(oldWidget);
    } else {
      state = createState() as State;
      state.widget = this;
      state.context = context;
      state._stateKey = stateKey;
      _stateRegistry[stateKey] = state;
      state.initState();
      state.didChangeDependencies();
    }

    // Link GlobalKey if present
    if (key is GlobalKey) {
      (key as GlobalKey).setInternalState(state);
    }

    // Pass this state down to children via a new context
    final childContext = context.copyWith(
      states: {...context.states, state.runtimeType: state},
    );

    final childHtml = state.build(childContext).render(childContext);

    // Wrap in a uniquely identified FDContainer to allow scoped updates.
    // display: contents allows the wrapper to be invisible to layout/CSS.
    return '<div id="$stateKey" style="display: contents;">$childHtml</div>';
  }

  /// Clean up state when widget is removed
  static void disposeState(String stateKey) {
    final state = _stateRegistry.remove(stateKey);
    state?.dispose();
  }
}
