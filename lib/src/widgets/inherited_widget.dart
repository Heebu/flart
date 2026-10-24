import '../../flartdart.dart';

/// Registry tracking InheritedWidgets and their dependent States.
class InheritedRegistry {
  static final Map<Type, InheritedWidget> _lastInstances = {};
  static final Map<Type, Set<State>> _dependents = {};

  static void registerDependency(Type type, State state) {
    _dependents.putIfAbsent(type, () => <State>{}).add(state);
  }

  static void unregisterState(State state) {
    for (final set in _dependents.values) {
      set.remove(state);
    }
  }

  static InheritedWidget? getLastInstance(Type type) => _lastInstances[type];

  static void setLastInstance(Type type, InheritedWidget widget) {
    _lastInstances[type] = widget;
  }

  static void notifyDependents(Type type, [InheritedWidget? newWidget]) {
    final set = _dependents[type];
    if (set == null || set.isEmpty) return;

    final targetWidget = newWidget ?? _lastInstances[type];
    final toNotify = set.where((s) => s.mounted).toList();
    for (final state in toNotify) {
      if (targetWidget != null) {
        final old = state.dependencies[type];
        if (old != null && !targetWidget.updateShouldNotify(old)) {
          continue;
        }
        state.recordDependency(type, targetWidget);
      }
      state.didChangeDependencies();
      state.performScopedUpdate();
    }
  }

  static void reset() {
    _lastInstances.clear();
    _dependents.clear();
  }
}

abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({required this.child, super.key});

  @override
  FlartNode buildNode(BuildContext context) {
    InheritedRegistry.setLastInstance(runtimeType, this);

    final newContext = context.copyWith(
      widget: this,
      inheritedWidgets: {
        ...context.inheritedWidgets,
        runtimeType: this,
      },
    );

    return child.buildNode(newContext);
  }

  @override
  String render(BuildContext context) {
    InheritedRegistry.setLastInstance(runtimeType, this);

    final newContext = context.copyWith(
      widget: this,
      inheritedWidgets: {
        ...context.inheritedWidgets,
        runtimeType: this,
      },
    );

    return child.render(newContext);
  }

  bool updateShouldNotify(covariant InheritedWidget oldWidget);
}
