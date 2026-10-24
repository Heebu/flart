import '../widget.dart';
import '../stateful_widget.dart';
import '../inherited_widget.dart';
import '../../styles/media_query.dart';
import '../../styles/theme.dart';

class SlotTracker {
  int _counter = 0;
  int next() => _counter++;
  void reset() => _counter = 0;
}

class BuildContext {
  final Widget widget;
  final BuildContext? parent;
  final Map<Type, Widget> inheritedWidgets;
  final Map<Type, dynamic> _states;
  final String path;
  final SlotTracker slotTracker;
  final State? currentBuildingState;

  BuildContext({
    required this.widget,
    this.parent,
    Map<Type, Widget>? inheritedWidgets,
    Map<Type, dynamic>? states,
    String? path,
    SlotTracker? slotTracker,
    this.currentBuildingState,
  })  : inheritedWidgets = inheritedWidgets ?? parent?.inheritedWidgets ?? {},
        _states = states ?? parent?._states ?? {},
        path = path ?? parent?.path ?? 'root',
        slotTracker = slotTracker ?? parent?.slotTracker ?? SlotTracker();

  int nextSlot() => slotTracker.next();

  T? dependOnInheritedWidgetOfExactType<T>() {
    final widget = inheritedWidgets[T];
    if (widget is T) {
      if (currentBuildingState != null && widget is InheritedWidget) {
        currentBuildingState!.recordDependency(T, widget);
        InheritedRegistry.registerDependency(T, currentBuildingState!);
      }
      return widget as T;
    }
    return null;
  }

  T? findAncestorStateOfType<T>() {
    final exact = _states[T];
    if (exact is T) return exact;
    for (final s in _states.values) {
      if (s is T) return s;
    }
    return parent?.findAncestorStateOfType<T>();
  }

  Map<Type, dynamic> get states => _states;

  BuildContext copyWith({
    Widget? widget,
    Map<Type, Widget>? inheritedWidgets,
    Map<Type, dynamic>? states,
    String? path,
    SlotTracker? slotTracker,
    State? currentBuildingState,
  }) {
    return BuildContext(
      widget: widget ?? this.widget,
      parent: this,
      inheritedWidgets: inheritedWidgets ?? this.inheritedWidgets,
      states: states ?? _states,
      path: path ?? this.path,
      slotTracker: slotTracker ?? this.slotTracker,
      currentBuildingState: currentBuildingState ?? this.currentBuildingState,
    );
  }

  // --- Extensions ---

  /// Access the current theme
  ThemeData get theme => Theme.of(this);

  /// Access media query info (screen size, etc)
  MediaQuery get mediaQuery => MediaQuery.of();

  /// Shortcuts for responsive design
  double get width => mediaQuery.width.toDouble();
  double get height => mediaQuery.height.toDouble();
  bool get isMobile => mediaQuery.isSmall;
  bool get isTablet => mediaQuery.isMedium;
  bool get isDesktop => mediaQuery.isLarge;
}
