import 'dart:html';
import '../../../flart.dart';

class MaterialApp extends Widget {
  final String title;
  final FlartColor? backgroundColor;
  final String? fontFamily;
  final Widget home;
  final bool darkMode;

  final String? favicon;
  final BuildContext? context; // Optional context parameter

  const MaterialApp({
    required this.title,
    required this.home,
    this.backgroundColor,
    this.fontFamily,
    this.darkMode = false,
    this.favicon,
    this.context,
  });

  @override
  String render(BuildContext context) {
    // Prefer passed context if available, otherwise use method argument
    // (In a real scenario, this distinction might matter regarding scope,
    // but here we just use what is available).

    // Set the page title
    document.title = title;

    // Inject necessary links
    _injectMaterialIcons();
    if (fontFamily != null) _injectGoogleFont(fontFamily!);

    // Inject Favicon
    _injectFavicon();

    // Inject viewport meta tag for responsive design
    _injectViewportMeta();

    // Clear any existing DOM content
    // document.body?.children.clear();

    final prefersDark =
        window.matchMedia('(prefers-color-scheme: dark)').matches;
    document.body?.classes.add(prefersDark ? 'flart-dark' : 'flart-light');

    // Return the home widget's HTML
    return home.render(context);
  }

  void _injectFavicon() {
    // Remove existing
    final existingParams = document.head?.querySelectorAll("link[rel*='icon']");
    existingParams?.forEach((el) => el.remove());

    final link = LinkElement()
      ..type = 'image/x-icon'
      ..rel = 'shortcut icon'
      ..href = favicon ?? 'assets/flart_logo.png';
    document.head?.append(link);
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
      ..href =
          'https://fonts.googleapis.com/css2?family=${fontFamily.replaceAll(" ", "+")}&display=swap';
    document.head?.append(fontLink);
  }

  void _injectViewportMeta() {
    final metaViewport = MetaElement()
      ..name = 'viewport'
      ..content = 'width=device-width, initial-scale=1.0';
    document.head?.append(metaViewport);
  }
}
