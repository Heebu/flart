import '../foundation/key.dart';
import 'utils/build_context.dart';

abstract class Widget {
  final Key? key;
  const Widget({this.key});

  String render(BuildContext context);
}
