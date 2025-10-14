import '../../../flart.dart';

class Expanded extends Widget {
  final Widget child;
  final int flex;

  Expanded({
    required this.child,
    this.flex = 1,
  });

  @override
  String render(BuildContext context) {
    return '''
      <div style="flex: $flex;">
        ${child.render(context)}
      </div>
    ''';
  }


}
