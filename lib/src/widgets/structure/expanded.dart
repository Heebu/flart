import '../../../flart.dart';

class Expanded extends Widget {
  final Widget child;
  final int flex;

  Expanded({
    required this.child,
    this.flex = 1,
  });

  @override
  String render() {
    return '''
      <div style="flex: $flex;">
        ${child.render()}
      </div>
    ''';
  }
}
