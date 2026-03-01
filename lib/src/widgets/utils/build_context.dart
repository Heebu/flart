import '../widget.dart';
import '../../styles/media_querry.dart';
import '../../styles/theme.dart';

class BuildContext {
  final Widget widget;
  final BuildContext? parent;
  final Map<Type, Widget> inheritedWidgets;
  final Map<Type, dynamic> _states;

  BuildContext({
    required this.widget,
    this.parent,
    Map<Type, Widget>? inheritedWidgets,
    Map<Type, dynamic>? states,
  })  : inheritedWidgets = inheritedWidgets ?? parent?.inheritedWidgets ?? {},
        _states = states ?? parent?._states ?? {};

  T? dependOnInheritedWidgetOfExactType<T>() {
    final widget = inheritedWidgets[T];
    return widget is T ? widget as T : null;
  }

  T? findAncestorStateOfType<T>() {
    return _states[T] as T?;
  }

  Map<Type, dynamic> get states => _states;

  BuildContext copyWith({
    Widget? widget,
    Map<Type, Widget>? inheritedWidgets,
    Map<Type, dynamic>? states,
  }) {
    return BuildContext(
      widget: widget ?? this.widget,
      parent: this,
      inheritedWidgets: inheritedWidgets ?? this.inheritedWidgets,
      states: states ?? this._states,
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
