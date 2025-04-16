import '../../../flart.dart';

class Center extends Widget {
  final Widget child;

  Center({required this.child});

  @override
  String render() {
    return '''
      <div style="
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
      ">
        ${child.render()}
      </div>
    ''';
  }
}
