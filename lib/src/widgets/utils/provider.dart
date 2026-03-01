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

/// A provider that manages a [ChangeNotifier].
class FDChangeNotifierProvider<T extends ChangeNotifier>
    extends StatefulWidget {
  final T Function(BuildContext context) create;
  final Widget child;

  const FDChangeNotifierProvider({
    required this.create,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<FDChangeNotifierProvider<T>> createState() =>
      _FDChangeNotifierProviderState<T>();
}

class _FDChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<FDChangeNotifierProvider<T>> {
  late T _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = widget.create(context);
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FDProvider<T>(
      value: _notifier,
      child: widget.child,
    );
  }
}

/// A widget that rebuilds when a [ChangeNotifier] changes.
class FDConsumer<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;

  const FDConsumer({
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<FDConsumer<T>> createState() => _FDConsumerState<T>();
}

class _FDConsumerState<T extends ChangeNotifier> extends State<FDConsumer<T>> {
  late T _notifier;

  void _listener() {
    setState(() {});
  }

  @override
  void didUpdateWidget(FDConsumer<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newNotifier = FDProvider.of<T>(context);
    if (newNotifier != _notifier) {
      _notifier.removeListener(_listener);
      _notifier = newNotifier;
      _notifier.addListener(_listener);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newNotifier = FDProvider.of<T>(context);
    // Explicitly check if notifier is already late initialized
    // (Note: in Dart 'late' check is hard without try-catch or flag)
    // We'll just assign it.
    _notifier = newNotifier;
    _notifier.removeListener(_listener);
    _notifier.addListener(_listener);
  }

  @override
  void dispose() {
    _notifier.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier, widget.child);
  }
}
