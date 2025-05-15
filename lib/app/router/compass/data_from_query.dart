// ignore: one_member_abstracts
import 'package:app/app/router/compass/go_route.dart';
import 'package:app/app/router/compass/route.dart';
import 'package:go_router/go_router.dart';

/// Interface for route data classes that support query parameters.
///
/// This interface defines the contract for route data classes that need
/// to convert their data to URL query parameters.
abstract interface class CompassRouteDataQuery implements CompassRouteData {
  /// Convert route data to query parameters
  ///
  /// This method should transform the route data object into a map of
  /// string key-value pairs suitable for inclusion in a URL.
  Map<String, String> toQueryParams();
}

/// Mixin for handling query parameters in route classes.
///
/// This mixin provides implementations for converting between route data
/// and URL query parameters. It's designed to be used with [CompassBaseGoRoute]
/// implementations that handle query-parameterized navigation.
mixin CompassRouteDataQueryMixin<T extends CompassRouteDataQuery>
    on CompassBaseGoRoute<T> {
  late final _prefix = '$pathWithoutLeadingSlash~';

  /// Removes query parameters specific to this route from the provided map.
  ///
  /// This is useful when cleaning up query parameters during navigation.
  ///
  /// [queryParams] The full set of query parameters to filter.
  ///
  /// Returns a new map with this route's parameters removed.
  Map<String, String> clearScreenQueries(Map<String, String> queryParams) {
    return Map.fromEntries(
      queryParams.entries.where((entry) => !entry.key.startsWith(_prefix)),
    );
  }

  /// Creates a route data object from the provided query parameters.
  ///
  /// Implementations must define how to convert the filtered parameters
  /// into a properly typed route data object.
  ///
  /// [queryParams] Query parameters to convert to route data.
  T fromQueryParams(Map<String, String> queryParams);

  @override
  T dataFromState(GoRouterState state) {
    final patchedParams = <String, String>{};
    for (final MapEntry(key: key, value: value)
        in state.uri.queryParameters.entries) {
      if (key.startsWith(_prefix)) {
        patchedParams[key.substring(_prefix.length)] = value;
      }
    }

    return fromQueryParams(patchedParams);
  }

  @override
  Uri toLocation(T data) {
    return Uri(
      path: path,
      queryParameters: data.toQueryParams().map(
            (k, v) => MapEntry('$_prefix$k', v),
          ),
    );
  }
}

/// Mixin for handling routes without query parameters.
///
/// This mixin provides implementations for routes that don't require
/// any data transfer via query parameters. It simplifies the creation
/// of basic navigation routes.
mixin EmptyRouteDataMixin<T extends CompassRouteData> on CompassBaseGoRoute<T> {
  @override
  T dataFromState(GoRouterState state) {
    return createData();
  }

  /// Factory method that creates a new instance of the route data.
  ///
  /// Since this mixin is for parameterless routes, this method should
  /// return a default instance of the route data class.
  T createData();

  @override
  Uri toLocation(T data) {
    return Uri(path: path);
  }
}
