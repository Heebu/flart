import 'package:flartdart/src/helper/route_utils.dart';
import 'package:test/test.dart';

void main() {
  group('matchRoutePattern', () {
    test('matches dynamic path parameters', () {
      final params = matchRoutePattern(
          '/users/:id/orders/:orderId', '/users/42/orders/abc');

      expect(params, isNotNull);
      expect(params!['id'], '42');
      expect(params['orderId'], 'abc');
    });

    test('returns null for non-matching path', () {
      final params = matchRoutePattern('/users/:id', '/products/42');
      expect(params, isNull);
    });

    test('decodes url encoded parameters', () {
      final params =
          matchRoutePattern('/search/:query', '/search/hello%20world');
      expect(params, isNotNull);
      expect(params!['query'], 'hello world');
    });

    test('matches wildcard catch-all at end', () {
      final params = matchRoutePattern('/docs/*', '/docs/api/v2/auth');
      expect(params, isNotNull);
      expect(params!['*'], 'api/v2/auth');
    });

    test('matches wildcard when no trailing segments exist', () {
      final params = matchRoutePattern('/docs/*', '/docs');
      expect(params, isNotNull);
      expect(params!['*'], '');
    });
  });

  group('buildHashRouteUrl', () {
    test('interpolates path parameters from params map', () {
      final url = buildHashRouteUrl('/users/:id', <String, String>{
        'id': '42',
        'tab': 'posts',
      });
      expect(url, '#/users/42?tab=posts');
    });

    test('normalizes routes and encodes query params', () {
      final url = buildHashRouteUrl('details/42', <String, String>{
        'filter': 'active users',
        'sort': 'desc',
      });

      expect(url, startsWith('#/details/42?'));
      expect(url, contains('filter=active+users'));
      expect(url, contains('sort=desc'));
    });

    test('supports empty params', () {
      expect(buildHashRouteUrl('/home', null), '#/home');
      expect(buildHashRouteUrl('/home', <String, String>{}), '#/home');
    });

    test('interpolates wildcard parameter', () {
      final url = buildHashRouteUrl('/docs/*', <String, String>{
        '*': 'api/v2/auth',
      });
      expect(url, '#/docs/api/v2/auth');
    });
  });

  group('normalizePath', () {
    test('strips trailing slashes and normalizes root', () {
      expect(normalizePath(''), '/');
      expect(normalizePath('/'), '/');
      expect(normalizePath('/about/'), '/about');
      expect(normalizePath('///about//team///'), '/about/team');
    });
  });
}
