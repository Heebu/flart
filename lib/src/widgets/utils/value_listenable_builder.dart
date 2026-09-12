import '../../../flartdart.dart';

typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value, Widget? child);

/// A widget whose content calls [builder] whenever the given [ValueListenable] changes value.
class ValueListenableBuilder<T> extends StatefulWidget {
  final ValueListenable<T> valueListenable;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;

  const ValueListenableBuilder({
    required this.valueListenable,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  State<ValueListenableBuilder<T>> createState() => _ValueListenableBuilderState<T>();
}

class _ValueListenableBuilderState<T> extends State<ValueListenableBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(covariant ValueListenableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    setState(() {
      value = widget.valueListenable.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}

/// A widget that rebuilds when the given [Listenable] changes.
class ListenableBuilder extends StatefulWidget {
  final Listenable listenable;
  final TransitionBuilder builder;
  final Widget? child;

  const ListenableBuilder({
    required this.listenable,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  State<ListenableBuilder> createState() => _ListenableBuilderState();
}

class _ListenableBuilderState extends State<ListenableBuilder> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant ListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listenable != widget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.child);
  }
}
