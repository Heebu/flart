import '../../flartdart.dart';

abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({required this.child, super.key});

  @override
  String render(BuildContext context) {
    // Register ourselves in the context for this type
    final newContext = context.copyWith(
      widget: this,
      inheritedWidgets: {
        ...context.inheritedWidgets,
        runtimeType: this,
      },
    );

    // In a real framework, we'd also track which widgets depend on us
    // to trigger targeted rebuilds when updating.
    return child.render(newContext);
  }

  bool updateShouldNotify(covariant InheritedWidget oldWidget);
}
