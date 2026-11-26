import 'utils/build_context.dart';
import 'widget.dart';
import '../core/vdom/flart_node.dart';

abstract class StatelessWidget extends Widget {
  const StatelessWidget({super.key});

  Widget build(BuildContext context);

  @override
  FlartNode buildNode(BuildContext context) {
    return build(context).buildNode(context);
  }

  @override
  String render(BuildContext context) {
    return build(context).render(context);
  }
}
