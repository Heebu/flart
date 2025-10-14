import '../widget.dart';

class BuildContext {
  final Widget widget;
  final BuildContext? parent;

  BuildContext({required this.widget, this.parent});
}
