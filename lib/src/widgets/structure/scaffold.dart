import '../../../flart.dart';

class Scaffold extends Widget {
  final AppBar? appBar;
  final Widget? body;
  final Drawer? drawer;
  final BottomNavigationBar? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final Map<String, String>? cssStyle;

  Scaffold({
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.cssStyle,
  });

  @override
  String render() {
    final style = {
      'display': 'flex',
      'flex-direction': 'column',
      'height': '100vh',
      'position': 'relative',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final content = StringBuffer();
    if (appBar != null) content.writeln(appBar!.render());

    content.writeln('<div style="flex: 1; overflow: auto;">${body?.render() ?? ''}</div>');

    if (bottomNavigationBar != null) {
      content.writeln(bottomNavigationBar!.render());
    }

    // Build main scaffold layout
    final scaffoldHtml = '''
    <div style="$style">
      ${content.toString()}
    </div>
    ''';

    // Drawer layout
    final drawerHtml = drawer != null ? '''
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
        ${drawer!.render()}
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
    ''' : '';

    // Floating Action Button
    final fabHtml = floatingActionButton != null ? '''
      <div style="
        position: fixed;
        bottom: 16px;
        right: 16px;
        z-index: 1000;
      ">
        ${floatingActionButton!.render()}
      </div>
    ''' : '';

    return drawerHtml + scaffoldHtml + fabHtml;
  }
}
