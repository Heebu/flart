import 'utils/build_context.dart';
import 'widget.dart';

abstract class StatelessWidget extends Widget {
  const StatelessWidget();

  Widget build(BuildContext context);

  @override
  Widget render(BuildContext context) {
    return build(context);
  }
}



