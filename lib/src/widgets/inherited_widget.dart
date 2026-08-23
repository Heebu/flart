import '../../flartdart.dart';

abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({required this.child, super.key});

  @override
  FlartNode buildNode(BuildContext context) {
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
    // Legacy fallback
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
