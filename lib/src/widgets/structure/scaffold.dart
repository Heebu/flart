import '../../../flartdart.dart';
import '../../helper/style_utils.dart';

class FDScaffold extends Widget {
  final FDAppBar? appBar;
  final Widget? body;
  final FDDrawer? drawer;
  final FDBottomNavigationBar? bottomNavigationBar;
  final FDFloatingActionButton? floatingActionButton;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDScaffold({
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final style = <String, String>{
      'width': '100vw',
      'height': '100vh',
      'overflow': 'hidden',
      'display': 'flex',
      'flex-direction': 'column',
      'position': 'relative',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          style[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final children = <FlartNode>[];

    if (appBar != null) {
      children.add(appBar!.buildNode(context));
    }

    children.add(FlartElementNode(
      'div',
      styles: {'flex': '1', 'overflow': 'auto'},
      children: body != null ? [body!.buildNode(context)] : [],
    ));

    if (bottomNavigationBar != null) {
      children.add(bottomNavigationBar!.buildNode(context));
    }

    final scaffoldNode = FlartElementNode(
      'div',
      styles: style,
      children: children,
    );

    final nodes = <FlartNode>[];

    if (drawer != null) {
      // For now, drawer uses raw html and a script.
      // A full VDOM implementation of drawer would use StatefulWidget.
      // But we wrap the legacy drawer here for simplicity while migrating.
      final drawerHtml = '''
      <div id="flart-drawer" style="
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        width: 250px;
        background: white;
        box-shadow: 2px 0 5px rgba(0,0,0,0.2);
        transform: translateX(-100%);
        transition: transform 0.3s ease;
        z-index: 999;
      ">
        ${drawer!.render(context)}
      </div>
      <script>
        function toggleDrawer() {
          const drawer = document.getElementById('flart-drawer');
          if (drawer.style.transform === 'translateX(0%)') {
            drawer.style.transform = 'translateX(-100%)';
          } else {
            drawer.style.transform = 'translateX(0%)';
          }
        }
      </script>
      ''';
      nodes.add(FlartRawHtmlNode(drawerHtml));
    }

    nodes.add(scaffoldNode);

    if (floatingActionButton != null) {
      nodes.add(FlartElementNode(
        'div',
        styles: {
          'position': 'fixed',
          'bottom': '16px',
          'right': '16px',
          'z-index': '1000',
        },
        children: [floatingActionButton!.buildNode(context)],
      ));
    }

    if (nodes.length == 1) return nodes.first;

    return FlartElementNode(
      'div',
      styles: {'display': 'contents'},
      children: nodes,
    );
  }
}
