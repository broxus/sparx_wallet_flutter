import 'package:app/app/router/compass/route.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Base abstraction for creating GoRoute instances with default values.
///
/// This class serves as the foundation for route implementations in the Compass
/// navigation system. It encapsulates the common behavior and properties needed
/// to create GoRouter routes with strongly typed data.
abstract class CompassBaseGoRoute<T extends CompassRouteData>
    extends CompassBaseRoute {
  CompassBaseGoRoute({
    required this.path,
    this.name,
    this.builder,
    this.pageBuilder,
    this.isInitial = false,
    this.isSaveLocation = false,
    this.isSaveSubroutes = false,
    this.isBottomNavigationBarVisible = false,
    super.isTopLevel,
    this.routes = const <RouteBase>[],
    this.redirect,
    this.parentNavigatorKey,
  });

  /// The runtime type of route data this route expects.
  ///
  /// This is used for type-safe route lookup in the router.
  final Type routeDataType = T;

  /// The name identifier for this route.
  ///
  /// This is used in the GoRouter configuration and for route lookup.
  final String? name;

  /// The URL path segment for this route.
  ///
  /// By default, this is just the route name prefixed with a slash,
  /// but it can be customized through the constructor.
  final String path;

  /// Builder function for creating the route's widget.
  ///
  /// This function receives the context, route data, and GoRouter state
  /// and should return the widget to display for this route.
  final CompassWidgetBuilder<T>? builder;

  /// Builder function for creating a custom navigation page.
  ///
  /// This allows for custom page transitions by providing a custom page
  /// implementation instead of a simple widget.
  final CompassPageBuilder<T>? pageBuilder;

  /// Optional redirect function for conditional navigation.
  ///
  /// This follows the GoRouter redirect pattern and can be used to
  /// implement navigation guards at the route level.
  final GoRouterRedirect? redirect;

  /// Optional navigator key for controlling which navigator stack
  /// this route belongs to.
  final GlobalKey<NavigatorState>? parentNavigatorKey;

  /// Child routes that will be nested under this route.
  final List<RouteBase> routes;

  /// Whether this route is the initial route of the application.
  ///
  /// Only one route should have this flag set to true.
  final bool isInitial;

  /// Whether to save this route's location when navigating away.
  ///
  /// This is used for features like "return to previous location."
  final bool isSaveLocation;

  /// Whether to save this route's subroutes when navigating away.
  ///
  /// This is used to preserve nested navigation state.
  final bool isSaveSubroutes;

  /// Whether to show the bottom navigation bar on this route.
  ///
  /// Defaults to false. Set to true for routes that should display
  /// the bottom navigation bar.
  final bool isBottomNavigationBarVisible;

  /// Converts route data to a URI location.
  ///
  /// This is used when navigating to this route with specific data.
  /// Implementations define how route data is encoded in the URI.
  Uri toLocation(T data);

  /// Extracts route data from a GoRouter state.
  ///
  /// This is used when building the route's widget to provide it with
  /// the correct data from the current navigation state.
  T dataFromState(GoRouterState state);

  @override
  late final GoRoute route = GoRoute(
    path: path,
    name: name,
    builder: builder != null
        ? (context, state) => builder!(context, dataFromState(state), state)
        : null,
    pageBuilder: pageBuilder != null
        ? (context, state) => pageBuilder!(context, dataFromState(state), state)
        : null,
    redirect: redirect,
    routes: routes,
    parentNavigatorKey: parentNavigatorKey,
  );

  String get pathWithoutLeadingSlash => path.substring(1);
}
