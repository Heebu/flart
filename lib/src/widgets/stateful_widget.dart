import 'dart:html';
import 'package:flart/flart.dart';
import 'utils/build_context.dart';

// Global state registry to persist state across renders
final Map<String, State> _stateRegistry = {};

/// Base class for State objects.
abstract class State<T extends StatefulWidget> {
  late T widget;
  late BuildContext context;
  String? _stateKey;

  /// Called once when the state object is created.
  void initState() {}

  /// Called whenever the framework wants to re-build the state.
  void didUpdateWidget(covariant T oldWidget) {}

  /// Called when the state object is removed permanently.
  void dispose() {}

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
      // 1. Capture scroll positions before update
      final scrollState = <String, Point<int>>{};
      // Need to cast to Element to access scrollTop/Left properly in Dart HTML
      final scrollableElements = element.querySelectorAll('*');
      for (final el in scrollableElements) {
        if (el.scrollTop > 0 || el.scrollLeft > 0) {
          scrollState[_getElementPath(el, element)] =
              Point(el.scrollLeft, el.scrollTop);
        }
      }

      // Re-render only this widget
      final newHtml = build(context).render(context);
      // We perform an innerHTML replacement on the wrapping container
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

      // Note: We might need to re-attach global listeners or ensure widgets attach their own.
      // In Flart, widgets usually attach "onclick" or start Futures in their render method.
      // Calling build().render() above triggers those logic paths.
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
  const StatefulWidget();

  State<StatefulWidget> createState();

  @override
  String render(BuildContext context) {
    // Generate a unique key for this widget instance
    // Note: Relying on hashCode means state is lost if new instance created.
    // Ideally user provides Key, but for now we stick to this.
    final stateKey = '${runtimeType}_${hashCode}';

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
    }

    final childHtml = state.build(context).render(context);

    // Wrap in a uniquely identified container to allow scoped updates.
    // display: contents allows the wrapper to be invisible to layout/CSS.
    return '<div id="$stateKey" style="display: contents;">$childHtml</div>';
  }

  /// Clean up state when widget is removed
  static void disposeState(String stateKey) {
    final state = _stateRegistry.remove(stateKey);
    state?.dispose();
  }
}
