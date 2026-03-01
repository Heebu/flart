import '../../../flartdart.dart';

abstract class ViewModel extends ChangeNotifier {
  void init() {}
  void onModelReady() {}
}

class FDViewModelBuilder<T extends ViewModel> extends StatefulWidget {
  final T Function() viewModelBuilder;
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Widget? staticChild;
  final bool disposeViewModel;
  final bool createNewModelOnInsert;
  final void Function(T model)? onModelReady;

  const FDViewModelBuilder({
    required this.viewModelBuilder,
    required this.builder,
    this.staticChild,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    this.onModelReady,
    Key? key,
  }) : super(key: key);

  @override
  State<FDViewModelBuilder<T>> createState() => _FDViewModelBuilderState<T>();
}

class _FDViewModelBuilderState<T extends ViewModel>
    extends State<FDViewModelBuilder<T>> {
  late T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.viewModelBuilder();
    _model.init();
    if (widget.onModelReady != null) {
      widget.onModelReady!(_model);
    }
    _model.onModelReady();
    _model.addListener(_rebuild);
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    _model.removeListener(_rebuild);
    if (widget.disposeViewModel) {
      _model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _model, widget.staticChild);
  }
}
