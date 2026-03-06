import 'utils/build_context.dart';
import 'widget.dart';

abstract class StatelessWidget extends Widget {
  const StatelessWidget({super.key});

  Widget build(BuildContext context);

  @override
  String render(BuildContext context) {
    return build(context).render(context);
  }
}
