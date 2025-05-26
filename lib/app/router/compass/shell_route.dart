import 'package:app/app/router/compass/route.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Base implementation for stateful shell routes in the Compass system.
///
/// This class provides the foundation for creating shell routes, which are
/// typically used for tab-based navigation where each tab has its own
/// navigation stack.
abstract class CompassBaseStatefulShellRoute extends CompassBaseRoute {
  CompassBaseStatefulShellRoute({
    required this.branches,
    this.parentNavigatorKey,
    this.redirect,
    this.builder,
    this.pageBuilder,
    this.restorationScopeId,
    this.key,
    super.isTopLevel,
  });

  /// List of navigation branches that make up this shell.
  ///
  /// Each branch typically corresponds to a tab in a tab-based navigation
  /// and contains its own stack of routes.
  final List<StatefulShellBranch> branches;

  /// Optional navigator key for controlling which navigator stack
  /// this shell route belongs to.
  final GlobalKey<NavigatorState>? parentNavigatorKey;

  /// Optional redirect function for conditional navigation.
  ///
  /// This follows the GoRouter redirect pattern and can be used to
  /// implement navigation guards at the route level.
  final GoRouterRedirect? redirect;

  /// Builder function for creating the shell's UI.
  ///
  /// This method is called to build the shell container that hosts
  /// the active branch's content. Implementations would typically return
  /// a scaffold with a bottom navigation bar or similar UI pattern.
  final StatefulShellRouteBuilder? builder;

  final StatefulShellRoutePageBuilder? pageBuilder;
  final String? restorationScopeId;
  final GlobalKey<StatefulNavigationShellState>? key;

  @override
  late final StatefulShellRoute route = StatefulShellRoute.indexedStack(
    builder: builder,
    pageBuilder: pageBuilder,
    branches: branches,
    redirect: redirect,
    restorationScopeId: restorationScopeId,
    parentNavigatorKey: parentNavigatorKey,
    key: key,
  );
}
