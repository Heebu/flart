import 'utils/build_context.dart';
import 'widget.dart';
import '../foundation/key.dart';

abstract class StatelessWidget extends Widget {
  const StatelessWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  @override
  String render(BuildContext context) {
    return build(context).render(context);
  }
}
