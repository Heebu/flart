import 'dart:js_interop';

import 'package:web/web.dart' as web;

import '../../run_app.dart';
import '../helper/route_utils.dart';
import '../widgets/utils/build_context.dart';
import '../widgets/widget.dart';

typedef RouteGuard = bool Function(String routeName);
typedef PageBuilder = Widget Function(Map<String, String> params);

class PageNavigator {
  static final List<Widget> _stack = <Widget>[];
  static final Map<String, PageBuilder> _routes = <String, PageBuilder>{};
  static RouteGuard? _guard;
  static String? _unauthorizedRoute;
  static bool _isInitialized = false;

  static Widget get current =>
      _stack.isNotEmpty ? _stack.last : const _EmptyWidget();

  static void registerRoutes(
    Map<String, Widget> routes, {
    RouteGuard? guard,
    String? unauthorizedRoute,
  }) {
    _routes
      ..clear()
      ..addAll(routes.map((key, value) => MapEntry(key, (_) => value)));

    _guard = guard;
    _unauthorizedRoute = unauthorizedRoute;
  }

  static void registerDynamicRoutes(Map<String, PageBuilder> routes) {
    _routes.addAll(routes);
  }

  static void push(Widget page) {
    _stack.add(page);
    _updateHistory(page: page);
    _refresh(withTransition: true);
  }

  static void pushNamed(String routeName, {Map<String, String>? queryParams}) {
    if (_guard != null && !_guard!(routeName)) {
      if (_unauthorizedRoute != null) {
        pushNamed(_unauthorizedRoute!);
      }
      return;
    }

    _navigateToPath(routeName, queryParams ?? <String, String>{},
        replace: false);
  }

  static void replace(Widget page) {
    if (_stack.isNotEmpty) {
      _stack.removeLast();
    }

    _stack.add(page);
    _updateHistory(page: page, replaceHistory: true);
    _refresh(withTransition: false);
  }

  static void replaceNamed(
    String routeName, {
    Map<String, String>? queryParams,
  }) {
    if (_guard != null && !_guard!(routeName)) {
      if (_unauthorizedRoute != null) {
        replaceNamed(_unauthorizedRoute!);
      }
      return;
    }

    _navigateToPath(routeName, queryParams ?? <String, String>{},
        replace: true);
  }

  static void pop() {
    if (_stack.length > 1) {
      _stack.removeLast();
      web.window.history.back();
      _refresh(withTransition: true);
      return;
    }

    print('Cannot pop: FDStack empty or single item');
  }

  static void pushNewTab(String routeName, {Map<String, String>? queryParams}) {
    final uri = buildHashRouteUrl(routeName, queryParams);
    web.window.open(uri, '_blank');
  }

  static void replaceNewTab(
    String routeName, {
    Map<String, String>? queryParams,
  }) {
    final uri = buildHashRouteUrl(routeName, queryParams);
    web.window.location.assign(uri);
  }

  static void init() {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    web.window.addEventListener(
      'popstate',
      ((web.Event _) {
        if (_stack.length > 1) {
          _stack.removeLast();
          _refresh(withTransition: true);
        }
      }).toJS,
    );

    final hash = web.window.location.hash.replaceFirst('#', '');
    final uri = Uri.parse(
      hash.startsWith('/') ? hash : (hash.isEmpty ? '/' : '/$hash'),
    );

    _navigateToPath(uri.path, uri.queryParameters, replace: true);
  }

  static void _navigateToPath(
    String path,
    Map<String, String> queryParams, {
    bool replace = false,
  }) {
    final page = _resolveRoute(path, queryParams);
    if (page != null) {
      if (replace && _stack.isNotEmpty) {
        _stack.removeLast();
      }

      _stack.add(page);
      _updateHistory(
        page: page,
        routeName: path,
        queryParams: queryParams,
        replaceHistory: replace,
      );
      _refresh(withTransition: true);
      return;
    }

    if (path == '/' && _routes.isNotEmpty) {
      final firstRoute = _routes.entries.first;
      final fallbackPage = firstRoute.value(queryParams);
      if (replace && _stack.isNotEmpty) {
        _stack.removeLast();
      }

      _stack.add(fallbackPage);
      _updateHistory(
        page: fallbackPage,
        routeName: firstRoute.key,
        queryParams: queryParams,
        replaceHistory: replace,
      );
      _refresh(withTransition: false);
      return;
    }

    _show404(path);
  }

  static Widget? _resolveRoute(String path, Map<String, String> queryParams) {
    final exactBuilder = _routes[path];
    if (exactBuilder != null) {
      return exactBuilder(queryParams);
    }

    for (final entry in _routes.entries) {
      final matchedParams = matchRoutePattern(entry.key, path);
      if (matchedParams == null) {
        continue;
      }

      return entry.value({...queryParams, ...matchedParams});
    }

    return null;
  }

  static void seed(Widget page) {
    if (_stack.isEmpty) {
      _stack.add(page);
    }
  }

  static void _updateHistory({
    required Widget page,
    String? routeName,
    Map<String, String>? queryParams,
    bool replaceHistory = false,
  }) {
    final route = routeName ?? '/${page.runtimeType.toString().toLowerCase()}';
    final uri = buildHashRouteUrl(route, queryParams);

    if (replaceHistory) {
      web.window.history.replaceState(page.toString().toJS, '', uri);
      return;
    }

    web.window.history.pushState(page.toString().toJS, '', uri);
  }

  static void _show404(String routeName) {
    final html = '<div>404: Route "$routeName" not found</div>';
    final output = web.document.querySelector('#output');
    if (output != null) {
      output.setHTMLUnsafe(html.toJS);
    }
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
