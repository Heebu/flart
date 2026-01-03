import '../../flart.dart';
import 'dart:html';

class PageNavigator {
  static final List<Widget> _stack = [];
  static final Map<String, Widget> _routes = {};

  static Widget get current =>
      _stack.isNotEmpty ? _stack.last : const _EmptyWidget();

  /// Register available routes before runApp()
  static void registerRoutes(Map<String, Widget> routes) {
    _routes.clear();
    _routes.addAll(routes);
  }

  /// Navigate within same tab (stack-based)
  static void push(Widget page) {
    _stack.add(page);
    _updateHistory(page);
    _refresh(withTransition: true);
  }

  static void pushNamed(String routeName, {Map<String, String>? queryParams}) {
    final page = _routes[routeName];
    if (page != null) {
      _stack.add(page);
      _updateHistory(page, routeName, queryParams);
      _refresh(withTransition: true);
    } else {
      _show404(routeName);
    }
  }

  /// Replace current page
  static void replace(Widget page) {
    if (_stack.isNotEmpty) _stack.removeLast();
    _stack.add(page);
    _updateHistory(page);
    _refresh(withTransition: false);
  }

  static void replaceNamed(String routeName,
      {Map<String, String>? queryParams}) {
    final page = _routes[routeName];
    if (page != null) {
      if (_stack.isNotEmpty) _stack.removeLast();
      _stack.add(page);
      _updateHistory(page, routeName, queryParams);
      _refresh(withTransition: false);
    } else {
      _show404(routeName);
    }
  }

  /// Pop to previous page
  static void pop() {
    if (_stack.length > 1) {
      _stack.removeLast();
      window.history.back();
      _refresh(withTransition: true);
    } else {
      print('Cannot pop: stack empty or single item');
    }
  }

  /// 🆕 Open route in new browser tab
  static void pushNewTab(String routeName, {Map<String, String>? queryParams}) {
    final uri = _buildRouteUrl(routeName, queryParams);
    window.open(uri, '_blank');
  }

  /// 🆕 Replace current tab with another route
  static void replaceNewTab(String routeName,
      {Map<String, String>? queryParams}) {
    final uri = _buildRouteUrl(routeName, queryParams);
    window.location.assign(uri);
  }

  /// Initialize the Navigator and load correct route
  static void init() {
    window.onPopState.listen((event) {
      if (_stack.length > 1) {
        _stack.removeLast();
        _refresh(withTransition: true);
      }
    });

    final hash = window.location.hash.replaceFirst('#', '');
    final routeName = hash.startsWith('/') ? hash : '/';
    if (_routes.containsKey(routeName)) {
      _stack.clear();
      _stack.add(_routes[routeName]!);
    }
  }

  // Helper to manually seed stack (hack for partial adoption)
  static void seed(Widget page) {
    if (_stack.isEmpty) {
      _stack.add(page);
    }
  }

  // Internal helpers

  static void _updateHistory(
    Widget page, [
    String? routeName,
    Map<String, String>? queryParams,
  ]) {
    final route = routeName ?? '/${page.runtimeType.toString().toLowerCase()}';
    final uri = _buildRouteUrl(route, queryParams);
    window.history.pushState(page.toString(), '', uri);
  }

  static String _buildRouteUrl(String routeName, Map<String, String>? params) {
    final query = params != null && params.isNotEmpty
        ? '?' + params.entries.map((e) => '${e.key}=${e.value}').join('&')
        : '';
    return '#$routeName$query';
  }

  static void _show404(String routeName) {
    final html = '<div>404: Route "$routeName" not found</div>';
    querySelector('#output')?.setInnerHtml(
      html,
      treeSanitizer: NodeTreeSanitizer.trusted,
    );
  }

  static void _refresh({bool withTransition = false}) {
    // Current run_app render logic handles context.
    // We need a context to render. Navigator acts as root?
    // We'll create a dummy context since we are at root level.
    // Or we should pass context?
    // For now, let's create a fresh context for the root page.
    final context = BuildContext(widget: current);
    final html = current.render(context);

    final app = querySelector('#output') ?? querySelector('#app');
    if (app != null) {
      if (withTransition) {
        app.classes.add('fade-out');
        Future.delayed(const Duration(milliseconds: 300), () {
          app.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
          app.classes
            ..remove('fade-out')
            ..add('fade-in');
          Future.delayed(const Duration(milliseconds: 300), () {
            app.classes.remove('fade-in');
          });
        });
      } else {
        app.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
      }
    }
  }
}

class _EmptyWidget extends Widget {
  const _EmptyWidget();

  @override
  String render(BuildContext context) => '<div>No route defined</div>';
}
