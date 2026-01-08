import 'dart:html';
import '../../../flartdart.dart';

class FDMaterialApp extends Widget {
  final String title;
  final FlartColor? backgroundColor;
  final String? fontFamily;
  final Widget home;
  final bool darkMode;

  final String? favicon;
  final BuildContext? context; // Optional context parameter
  final String? rawCss;

  const FDMaterialApp({
    required this.title,
    required this.home,
    this.backgroundColor,
    this.fontFamily,
    this.darkMode = false,
    this.favicon,
    this.context,
    this.rawCss,
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

    // Apply global CSS if provided
    if (rawCss != null) {
      final styleElement = StyleElement()
        ..innerText = '''
        /* Global Reset */
        *, *::before, *::after {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
        }
        
        body {
          margin: 0;
          padding: 0;
          width: 100vw;
          height: 100vh;
          overflow: hidden;
          $rawCss
        }
      ''';
      document.head?.append(styleElement);
    }

    // Return the home widget's HTML
    return home.render(context);
  }

  void _injectFavicon() {
    // Remove existing
    final existingParams =
        document.head?.querySelectorAll("link[rel*='FDIcon']");
    existingParams?.forEach((el) => el.remove());

    final link = LinkElement()
      ..type = 'FDImage/x-FDIcon'
      ..rel = 'shortcut FDIcon'
      ..href = favicon ?? 'assets/flart_logo.png';
    document.head?.append(link);
  }

  void _injectMaterialIcons() {
    final iconLink = LinkElement()
      ..rel = 'stylesheet'
      ..href = 'https://fonts.googleapis.com/FDIcon?family=Material+FDIcons';
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
