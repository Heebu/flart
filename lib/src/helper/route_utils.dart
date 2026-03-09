Map<String, String>? matchRoutePattern(String pattern, String path) {
  final patternSegments = _splitPathSegments(pattern);
  final pathSegments = _splitPathSegments(path);

  if (patternSegments.length != pathSegments.length) {
    return null;
  }

  final params = <String, String>{};

  for (var i = 0; i < patternSegments.length; i++) {
    final patternPart = patternSegments[i];
    final pathPart = pathSegments[i];

    if (patternPart.startsWith(':') && patternPart.length > 1) {
      params[patternPart.substring(1)] = Uri.decodeComponent(pathPart);
      continue;
    }

    if (patternPart != pathPart) {
      return null;
    }
  }

  return params;
}

String buildHashRouteUrl(String routeName, Map<String, String>? params) {
  final normalizedRoute = routeName.startsWith('/') ? routeName : '/$routeName';

  if (params == null || params.isEmpty) {
    return '#$normalizedRoute';
  }

  final query = Uri(queryParameters: params).query;
  return '#$normalizedRoute?$query';
}

List<String> _splitPathSegments(String path) {
  if (path == '/' || path.isEmpty) {
    return const <String>[];
  }

  return path.split('/').where((segment) => segment.isNotEmpty).toList();
}
