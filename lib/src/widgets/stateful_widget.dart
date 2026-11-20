import 'package:web/web.dart' as web;
import '../../flartdart.dart';

// Global state registry to persist state across renders
final Map<String, State> _stateRegistry = {};

/// Reset the render counter at the start of each full render pass.
/// Kept for backwards compatibility.
void resetRenderCounter() {}

/// Base class for State objects.
abstract class State<T extends StatefulWidget> {
  late T widget;
  late BuildContext context;
  String? _stateKey;
  bool _mounted = true;
  final Map<Type, InheritedWidget> _dependencies = {};

  bool get mounted => _mounted;

  /// Called once when the state object is created.
  void initState() {}

  /// Called whenever the framework wants to re-build the state.
  void didUpdateWidget(covariant T oldWidget) {}

  /// Called when a dependency of this State object changes.
  void didChangeDependencies() {}

  Map<Type, InheritedWidget> get dependencies => _dependencies;

  /// Records an inherited widget dependency.
  void recordDependency(Type type, InheritedWidget widget) {
    _dependencies[type] = widget;
    context = context.copyWith(
      inheritedWidgets: {
        ...context.inheritedWidgets,
        type: widget,
      },
    );
  }

  /// Checks if any inherited dependency changed and notifies if so.
  void checkAndNotifyDependencies(BuildContext newContext) {
    bool changed = false;
    for (final entry in _dependencies.entries) {
      final current = newContext.inheritedWidgets[entry.key];
      if (current is InheritedWidget && current != entry.value) {
        final shouldNotify = current.updateShouldNotify(entry.value);
        _dependencies[entry.key] = current;
        if (shouldNotify) {
          changed = true;
        }
      }
    }
    if (changed) {
      didChangeDependencies();
    }
  }

  /// Called when the state object is removed permanently.
  void dispose() {
    _mounted = false;
    InheritedRegistry.unregisterState(this);
  }

  /// Call inside event handlers to update state and trigger a rebuild.
  void setState(void Function() fn) {
    fn();
    _performScopedUpdate();
  }

  /// Triggers a scoped update from outside the widget.
  void performScopedUpdate() {
    _performScopedUpdate();
  }

  void _performScopedUpdate() {
    if (_stateKey == null) {
      reRenderApp();
      return;
    }

    final element = web.document.getElementById(_stateKey!);
    if (element != null) {
      final updateContext = context.copyWith(
        path: _stateKey,
        slotTracker: SlotTracker(),
        currentBuildingState: this,
        states: {...context.states, runtimeType: this},
      );
      final newVNode = build(updateContext).buildNode(updateContext);
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

    final String stateKey;
    if (key is GlobalKey) {
      stateKey = 'gk_${key.toString()}';
    } else if (key != null) {
      final cleanKey =
          key.toString().replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
      stateKey = '${context.path}__k_$cleanKey';
    } else {
      final slot = context.nextSlot();
      stateKey = '${context.path}__${safeRuntimeType}_$slot';
    }

    State state;
    if (_stateRegistry.containsKey(stateKey)) {
      state = _stateRegistry[stateKey]!;
      final oldWidget = state.widget;
      state.widget = this;
      final selfContext = context.copyWith(
        path: stateKey,
        slotTracker: SlotTracker(),
        currentBuildingState: state,
        states: {...context.states, state.runtimeType: state},
      );
      state.context = selfContext;
      state.didUpdateWidget(oldWidget);
      state.checkAndNotifyDependencies(selfContext);
    } else {
      state = createState();
      state.widget = this;
      final selfContext = context.copyWith(
        path: stateKey,
        slotTracker: SlotTracker(),
        currentBuildingState: state,
        states: {...context.states, state.runtimeType: state},
      );
      state.context = selfContext;
      state._stateKey = stateKey;
      _stateRegistry[stateKey] = state;
      state.initState();
      state.didChangeDependencies();
    }

    if (key is GlobalKey) {
      (key as GlobalKey).setInternalState(state);
    }

    final childContext = state.context;
    final childNode = state.build(childContext).buildNode(childContext);

    return FlartElementNode(
      'div',
      id: stateKey,
      key: key?.toString() ?? stateKey,
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
  InheritedRegistry.reset();
}
