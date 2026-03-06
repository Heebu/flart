import '../../../flartdart.dart';

class FDExpanded extends Widget {
  final Widget child;
  final int flex;
  final String? rawCss;

  const FDExpanded({
    required this.child,
    this.flex = 1,
    this.rawCss,
    super.key,
  });

  @override
  String render(BuildContext context) {
    return '''
      <div style="flex: $flex; ${rawCss ?? ''}">
        ${child.render(context)}
      </div>
    ''';
  }
}
