import 'dart:html';
import '../../flart.dart';

class MaterialApp extends StatelessWidget {
  final String title;
  final FlartColor? backgroundColor;
  final String? fontFamily;
  final Widget home;

  const MaterialApp({
    required this.title,
    required this.home,
    this.backgroundColor,
    this.fontFamily,
  });

  @override
  String build() {
    // Set the page title
    document.title = title;

    // Inject necessary links for Material Icons and Google Fonts
    _injectMaterialIcons();
    if (fontFamily != null) _injectGoogleFont(fontFamily!);

    // Inject viewport meta tag for responsive design
    _injectViewportMeta();

    // Clear any existing DOM content
    document.body?.children.clear();

    // Add the widget HTML into the body
    final container = DivElement()
      ..id = 'app'
      ..setInnerHtml(
        home.render(),
        treeSanitizer: NodeTreeSanitizer.trusted,
      );

    document.body?.append(container);

    return ''; // No need to return anything
  }

  void _injectMaterialIcons() {
    final iconLink = LinkElement()
      ..rel = 'stylesheet'
      ..href = 'https://fonts.googleapis.com/icon?family=Material+Icons';
    document.head?.append(iconLink);
  }

  void _injectGoogleFont(String fontFamily) {
    final fontLink = LinkElement()
      ..rel = 'stylesheet'
      ..href = 'https://fonts.googleapis.com/css2?family=${fontFamily.replaceAll(" ", "+")}&display=swap';
    document.head?.append(fontLink);
  }

  void _injectViewportMeta() {
    final metaViewport = MetaElement()
      ..name = 'viewport'
      ..content = 'width=device-width, initial-scale=1.0';
    document.head?.append(metaViewport);
  }
}
