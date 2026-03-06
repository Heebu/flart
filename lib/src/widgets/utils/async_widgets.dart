import '../../../flartdart.dart';

/// The state of an asynchronous computation.
enum ConnectionState {
  /// Not currently connected to any asynchronous computation.
  none,

  /// Connected to an asynchronous computation and awaiting interaction.
  waiting,

  /// Connected to an active asynchronous computation.
  active,

  /// Connected to a terminated asynchronous computation.
  done,
}

/// Immutable representation of the most recent interaction with an asynchronous computation.
class AsyncSnapshot<T> {
  final ConnectionState connectionState;
  final T? data;
  final Object? error;

  const AsyncSnapshot._(this.connectionState, this.data, this.error);

  const AsyncSnapshot.nothing() : this._(ConnectionState.none, null, null);

  const AsyncSnapshot.waiting() : this._(ConnectionState.waiting, null, null);

  const AsyncSnapshot.withData(ConnectionState state, T data)
      : this._(state, data, null);

  const AsyncSnapshot.withError(ConnectionState state, Object error)
      : this._(state, null, error);

  bool get hasData => data != null;
  bool get hasError => error != null;

  T get requireData {
    if (hasData) return data!;
    if (hasError) throw error!;
    throw StateError('Snapshot has neither data nor error');
  }
}

/// A widget that builds itself based on the latest snapshot of interaction with a [Stream].
class FDStreamBuilder<T> extends StatefulWidget {
  final Stream<T>? stream;
  final T? initialData;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      builder;

  const FDStreamBuilder({
    this.stream,
    this.initialData,
    required this.builder,
    super.key,
  });

  @override
  State<FDStreamBuilder<T>> createState() => _FDStreamBuilderState<T>();
}

class _FDStreamBuilderState<T> extends State<FDStreamBuilder<T>> {
  late AsyncSnapshot<T> _snapshot;
  dynamic _subscription;

  @override
  void initState() {
    super.initState();
    _snapshot = widget.initialData != null
        ? AsyncSnapshot.withData(ConnectionState.none, widget.initialData as T)
        : const AsyncSnapshot.nothing();
    _subscribe();
  }

  @override
  void didUpdateWidget(FDStreamBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      _unsubscribe();
      _subscribe();
    }
  }

  void _subscribe() {
    if (widget.stream != null) {
      _subscription = widget.stream!.listen(
        (data) {
          setState(() {
            _snapshot = AsyncSnapshot.withData(ConnectionState.active, data);
          });
        },
        onError: (error) {
          setState(() {
            _snapshot = AsyncSnapshot.withError(ConnectionState.active, error);
          });
        },
        onDone: () {
          setState(() {
            _snapshot = AsyncSnapshot._(
              ConnectionState.done,
              _snapshot.data,
              _snapshot.error,
            );
          });
        },
      );
      _snapshot = AsyncSnapshot._(
        ConnectionState.waiting,
        _snapshot.data,
        _snapshot.error,
      );
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _snapshot);
  }
}

/// A widget that builds itself based on the latest snapshot of interaction with a [Future].
class FDFutureBuilder<T> extends StatefulWidget {
  final Future<T>? future;
  final T? initialData;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      builder;

  const FDFutureBuilder({
    this.future,
    this.initialData,
    required this.builder,
    super.key,
  });

  @override
  State<FDFutureBuilder<T>> createState() => _FDFutureBuilderState<T>();
}

class _FDFutureBuilderState<T> extends State<FDFutureBuilder<T>> {
  late AsyncSnapshot<T> _snapshot;
  Object? _activeCallbackIdentity;

  @override
  void initState() {
    super.initState();
    _snapshot = widget.initialData != null
        ? AsyncSnapshot.withData(ConnectionState.none, widget.initialData as T)
        : const AsyncSnapshot.nothing();
    _subscribe();
  }

  @override
  void didUpdateWidget(FDFutureBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.future != widget.future) {
      _subscribe();
    }
  }

  void _subscribe() {
    if (widget.future != null) {
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      widget.future!.then<void>((T data) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot.withData(ConnectionState.done, data);
          });
        }
      }, onError: (Object error) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot.withError(ConnectionState.done, error);
          });
        }
      });
      _snapshot = AsyncSnapshot.waiting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _snapshot);
  }
}

/// A generic widget builder that passes the current context.
class FDBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const FDBuilder({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
