import 'utils/build_context.dart';
import 'widget.dart';
import 'state.dart';


abstract class StatefulWidget extends Widget {
  const StatefulWidget();

  State createState();

  @override
  String render(BuildContext context) {
    final state = createState();
    state.widget = this as dynamic;
    state.context = context;
    state.initState();
    return state.build(context);
  }
}


