import '../../../flartdart.dart';

class FDCenter extends Widget {
  final Widget child;

  final String? rawCss;

  FDCenter({required this.child, this.rawCss});

  @override
  String render(BuildContext context) {
    return '''
      <div style="
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        ${rawCss ?? ''}
      ">
        ${child.render(context)}
      </div>
    ''';
  }
}
