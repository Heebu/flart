import '../../../flartdart.dart';

/// Flutter compatibility typedefs
typedef Provider<T> = FDProvider<T>;
typedef ChangeNotifierProvider<T extends ChangeNotifier>
    = FDChangeNotifierProvider<T>;
typedef Consumer<T extends ChangeNotifier> = FDConsumer<T>;

/// A simplified dependency injection and state provider based on [InheritedWidget].
class FDProvider<T> extends InheritedWidget {
  final T value;

  const FDProvider({
    required this.value,
    required super.child,
    super.key,
  });

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

/// A provider that creates, manages, and disposes a [ChangeNotifier].
class FDChangeNotifierProvider<T extends ChangeNotifier>
    extends StatefulWidget {
  final T Function(BuildContext context) create;
  final Widget child;

  const FDChangeNotifierProvider({
    required this.create,
    required this.child,
    super.key,
  });

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

/// A widget that rebuilds when the ancestor [ChangeNotifier] of type [T] emits a change.
class FDConsumer<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;

  const FDConsumer({
    required this.builder,
    this.child,
    super.key,
  });

  @override
  State<FDConsumer<T>> createState() => _FDConsumerState<T>();
}

class _FDConsumerState<T extends ChangeNotifier> extends State<FDConsumer<T>> {
  T? _notifier;

  void _listener() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newNotifier = FDProvider.of<T>(context);
    if (newNotifier != _notifier) {
      _notifier?.removeListener(_listener);
      _notifier = newNotifier;
      _notifier!.addListener(_listener);
    }
  }

  @override
  void dispose() {
    _notifier?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = _notifier ?? FDProvider.of<T>(context);
    return widget.builder(context, notifier, widget.child);
  }
}
