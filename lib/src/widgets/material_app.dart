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
    // Set page title
    document.title = title;

    // Inject viewport meta
    final metaViewport = MetaElement()
      ..name = 'viewport'
      ..content = 'width=device-width, initial-scale=1.0';
    document.head?.append(metaViewport);

    // Inject global styles
    final style = StyleElement()
      ..innerHtml = '''
    html, body {
      margin: 0 !important;
      padding: 0 !important;
      border: 0;
      height: 100%;
      width: 100%;
      font-size: 100%;
      background-color: ${backgroundColor?.toString() ?? 'white'};
      font-family: ${fontFamily ?? 'sans-serif'};
      box-sizing: border-box;
    }

    #app {
      margin: 0 !important;
      padding: 0 !important;
      width: 100%;
      height: 100%;
    }
    
    .fade-in {
    animation: fadeIn 300ms ease-in forwards;
  }

  .fade-out {
    animation: fadeOut 300ms ease-out forwards;
  }

  @keyframes fadeIn {
    0% { opacity: 0; transform: translateY(20px); }
    100% { opacity: 1; transform: translateY(0); }
  }

  @keyframes fadeOut {
    0% { opacity: 1; transform: translateY(0); }
    100% { opacity: 0; transform: translateY(-20px); }
  }

    *, *::before, *::after {
      box-sizing: inherit;
    }
  ''';


    // Optional: Load Google Font if passed
    if (fontFamily != null) {
      final fontLink = LinkElement()
        ..rel = 'stylesheet'
        ..href = 'https://fonts.googleapis.com/css2?family=${fontFamily!.replaceAll(" ", "+")}&display=swap';
      document.head?.append(fontLink);
    }

    // Clear existing DOM
    document.body?.children.clear();

    // Inject widget HTML into body
    final container = DivElement()
      ..id = 'app'
      ..setInnerHtml(
        home.render(),
        treeSanitizer: NodeTreeSanitizer.trusted,
      );

    document.body?.append(container);

    return '';
  }
}
