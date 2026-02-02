import 'package:app/app/router/compass/data_from_query.dart';
import 'package:app/app/router/compass/go_route.dart';
import 'package:app/app/router/compass/route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class _MockGoRouterState extends Mock implements GoRouterState {}

class _QueryData implements CompassRouteDataQuery {
  _QueryData({required this.a, required this.b});

  final String a;
  final String b;

  @override
  Map<String, String> toQueryParams() => {'a': a, 'b': b};
}

class _EmptyData implements CompassRouteData {
  const _EmptyData();
}

class _QueryRoute extends CompassBaseGoRoute<_QueryData>
    with CompassRouteDataQueryMixin<_QueryData> {
  _QueryRoute() : super(path: '/screen', name: 'screen');

  @override
  _QueryData fromQueryParams(Map<String, String> queryParams) {
    return _QueryData(a: queryParams['a'] ?? '', b: queryParams['b'] ?? '');
  }
}

class _EmptyRoute extends CompassBaseGoRoute<_EmptyData>
    with EmptyRouteDataMixin<_EmptyData> {
  _EmptyRoute() : super(path: '/empty', name: 'empty');

  @override
  _EmptyData createData() => const _EmptyData();
}

void main() {
  group('CompassRouteDataQueryMixin', () {
    test('toLocation adds a slash prefix if necessary', () {
      final route = _QueryRoute();

      final uri = route.toLocation(_QueryData(a: '10', b: '20'));

      expect(uri.path, '/screen');
      expect(uri.queryParameters, <String, String>{
        'screen~a': '10',
        'screen~b': '20',
      });
    });

    test('dataFromState extracts only prefixed params and strips prefix', () {
      final route = _QueryRoute();

      final state = _MockGoRouterState();
      when(() => state.uri).thenReturn(
        Uri(
          path: '/screen',
          queryParameters: <String, String>{
            'screen~a': '1',
            'screen~b': '2',
            'other~a': 'SHOULD_IGNORE',
            'a': 'SHOULD_IGNORE',
          },
        ),
      );

      final data = route.dataFromState(state);

      expect(data.a, '1');
      expect(data.b, '2');
    });

    test('dataFromState passes empty map into fromQueryParams '
        'when no prefixed keys exist', () {
      final route = _QueryRoute();

      final state = _MockGoRouterState();
      when(() => state.uri).thenReturn(
        Uri(
          path: '/screen',
          queryParameters: <String, String>{'a': '1', 'b': '2', 'other~a': '3'},
        ),
      );

      final data = route.dataFromState(state);

      expect(data.a, '');
      expect(data.b, '');
    });

    test('clearScreenQueries removes only keys belonging '
        'to this route prefix', () {
      final route = _QueryRoute();

      final input = <String, String>{
        'screen~a': '1',
        'screen~b': '2',
        'other~a': 'x',
        'plain': 'y',
      };

      final cleared = route.clearScreenQueries(input);

      expect(cleared, <String, String>{'other~a': 'x', 'plain': 'y'});
    });

    test('clearScreenQueries returns a new map (does not mutate input)', () {
      final route = _QueryRoute();

      final input = <String, String>{'screen~a': '1', 'plain': 'y'};

      final cleared = route.clearScreenQueries(input);

      expect(cleared, isNot(same(input)));
      expect(input, <String, String>{'screen~a': '1', 'plain': 'y'});
    });
  });

  group('EmptyRouteDataMixin', () {
    test('dataFromState returns createData result', () {
      final route = _EmptyRoute();

      final state = _MockGoRouterState();
      when(() => state.uri).thenReturn(Uri(path: '/empty'));

      final data = route.dataFromState(state);

      expect(data, isA<_EmptyData>());
    });

    test('toLocation returns Uri with path only (no query parameters)', () {
      final route = _EmptyRoute();

      final uri = route.toLocation(const _EmptyData());

      expect(uri.path, '/empty');
      expect(uri.queryParameters, isEmpty);
    });
  });

  group('Prefix behavior', () {
    test('prefix equals', () {
      final route = _QueryRoute();
      final uri = route.toLocation(_QueryData(a: 'x', b: 'y'));

      expect(
        uri.queryParameters.keys,
        containsAll(<String>{'screen~a', 'screen~b'}),
      );
    });
  });
}
