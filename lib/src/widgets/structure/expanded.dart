import '../../../flartdart.dart';

class FDExpanded extends Widget {
  final Widget child;
  final int flex;

  FDExpanded({
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



