import 'dart:html';
import '../../../flartdart.dart';

class FDMaterialApp extends Widget {
  final String title;
  final FlartColor? backgroundColor;
  final String? fontFamily;
  final Widget? home;
  final ThemeData? theme;
  final bool darkMode;

  final String? favicon;
  final BuildContext? context; // Optional context parameter
  final String? rawCss;

  final bool debugShowCheckedModeBanner;

  const FDMaterialApp({
    required this.title,
    this.home,
    this.theme,
    this.backgroundColor,
    this.fontFamily,
    this.darkMode = false,
    this.favicon,
    this.context,
    this.rawCss,
    this.debugShowCheckedModeBanner = true,
  });

  @override
  String render(BuildContext context) {
    final stopwatch = Stopwatch()..start();
    // Initialize navigation
    PageNavigator.init();

    final effectiveTheme =
        theme ?? (darkMode ? ThemeData.dark() : ThemeData.light());
    final homeWidget = Theme(
      data: effectiveTheme,
      child: home ?? PageNavigator.current,
    );
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

    final prefersDark = effectiveTheme.isDark;
    final body = document.body;
    if (body != null) {
      body.classes.remove('flart-light');
      body.classes.remove('flart-dark');
      body.classes.add(prefersDark ? 'flart-dark' : 'flart-light');

      // Force set CSS variables for safety
      body.style.setProperty(
          '--primary-color', effectiveTheme.primaryColor.toString());
      body.style.setProperty('--background-color',
          effectiveTheme.scaffoldBackgroundColor.toString());
      body.style.setProperty(
          '--text-color', effectiveTheme.textStyle.color.toString());
      body.style
          .setProperty('--card-color', effectiveTheme.cardColor.toString());

      body.style.backgroundColor =
          effectiveTheme.scaffoldBackgroundColor.toString();
      body.style.color = effectiveTheme.textStyle.color.toString();
    }

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
        }
        
        $rawCss
      ''';
      document.head?.append(styleElement);
    }

    // Return the home widget's HTML
    final mainHtml = homeWidget.render(context);
    final elapsed = stopwatch.elapsedMilliseconds;
    if (elapsed > 100) {
      print('⚠️ Slow Render Warning: ${elapsed}ms');
    }

    if (!debugShowCheckedModeBanner) return mainHtml;

    return '''
      <div id="flart-root-wrapper" style="position: relative; width: 100vw; height: 100vh; overflow: hidden;">
        $mainHtml
        <div title="Flart Debug Mode (v1.3.0)" style="
          position: fixed; 
          top: 0; 
          right: 0; 
          z-index: 10000;
          pointer-events: none;
          width: 80px; 
          height: 80px;
          overflow: hidden;
        ">
          <div style="
            background: #B71C1C; 
            color: white;
            text-align: center;
            font-size: 10px; 
            font-weight: bold;
            font-family: sans-serif;
            padding: 4px 0;
            width: 120px;
            position: absolute;
            top: 20px;
            right: -30px;
            transform: rotate(45deg);
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
          ">Debug</div>
        </div>
      </div>
    ''';
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
    if (document.head?.querySelector('link[href*="Material+Icons"]') != null)
      return;
    final iconLink = LinkElement()
      ..rel = 'stylesheet'
      ..href = 'https://fonts.googleapis.com/icon?family=Material+Icons';
    document.head?.append(iconLink);
  }

  void _injectGoogleFont(String fontFamily) {
    if (document.head?.querySelector(
            'link[href*="fonts.googleapis.com/css2?family=${fontFamily.replaceAll(" ", "+")}"]') !=
        null) return;
    final fontLink = LinkElement()
      ..rel = 'stylesheet'
      ..href =
          'https://fonts.googleapis.com/css2?family=${fontFamily.replaceAll(" ", "+")}&display=swap';
    document.head?.append(fontLink);
  }

  void _injectViewportMeta() {
    if (document.head?.querySelector('meta[name="viewport"]') != null) return;
    final metaViewport = MetaElement()
      ..name = 'viewport'
      ..content = 'width=device-width, initial-scale=1.0';
    document.head?.append(metaViewport);
  }
}
