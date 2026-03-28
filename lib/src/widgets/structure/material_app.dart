import 'package:web/web.dart' as web;

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
    PageNavigator.init();

    final effectiveTheme =
        theme ?? (darkMode ? ThemeData.dark() : ThemeData.light());
    final homeWidget = Theme(
      data: effectiveTheme,
      child: home ?? PageNavigator.current,
    );

    web.document.title = title;

    _injectMaterialIcons();
    if (fontFamily != null) {
      _injectGoogleFont(fontFamily!);
    }

    _injectFavicon();
    _injectViewportMeta();

    final prefersDark = effectiveTheme.isDark;
    final body = web.document.body;
    if (body != null) {
      body.classList.remove('flart-light');
      body.classList.remove('flart-dark');
      body.classList.add(prefersDark ? 'flart-dark' : 'flart-light');

      body.style.setProperty(
        '--primary-color',
        effectiveTheme.primaryColor.toString(),
      );
      body.style.setProperty(
        '--background-color',
        effectiveTheme.scaffoldBackgroundColor.toString(),
      );
      body.style.setProperty(
        '--text-color',
        effectiveTheme.textStyle.color.toString(),
      );
      body.style
          .setProperty('--card-color', effectiveTheme.cardColor.toString());

      body.style.backgroundColor =
          effectiveTheme.scaffoldBackgroundColor.toString();
      body.style.color = effectiveTheme.textStyle.color.toString();
    }

    if (rawCss != null) {
      final styleElement = web.HTMLStyleElement()
        ..textContent = '''
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
      web.document.head?.append(styleElement);
    }

    final mainHtml = homeWidget.render(context);
    final elapsed = stopwatch.elapsedMilliseconds;
    if (elapsed > 100) {
      print('Slow render warning: ${elapsed}ms');
    }

    if (!debugShowCheckedModeBanner) {
      return mainHtml;
    }

    return '''
      <div id="flart-root-wrapper" style="position: relative; width: 100vw; height: 100vh; overflow: hidden;">
        $mainHtml
        <div title="Flart Debug Mode (v1.5.1)" style="
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
    final existingIcon = web.document.head?.querySelector("link[rel*='icon']");
    existingIcon?.remove();

    final link = web.HTMLLinkElement()
      ..type = 'image/x-icon'
      ..rel = 'shortcut icon'
      ..href = favicon ?? 'assets/flart_logo.png';
    web.document.head?.append(link);
  }

  void _injectMaterialIcons() {
    if (web.document.head?.querySelector('link[href*="Material+Icons"]') !=
        null) {
      return;
    }
    final iconLink = web.HTMLLinkElement()
      ..rel = 'stylesheet'
      ..href = 'https://fonts.googleapis.com/icon?family=Material+Icons';
    web.document.head?.append(iconLink);
  }

  void _injectGoogleFont(String fontFamily) {
    if (web.document.head?.querySelector(
            'link[href*="fonts.googleapis.com/css2?family=${fontFamily.replaceAll(" ", "+")}"]') !=
        null) {
      return;
    }
    final fontLink = web.HTMLLinkElement()
      ..rel = 'stylesheet'
      ..href =
          'https://fonts.googleapis.com/css2?family=${fontFamily.replaceAll(" ", "+")}&display=swap';
    web.document.head?.append(fontLink);
  }

  void _injectViewportMeta() {
    if (web.document.head?.querySelector('meta[name="viewport"]') != null) {
      return;
    }
    final metaViewport = web.HTMLMetaElement()
      ..name = 'viewport'
      ..content = 'width=device-width, initial-scale=1.0';
    web.document.head?.append(metaViewport);
  }
}
