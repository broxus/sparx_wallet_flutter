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
    super.isTopLevel,
    this.name,
    this.parentNavigatorKey,
  });

  /// Optional name identifier for this shell route.
  ///
  /// Unlike regular routes, shell routes don't always need a name
  /// as they often serve as containers rather than direct navigation targets.
  final String? name;

  /// List of navigation branches that make up this shell.
  ///
  /// Each branch typically corresponds to a tab in a tab-based navigation
  /// and contains its own stack of routes.
  final List<StatefulShellBranch> branches;

  /// Optional navigator key for controlling which navigator stack
  /// this shell route belongs to.
  final GlobalKey<NavigatorState>? parentNavigatorKey;

  /// Builder function for creating the shell's UI.
  ///
  /// This method is called to build the shell container that hosts
  /// the active branch's content. Implementations would typically return
  /// a scaffold with a bottom navigation bar or similar UI pattern.
  ///
  /// [context] The build context
  /// [state] The current GoRouter state
  /// [navigationShell] The shell that manages navigation between branches
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  );

  @override
  late final StatefulShellRoute route = StatefulShellRoute.indexedStack(
    builder: builder,
    branches: branches,
    parentNavigatorKey: parentNavigatorKey,
  );
}

