import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:flutter/material.dart';

/// An abstraction for router interceptors that can modify navigation behavior.
///
/// CompassGuard allows implementing navigation guards that can redirect routes
/// based on application logic like authentication or permissions.
abstract class CompassGuard {
  /// Creates a guard with specified priority.
  ///
  /// Higher priority guards execute first during navigation.
  CompassGuard({required this.priority});

  /// Priority value determining execution order.
  ///
  /// Higher values execute before lower values.
  final int priority;

  /// Attaches this guard to the specified router.
  ///
  /// Sets up necessary subscriptions or listeners.
  void attachToRouter(CompassRouter router);

  /// Detaches the guard and cleans up resources.
  ///
  /// Cancels subscriptions and releases any references.
  void detach();

  /// Determines whether to redirect a navigation request.
  ///
  /// [context] Current build context (may be null).
  /// [location] Target navigation location as a list of routes.
  ///
  /// Returns new route data for redirection, or null to proceed normally.
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  );
}

/// A route data implementation that bypasses normal safety checks.
///
/// This class allows redirecting to a raw string route, which skips
/// type checking and parameter validation. Use with caution as it
/// may lead to runtime errors if the route is malformed.
class UnsafeRedirectCompassRouteData implements CompassRouteData {
  UnsafeRedirectCompassRouteData({required this.route});

  /// The raw route string to redirect to.
  final String route;
}

/// High priority constant for navigation guards.
///
/// Guards with this priority will execute first in the navigation pipeline.
const priorityHigh = 3;

/// Medium priority constant for navigation guards.
///
/// Guards with this priority will execute after high priority guards.
const priorityMedium = 2;

/// Low priority constant for navigation guards.
///
/// Guards with this priority will execute last in the navigation pipeline.
const priorityLow = 1;

