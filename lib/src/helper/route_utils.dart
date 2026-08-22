String normalizePath(String path) {
  if (path.isEmpty) return '/';
  final segments = _splitPathSegments(path);
  if (segments.isEmpty) return '/';
  return '/${segments.join('/')}';
}

Map<String, String>? matchRoutePattern(String pattern, String path) {
  final patternSegments = _splitPathSegments(pattern);
  final pathSegments = _splitPathSegments(path);
  final params = <String, String>{};

  for (var i = 0; i < patternSegments.length; i++) {
    final patternPart = patternSegments[i];

    if (patternPart == '*') {
      // Catch-all: match all remaining path segments
      final remaining = pathSegments.skip(i).join('/');
      params['*'] = remaining;
      return params;
    }

    // If we run out of path segments before pattern segments (and it wasn't a wildcard)
    if (i >= pathSegments.length) {
      return null;
    }

    final pathPart = pathSegments[i];

    if (patternPart.startsWith(':') && patternPart.length > 1) {
      params[patternPart.substring(1)] = Uri.decodeComponent(pathPart);
      continue;
    }

    if (patternPart != pathPart) {
      return null;
    }
  }

  if (patternSegments.isNotEmpty && patternSegments.last == '*') {
    // Already returned inside the loop
  } else if (patternSegments.length != pathSegments.length) {
    return null;
  }

  return params;
}

String buildHashRouteUrl(String routeName, Map<String, String>? params) {
  final normalizedRoute = normalizePath(routeName);

  if (params == null || params.isEmpty) {
    return '#$normalizedRoute';
  }

  final queryParams = Map<String, String>.from(params);
  final segments = _splitPathSegments(normalizedRoute);

  for (var i = 0; i < segments.length; i++) {
    final segment = segments[i];
    if (segment.startsWith(':') && segment.length > 1) {
      final paramName = segment.substring(1);
      if (queryParams.containsKey(paramName)) {
        segments[i] = Uri.encodeComponent(queryParams[paramName]!);
        queryParams.remove(paramName);
      }
    } else if (segment == '*' && queryParams.containsKey('*')) {
      segments[i] = queryParams['*']!;
      queryParams.remove('*');
    }
  }

  final interpolatedPath = segments.isEmpty ? '/' : '/${segments.join('/')}';

  if (queryParams.isEmpty) {
    return '#$interpolatedPath';
  }

  final query = Uri(queryParameters: queryParams).query;
  return '#$interpolatedPath?$query';
}

List<String> _splitPathSegments(String path) {
  if (path == '/' || path.isEmpty) {
    return const <String>[];
  }

  return path.split('/').where((segment) => segment.isNotEmpty).toList();
}
