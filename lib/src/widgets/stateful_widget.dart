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
    // Trigger re-render
    reRenderApp();
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

    return state.build(context).render(context);
  }

  /// Clean up state when widget is removed
  static void disposeState(String stateKey) {
    final state = _stateRegistry.remove(stateKey);
    state?.dispose();
  }
}
