import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

bool _drawerBridgeInitialized = false;

void _ensureDrawerGlobalBridge() {
  if (_drawerBridgeInitialized) return;
  _drawerBridgeInitialized = true;
  try {
    globalContext.setProperty('toggleDrawer'.toJS, (() => toggleDrawer()).toJS);
    globalContext.setProperty('openDrawer'.toJS, (() => openDrawer()).toJS);
    globalContext.setProperty('closeDrawer'.toJS, (() => closeDrawer()).toJS);
  } catch (_) {}
}

/// Opens the drawer by setting its transform style and showing the backdrop.
void openDrawer() {
  final drawer = web.document.getElementById('flart-drawer') as web.HTMLElement?;
  if (drawer != null) {
    drawer.style.transform = 'translateX(0%)';
  }
  final backdrop = web.document.getElementById('flart-drawer-backdrop') as web.HTMLElement?;
  if (backdrop != null) {
    backdrop.style.opacity = '1';
    backdrop.style.pointerEvents = 'auto';
  }
}

/// Closes the drawer by resetting its transform style and hiding the backdrop.
void closeDrawer() {
  final drawer = web.document.getElementById('flart-drawer') as web.HTMLElement?;
  if (drawer != null) {
    drawer.style.transform = 'translateX(-100%)';
  }
  final backdrop = web.document.getElementById('flart-drawer-backdrop') as web.HTMLElement?;
  if (backdrop != null) {
    backdrop.style.opacity = '0';
    backdrop.style.pointerEvents = 'none';
  }
}

/// Toggles the drawer visibility between open and closed.
void toggleDrawer() {
  final drawer = web.document.getElementById('flart-drawer') as web.HTMLElement?;
  if (drawer != null) {
    if (drawer.style.transform == 'translateX(0%)') {
      closeDrawer();
    } else {
      openDrawer();
    }
  }
}

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

  static void openDrawer() => flart_openDrawer();
  static void closeDrawer() => flart_closeDrawer();
  static void toggleDrawer() => flart_toggleDrawer();

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

    if (drawer != null) {
      _ensureDrawerGlobalBridge();
    }

    if (appBar != null) {
      final effectiveAppBar = (appBar!.leading == null && drawer != null)
          ? FDAppBar(
              key: appBar!.key,
              title: appBar!.title,
              actions: appBar!.actions,
              backgroundColor: appBar!.backgroundColor,
              elevation: appBar!.elevation,
              rawCss: appBar!.rawCss,
              leading: FDGestureDetector(
                onTap: openDrawer,
                child: const FDIcon(icon: FDIcons.menu, color: FlartColors.white),
              ),
            )
          : appBar!;
      children.add(effectiveAppBar.buildNode(context));
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
      final backdropNode = FlartElementNode(
        'div',
        id: 'flart-drawer-backdrop',
        styles: {
          'position': 'fixed',
          'top': '0',
          'left': '0',
          'width': '100vw',
          'height': '100vh',
          'background': 'rgba(0,0,0,0.5)',
          'opacity': '0',
          'pointer-events': 'none',
          'transition': 'opacity 0.3s ease',
          'z-index': '998',
        },
        events: {
          'click': (e) => closeDrawer(),
        },
      );
      nodes.add(backdropNode);

      final drawerNode = FlartElementNode(
        'div',
        id: 'flart-drawer',
        styles: {
          'position': 'fixed',
          'top': '0',
          'left': '0',
          'height': '100%',
          'width': '250px',
          'background': 'white',
          'box-shadow': '2px 0 5px rgba(0,0,0,0.2)',
          'transform': 'translateX(-100%)',
          'transition': 'transform 0.3s ease',
          'z-index': '999',
        },
        children: [drawer!.buildNode(context)],
      );
      nodes.add(drawerNode);
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

void flart_openDrawer() => openDrawer();
void flart_closeDrawer() => closeDrawer();
void flart_toggleDrawer() => toggleDrawer();
