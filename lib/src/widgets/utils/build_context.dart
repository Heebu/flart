import '../widget.dart';

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
}
