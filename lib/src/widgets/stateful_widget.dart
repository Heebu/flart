import 'package:flart/flart.dart';
import 'utils/build_context.dart';

/// Base class for State objects.
abstract class State<T extends StatefulWidget> {
  late T widget;
  late BuildContext context;

  /// Called once when the state object is created.
  void initState() {}

  /// Called whenever the framework wants to re-build the state.
  void didUpdateWidget(covariant T oldWidget) {}

  /// Called when the state object is removed permanently.
  void dispose() {}

  /// Call inside event handlers to update state and trigger a rebuild.
  /// TODO: Replace the print with a real renderer hook that re-renders the widget in the DOM.
  void setState(void Function() fn) {
    fn();
    // Temporary: you should wire this to your renderer to actually update DOM.
    // For now we just log so you can see it fires.
    print(
        'setState called on ${widget.runtimeType} — please hook into renderer to re-render');
    reRenderApp();
  }

  /// Subclasses must produce a Widget representing their UI.
  Widget build(BuildContext context);
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget();

  State<StatefulWidget> createState();

  @override
  String render(BuildContext context) {
    final state = createState() as State;
    state.widget = this;
    state.context = context;
    state.initState();
    return state.build(context).render(context);
  }
}
