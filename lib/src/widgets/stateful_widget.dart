import 'package:web/web.dart' as web;
import '../../flartdart.dart';

// Global state registry to persist state across renders
final Map<String, State> _stateRegistry = {};

/// Monotonic counter for generating stable positional state keys.
/// Unlike hashCode, this counter provides deterministic ordering
/// across re-renders when no explicit Key is provided.
int _renderCounter = 0;

/// Reset the render counter at the start of each full render pass.
/// Called by [reRenderApp] to ensure consistent positional keys.
void resetRenderCounter() {
  _renderCounter = 0;
}

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

    final element = web.document.getElementById(_stateKey!);
    if (element != null) {
      // Use VDOMReconciler instead of string-based innerHTML replacement.
      final newVNode = build(context).buildNode(context);
      // Wait, VDOMReconciler replaces children, but here we want to replace the inside of the wrapper.
      // So we can wrap it in a FlartRawHtmlNode if it was a string, but buildNode handles that.
      // The wrapper has id=$stateKey. We need to reconcile its children.
      VDOMReconciler.reconcile(element, newVNode);
    } else {
      // Fallback if element not found in DOM
      reRenderApp();
    }
  }

  /// Subclasses must produce a Widget representing their UI.
  Widget build(BuildContext context);
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  State<StatefulWidget> createState();

  @override
  FlartNode buildNode(BuildContext context) {
    final safeRuntimeType =
        runtimeType.toString().replaceAll(RegExp(r'[<>]'), '_');
    final stateKey = key != null
        ? '${safeRuntimeType}_${key.toString()}'
        : '${safeRuntimeType}_pos${_renderCounter++}';

    State state;
    if (_stateRegistry.containsKey(stateKey)) {
      state = _stateRegistry[stateKey]!;
      final oldWidget = state.widget;
      state.widget = this;
      state.context = context;
      state.didUpdateWidget(oldWidget);
    } else {
      state = createState();
      state.widget = this;
      state.context = context;
      state._stateKey = stateKey;
      _stateRegistry[stateKey] = state;
      state.initState();
      state.didChangeDependencies();
    }

    if (key is GlobalKey) {
      (key as GlobalKey).setInternalState(state);
    }

    final childContext = context.copyWith(
      states: {...context.states, state.runtimeType: state},
    );

    final childNode = state.build(childContext).buildNode(childContext);

    return FlartElementNode(
      'div',
      id: stateKey,
      styles: {'display': 'contents'},
      children: [childNode],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }

  /// Clean up state when widget is removed
  static void disposeState(String stateKey) {
    final state = _stateRegistry.remove(stateKey);
    state?.dispose();
  }
}

/// Reset all state in the registry. Useful for testing or hot reloads.
void resetStateRegistry() {
  _stateRegistry.forEach((_, state) => state.dispose());
  _stateRegistry.clear();
}

