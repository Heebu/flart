import '../widgets/widget.dart';
import '../widgets/utils/build_context.dart';
import '../../run_app.dart';
import 'dart:html';

typedef RouteGuard = bool Function(String routeName);
typedef PageBuilder = Widget Function(Map<String, String> params);

class PageNavigator {
  static final List<Widget> _stack = [];
  static final Map<String, PageBuilder> _routes = {};
  static RouteGuard? _guard;
  static String? _unauthorizedRoute;
  static bool _isInitialized = false;

  static Widget get current =>
      _stack.isNotEmpty ? _stack.last : const _EmptyWidget();

  /// Register available routes with optional guards
  static void registerRoutes(Map<String, Widget> routes,
      {RouteGuard? guard, String? unauthorizedRoute}) {
    _routes.clear();
    routes.forEach((key, value) {
      _routes[key] = (_) => value;
    });
    _guard = guard;
    _unauthorizedRoute = unauthorizedRoute;
  }

  /// Register dynamic routes
  static void registerDynamicRoutes(Map<String, PageBuilder> routes) {
    _routes.addAll(routes);
  }

  /// Navigate within same tab (FDStack-based)
  static void push(Widget page) {
    _stack.add(page);
    _updateHistory(page);
    _refresh(withTransition: true);
  }

  static void pushNamed(String routeName, {Map<String, String>? queryParams}) {
    if (_guard != null && !_guard!(routeName)) {
      if (_unauthorizedRoute != null) {
        pushNamed(_unauthorizedRoute!);
      }
      return;
    }

    final builder = _routes[routeName];
    if (builder != null) {
      final page = builder(queryParams ?? {});
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
    if (_guard != null && !_guard!(routeName)) {
      if (_unauthorizedRoute != null) {
        replaceNamed(_unauthorizedRoute!);
      }
      return;
    }

    final builder = _routes[routeName];
    if (builder != null) {
      final page = builder(queryParams ?? {});
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
      print('Cannot pop: FDStack empty or single item');
    }
  }

  /// ðŸ†• Open route in new browser tab
  static void pushNewTab(String routeName, {Map<String, String>? queryParams}) {
    final uri = _buildRouteUrl(routeName, queryParams);
    window.open(uri, '_blank');
  }

  /// ðŸ†• Replace current tab with another route
  static void replaceNewTab(String routeName,
      {Map<String, String>? queryParams}) {
    final uri = _buildRouteUrl(routeName, queryParams);
    window.location.assign(uri);
  }

  /// Initialize the Navigator and load correct route
  static void init() {
    if (_isInitialized) return;
    _isInitialized = true;
    window.onPopState.listen((event) {
      if (_stack.length > 1) {
        _stack.removeLast();
        _refresh(withTransition: true);
      }
    });

    final hash = window.location.hash.replaceFirst('#', '');
    final uri = Uri.parse(
        hash.startsWith('/') ? hash : (hash.isEmpty ? '/' : '/$hash'));
    final routeName = uri.path;
    final params = uri.queryParameters;

    if (_routes.containsKey(routeName)) {
      _stack.clear();
      _stack.add(_routes[routeName]!(params));
    } else if (routeName == '/' && _routes.isNotEmpty) {
      // Fallback for root if exactly '/' is not found but we have routes
      final firstRoute = _routes.entries.first;
      _stack.clear();
      _stack.add(firstRoute.value({}));
    }
  }

  // Helper to manually seed FDStack (hack for partial adoption)
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
    reRenderApp();
  }
}

class _EmptyWidget extends Widget {
  const _EmptyWidget();

  @override
  String render(BuildContext context) => '<div>No route defined</div>';
}
