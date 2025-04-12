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
          margin: 0;
          padding: 0;
          background-color: ${backgroundColor?.toString() ?? 'white'};
          font-family: ${fontFamily ?? 'sans-serif'};
        }
      ''';
    document.head?.append(style);

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

    return ''; // We don't need to return anything from build
  }
}
