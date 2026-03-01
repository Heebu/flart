import '../widget.dart';
import '../../styles/media_querry.dart';
import '../../styles/theme.dart';

class BuildContext {
  final Widget widget;
  final BuildContext? parent;
  final Map<Type, Widget> inheritedWidgets;

  BuildContext({
    required this.widget,
    this.parent,
    Map<Type, Widget>? inheritedWidgets,
  }) : inheritedWidgets = inheritedWidgets ?? parent?.inheritedWidgets ?? {};

  T? dependOnInheritedWidgetOfExactType<T>() {
    final widget = inheritedWidgets[T];
    return widget is T ? widget as T : null;
  }

  BuildContext copyWith({Widget? widget, Map<Type, Widget>? inheritedWidgets}) {
    return BuildContext(
      widget: widget ?? this.widget,
      parent: this,
      inheritedWidgets: inheritedWidgets ?? this.inheritedWidgets,
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
