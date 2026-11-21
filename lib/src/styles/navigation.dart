import 'dart:js_interop';

import 'package:web/web.dart' as web;

import '../../run_app.dart';
import '../widgets/animated_widgets/animate.dart';
import '../helper/route_utils.dart';
import '../widgets/utils/build_context.dart';
import '../widgets/widget.dart';

enum RouteTransition {
  none,
  fade,
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
  scale,
}

typedef RouteGuard = bool Function(String routeName);
typedef PageBuilder = Widget Function(Map<String, String> params);

class PageNavigator {
  static final List<Widget> _stack = <Widget>[];
  static final Map<String, PageBuilder> _routes = <String, PageBuilder>{};
  static RouteGuard? _guard;
  static String? _unauthorizedRoute;
  static bool _isInitialized = false;
  static Widget Function(String path)? _onUnknownRoute;

  static RouteTransition _currentTransition = RouteTransition.none;
  static bool _isPopping = false;

  static Widget get current {
    if (_stack.isEmpty) return const _EmptyWidget();
    final page = _stack.last;

    if (_currentTransition == RouteTransition.none) {
      return page;
    }

    switch (_currentTransition) {
      case RouteTransition.fade:
        return FDAnimate(child: page, fadeIn: true);
      case RouteTransition.slideLeft:
        return FDAnimate(child: page, fadeIn: true, slideX: 100.0);
      case RouteTransition.slideRight:
        return FDAnimate(child: page, fadeIn: true, slideX: -100.0);
      case RouteTransition.slideUp:
        return FDAnimate(child: page, fadeIn: true, slideY: 100.0);
      case RouteTransition.slideDown:
        return FDAnimate(child: page, fadeIn: true, slideY: -100.0);
      case RouteTransition.scale:
        return FDAnimate(child: page, fadeIn: true, startScale: 0.8);
      default:
        return page;
    }
  }

  static void registerRoutes(
    Map<String, Widget> routes, {
    RouteGuard? guard,
    String? unauthorizedRoute,
    Widget Function(String path)? onUnknownRoute,
  }) {
    _routes
      ..clear()
      ..addAll(routes.map((key, value) => MapEntry(key, (_) => value)));

    _guard = guard;
    _unauthorizedRoute = unauthorizedRoute;
    _onUnknownRoute = onUnknownRoute;
  }

  static void registerDynamicRoutes(Map<String, PageBuilder> routes) {
    _routes.addAll(routes);
  }

  static void registerShellRoute({
    required Widget Function(Widget child) shell,
    required Map<String, PageBuilder> routes,
  }) {
    for (final entry in routes.entries) {
      _routes[entry.key] = (params) => shell(entry.value(params));
    }
  }

  static void removeRoute(String pattern) {
    _routes.remove(pattern);
  }

  static void push(Widget page,
      {RouteTransition transition = RouteTransition.none}) {
    _stack.add(page);
    _currentTransition = transition;
    _updateHistory(page: page);
    _refresh(withTransition: transition != RouteTransition.none);
  }

  static void pushNamed(
    String routeName, {
    Map<String, String>? queryParams,
    RouteTransition transition = RouteTransition.none,
  }) {
    if (isExternalUrl(routeName)) {
      openUrl(routeName, newTab: false);
      return;
    }

    if (_guard != null && !_guard!(routeName)) {
      if (_unauthorizedRoute != null) {
        pushNamed(_unauthorizedRoute!, transition: transition);
      }
      return;
    }

    _currentTransition = transition;
    _navigateToPath(routeName, queryParams ?? <String, String>{},
        replace: false);
  }

  static void replace(Widget page,
      {RouteTransition transition = RouteTransition.none}) {
    if (_stack.isNotEmpty) {
      _stack.removeLast();
    }

    _stack.add(page);
    _currentTransition = transition;
    _updateHistory(page: page, replaceHistory: true);
    _refresh(withTransition: transition != RouteTransition.none);
  }

  static void replaceNamed(
    String routeName, {
    Map<String, String>? queryParams,
    RouteTransition transition = RouteTransition.none,
  }) {
    if (isExternalUrl(routeName)) {
      openUrl(routeName, newTab: false);
      return;
    }

    if (_guard != null && !_guard!(routeName)) {
      if (_unauthorizedRoute != null) {
        replaceNamed(_unauthorizedRoute!, transition: transition);
      }
      return;
    }

    _currentTransition = transition;
    _navigateToPath(routeName, queryParams ?? <String, String>{},
        replace: true);
  }

  static void pop({RouteTransition transition = RouteTransition.none}) {
    if (_stack.length > 1) {
      _stack.removeLast();
      _isPopping = true;
      _currentTransition = transition;
      web.window.history.back();
      _refresh(withTransition: transition != RouteTransition.none);
      return;
    }

    print('Cannot pop: FDStack empty or single item');
  }

  /// Whether the given [url] is an external web URL (e.g. http://, https://, mailto:, etc.).
  static bool isExternal(String url) => isExternalUrl(url);

  /// Navigates to an external website or URL.
  ///
  /// Set [newTab] to `true` to open in a new browser tab/window (`_blank`).
  /// Set [newTab] to `false` (default) to navigate within the same tab (`location.assign`).
  static void openUrl(String url, {bool newTab = false}) {
    if (newTab) {
      web.window.open(url, '_blank');
    } else {
      web.window.location.assign(url);
    }
  }

  /// Convenience helper matching Flutter url_launcher semantics.
  /// Launches [url] in either a new tab or the same tab.
  static void launchUrl(String url, {bool newTab = false}) {
    openUrl(url, newTab: newTab);
  }

  /// Opens an internal route or external website in a new tab (`_blank`).
  static void pushNewTab(String routeOrUrl, {Map<String, String>? queryParams}) {
    if (isExternalUrl(routeOrUrl)) {
      openUrl(routeOrUrl, newTab: true);
      return;
    }
    final uri = buildHashRouteUrl(routeOrUrl, queryParams);
    web.window.open(uri, '_blank');
  }

  /// Navigates to an external website or route in the current tab (or new tab if specified).
  static void navigateExternal(
    String routeOrUrl, {
    Map<String, String>? queryParams,
    bool newTab = false,
  }) {
    if (isExternalUrl(routeOrUrl)) {
      openUrl(routeOrUrl, newTab: newTab);
      return;
    }
    final uri = buildHashRouteUrl(routeOrUrl, queryParams);
    if (newTab) {
      web.window.open(uri, '_blank');
    } else {
      web.window.location.assign(uri);
    }
  }

  static void init() {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    web.window.addEventListener(
      'popstate',
      ((web.Event _) {
        if (_isPopping) {
          _isPopping = false;
          return;
        }

        if (_stack.length > 1) {
          _stack.removeLast();
          _currentTransition = RouteTransition.none;
          _refresh(withTransition: false);
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
      _refresh(withTransition: _currentTransition != RouteTransition.none);
      return;
    }

    if ((path == '/' || path.isEmpty) && _stack.isNotEmpty) {
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
      _refresh(withTransition: _currentTransition != RouteTransition.none);
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

  static bool get isInitialized => _isInitialized;
  static int get stackLength => _stack.length;
  static bool get isStackEmpty => _stack.isEmpty;

  static void reset() {
    _stack.clear();
    _routes.clear();
    _guard = null;
    _unauthorizedRoute = null;
    _isInitialized = false;
    _onUnknownRoute = null;
    _currentTransition = RouteTransition.none;
    _isPopping = false;
  }

  static void replaceRoot(Widget page) {
    if (_stack.isEmpty) {
      _stack.add(page);
    } else {
      _stack[0] = page;
    }
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

  static void _show404(String path) {
    if (_onUnknownRoute != null) {
      final fallbackPage = _onUnknownRoute!(path);
      _stack.add(fallbackPage);
      _updateHistory(
        page: fallbackPage,
        routeName: path,
        replaceHistory: true,
      );
      _refresh(withTransition: false);
      return;
    }

    final html = '<div>404: Route "\$path" not found</div>';
    final output = web.document.querySelector('#output');
    if (output != null) {
      output.setHTMLUnsafe(html.toJS);
    }
  }

  static void _refresh({bool withTransition = false}) {
    reRenderApp();
    if (!withTransition) {
      _currentTransition = RouteTransition.none;
    }
  }
}

class _EmptyWidget extends Widget {
  const _EmptyWidget();

  @override
  String render(BuildContext context) => '<div>No route defined</div>';
}
