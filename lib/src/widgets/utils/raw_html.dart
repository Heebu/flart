import '../../../flartdart.dart';

class FDRawHTML extends Widget {
  final String html;

  const FDRawHTML(this.html, {super.key});

  @override
  String render(BuildContext context) {
    return html;
  }
}
