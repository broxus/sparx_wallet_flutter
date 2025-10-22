import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Function signature for custom page builders in Compass routes.
///
/// This allows for creating custom page transitions by providing a Page
/// implementation for a route.
///
/// [context] The build context
/// [data] The route data of type T
/// [state] The current GoRouter state
typedef CompassPageBuilder<T extends CompassRouteData> =
    Page<dynamic> Function(BuildContext context, T data, GoRouterState state);

/// Function signature for widget builders in Compass routes.
///
/// This is used for creating the widget for a route, with strongly typed
/// access to the route data.
///
/// [context] The build context
/// [data] The route data of type T
/// [state] The current GoRouter state
typedef CompassWidgetBuilder<T extends CompassRouteData> =
    Widget Function(BuildContext context, T data, GoRouterState state);

/// Marker interface for all route data classes.
///
/// All classes used as route data in the Compass navigation system
/// must implement this interface to maintain type safety.
interface class CompassRouteData {}

/// Base route class to provide common navigation functionality.
///
/// This is the foundation of the Compass navigation system, defining
/// the basic contract that all route types must follow.
abstract class CompassBaseRoute {
  CompassBaseRoute({this.isTopLevel = false});

  /// Get route for this navigator.
  ///
  /// This method must be implemented to provide a GoRouter-compatible
  /// route definition (GoRoute, ShellRoute, etc.).
  RouteBase get route;

  /// Indicates if this is a top-level route in the navigation hierarchy.
  ///
  /// Top-level routes are registered directly with the root GoRouter instance.
  final bool isTopLevel;
}
