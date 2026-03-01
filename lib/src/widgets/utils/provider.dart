import '../../../flartdart.dart';

/// A simplified state management provider.
class FDProvider<T> extends InheritedWidget {
  final T value;

  const FDProvider({
    required this.value,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  static T of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<FDProvider<T>>();
    if (provider == null) {
      throw Exception('No FDProvider<$T> found in context');
    }
    return provider.value;
  }

  @override
  bool updateShouldNotify(FDProvider<T> oldWidget) => value != oldWidget.value;
}
