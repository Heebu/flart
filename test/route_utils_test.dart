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
  });

  group('buildHashRouteUrl', () {
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
  });
}
