import '../../../flartdart.dart';

class FDRawHTML extends Widget {
  final String html;

  const FDRawHTML(this.html, {Key? key}) : super(key: key);

  @override
  String render(BuildContext context) {
    return html;
  }
}
