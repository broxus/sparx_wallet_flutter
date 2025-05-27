# Compass Navigation in SparX Wallet

This document describes the type-safe navigation system (Compass) implemented in the SparX Wallet Flutter application.

## Overview

The Compass navigation system provides a type-safe way to define routes and navigate between screens. It's built on top of GoRouter but adds strong typing for route parameters, consistent navigation patterns, and navigation guards.

The system is designed to ensure:

- Type safety throughout the navigation process
- Predictable navigation behavior
- Support for deep linking and complex navigation patterns
- Testability of navigation logic

## Key Concepts

### Route Data

All navigation in Compass is driven by strongly-typed data objects that implement the `CompassRouteData` interface. These objects:

- Carry all parameters needed for a route
- Can be converted to/from URL query parameters
- Have well-defined structures (but should NOT use Freezed)

### Routes

The Compass system provides different route abstractions for different navigation scenarios:

- **`CompassRoute<T>`**: For routes that require query parameters
- **`CompassRouteParameterless<T>`**: For routes without parameters
- **`CompassShellRoute`**: For shell routes (e.g., tabbed navigation)

### Navigation Guards

Guards allow intercepting navigation requests to implement:

- Authentication protection
- Redirects based on application state
- Feature flags
- Deep link handling

## Core Components

### `CompassRouteData`

```dart
interface class CompassRouteData {}
```

Base interface implemented by all route data classes. Route data objects carry navigation parameters and state between screens.

### `CompassRouteDataQuery`

```dart
abstract interface class CompassRouteDataQuery implements CompassRouteData {
  Map<String, String> toQueryParams();
}
```

Interface for route data that needs to be converted to URL query parameters.

### `CompassBaseRoute`

```dart
abstract class CompassBaseRoute {
  RouteBase get route;
  final bool isTopLevel;
}
```

Base class that all routes extend. Provides common functionality and the contract for getting a GoRouter-compatible route.

## Navigation Classes

The Compass system provides several base classes for creating routes with different behaviors:

### `CompassRoute<T>`

Use this for routes that require parameters:

```dart
abstract class CompassRoute<T extends CompassRouteDataQuery>
    extends CompassBaseGoRoute<T> with CompassRouteDataQueryMixin<T> {
  // ...
}
```

Key features:

- Handles query parameter serialization and deserialization
- Provides type-safe access to route parameters
- Preserves parameters during navigation

### `CompassRouteParameterless<T>`

Use this for routes that don't require parameters:

```dart
abstract class CompassRouteParameterless<T extends CompassRouteData>
    extends CompassBaseGoRoute<T> with EmptyRouteDataMixin<T> {
  // ...
}
```

Key features:

- Simplified implementation for routes without parameters
- Uses a factory method pattern with `dataFabric()` to create route data
- Type-safe routing without the overhead of parameter handling

### `CompassShellRoute`

Use this for creating shell-based navigation (like bottom tabs):

```dart
abstract class CompassShellRoute
    extends CompassBaseStatefulShellRoute {
  // ...
}
```

Key features:

- Creates a StatefulShellRoute for complex UI patterns like tab navigation
- Each child route becomes a separate branch in the shell
- Maintains independent navigation state for each branch
- Provides a custom builder method for creating the shell UI

## Route Resolution and DI Integration

The `CompassRouter` class handles route resolution using several mapping strategies:

1. **Type-based Resolution**: Routes are mapped by their route data type
2. **Path-based Resolution**: Routes are mapped by URL path
3. **Guard-based Resolution**: Navigation requests are filtered through guards

These resolution strategies ensure that navigation requests:

- Target the correct route
- Carry the right data
- Are properly intercepted by guards when needed

### How Routes and Guards are Discovered

The Compass router automatically discovers routes and guards through dependency injection:

1. During router initialization, it scans the DI container for all registered types
2. It identifies classes that implement `CompassBaseRoute` or `CompassGuard`
3. These components must be registered using the specific DI pattern (see below) to be discovered
4. The router then builds its routing table and middleware chain using these discovered components

Specifically, in `CompassRouter`:

- Routes are discovered via `GetIt.I.getAll<CompassBaseRoute>()`
- Guards are discovered via `GetIt.I.getAll<CompassGuard>()`
- Guards are sorted by priority for execution order (higher priority guards execute first)
- Only routes marked with `isTopLevel = true` are registered directly with the root GoRouter
- Only one route should be marked with `isInitial = true` to define the app's initial route

This automatic discovery eliminates the need for manual route registration and ensures that all properly annotated route classes are included in the routing system.

#### Route and Guard Registration

Routes and guards must be registered using a specific pattern for the DI container to discover them:

**For Routes:**

```dart
@named
@Singleton(as: CompassBaseRoute)
class MyRoute extends CompassRouteParameterless<MyRouteData> {
  // Implementation
}
```

**For Guards:**

```dart
@named
@Singleton(as: CompassGuard)
class MyGuard extends CompassGuard {
  // Implementation
}
```

This pattern ensures that:

1. The concrete implementation is registered with a unique name (`@named`)
2. The implementation is registered as its base interface type (`CompassBaseRoute` or `CompassGuard`)
3. The DI container can find all implementations of the base types

## How To Use

### 1. Define Route Data Class

First, define a class that implements `CompassRouteDataQuery`:

```dart
class ProfileRouteData implements CompassRouteDataQuery {
  const ProfileRouteData({
    required this.userId,
    this.displayName,
  });

  final String userId;
  final String? displayName;

  @override
  Map<String, String> toQueryParams() {
    return {
      'userId': userId,
      if (displayName != null) 'displayName': displayName!,
    };
  }
}
```

For parameterless routes, implement `CompassRouteData` instead:

```dart
class HomeRouteData implements CompassRouteData {
  const HomeRouteData();
}
```

### 2. Define the Route Class

For parameterized routes:

```dart
@named
@Singleton(as: CompassBaseRoute)
class ProfileRoute extends CompassRoute<ProfileRouteData> {
  ProfileRoute() : super(
    name: 'profile',
    path: '/profile',
    isTopLevel: true,
    builder: (context, data, state) => ProfilePage(userId: data.userId),
  );

  @override
  ProfileRouteData fromQueryParams(Map<String, String> queryParams) {
    return ProfileRouteData(
      userId: queryParams['userId'] ?? '',
      displayName: queryParams['displayName'],
    );
  }
}
```

For parameterless routes:

```dart
@named
@Singleton(as: CompassBaseRoute)
class HomeRoute extends CompassRouteParameterless<HomeRouteData> {
  HomeRoute() : super(
    name: 'home',
    path: '/home',
    isTopLevel: true,
    isInitial: true,
    builder: (context, data, state) => HomePage(),
  );

  @override
  HomeRouteData createData() {
    return HomeRouteData();
  }
}
```

For shell routes (like bottom tab navigation):

```dart
@named
@Singleton(as: CompassBaseRoute)
class MainShellRoute extends CompassShellRoute {
  MainShellRoute(
    @Named.from(HomeRoute) CompassBaseRoute homeRoute,
    @Named.from(ProfileRoute) CompassBaseRoute profileRoute,
  ) : super(
    isTopLevel: true,
    compassBaseRoutes: [homeRoute, profileRoute],
  );

  @override
  Widget builder(
    BuildContext context, 
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainScaffold(navigationShell: navigationShell);
  }
}
```

Shell routes create a StatefulShellRoute where each child route becomes a separate branch. This supports independent navigation stacks within a shared UI shell (like tabs).

### 3. Navigation

The Compass system provides several methods for navigation with different behaviors:

#### Navigate with `compassPoint` (like GoRouter's `go`)

Replaces the current screen in the navigation stack:

```dart
// Using CompassRouter directly
final router = GetIt.I<CompassRouter>();
router.compassPoint(ProfileRouteData(userId: '123'));

// Using BuildContext extension
context.compassPoint(ProfileRouteData(userId: '123'));
```

This is the most common navigation method and is similar to `Navigator.pushReplacement`.

#### Navigate with `compassPush` (like GoRouter's `push`)

Adds a new screen to the navigation stack and allows returning a result:

```dart
// Using CompassRouter directly
final result = await router.compassPush<ProfileRouteData, bool>(
  ProfileRouteData(userId: '123'),
);

// Using BuildContext extension
final result = await context.compassPush<ProfileRouteData, bool>(
  ProfileRouteData(userId: '123'),
);

// With isContinue parameter (default: true)
final result = await context.compassPush<ProfileRouteData, bool>(
  ProfileRouteData(userId: '123'),
  isContinue: false, // Don't preserve current location state
);
```

The `isContinue` parameter controls whether the current location's path and query parameters are preserved:

- `isContinue: true` (default) - Uses continued location strategy to preserve current state
- `isContinue: false` - Uses standard location without preserving current state

This is useful for flows where you expect a result back from the pushed screen.

#### Navigate with `compassContinue` (preserves state)

Navigates while preserving the current location's path and query parameters:

```dart
// Using CompassRouter directly
router.compassContinue(ProfileRouteData(userId: '123'));

// Using BuildContext extension
context.compassContinue(ProfileRouteData(userId: '123'));
```

Technical implementation:

1. The current path is preserved using the '.' path segment
2. The new path segments are appended to the relative path
3. Query parameters from both the original and new location are merged

This is particularly useful for preserving state in multi-step flows.

#### Go back with `compassBack`

Navigates back to the previous screen, optionally with a result:

```dart
// Using CompassRouter directly
router.compassBack<bool>(true); // With result

// Using BuildContext extension
context.compassBack(); // Without result
```

This method first cleans up query parameters from the current route, then pops the navigation stack if possible.

## Implementing Navigation Guards

Guards allow you to implement navigation interception for auth, redirects, feature flags, and similar cross-cutting concerns.

```dart
@named
@Singleton(as: CompassGuard)
class AuthGuard extends CompassGuard {
  AuthGuard(this._authService) : super(priority: priorityHigh);

  final AuthService _authService;

  @override
  void attachToRouter(CompassRouter router) {
    // Setup subscriptions or listeners
    // This method is called when the router is initialized
    // Use it to subscribe to state changes that might affect navigation
  }

  @override
  void detach() {
    // Clean up resources
    // Cancel subscriptions to prevent memory leaks
  }

  @override
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  ) {
    // Check if user is authenticated
    if (!_authService.isAuthenticated && location.last is! LoginRoute) {
      // Redirect to login by returning a different route data
      return LoginRouteData();
    }
    
    // Return null to allow navigation to proceed without redirection
    return null;
  }
}
```

Guards are executed in priority order (highest to lowest) when navigation occurs. The predefined priority constants are:

- `priorityHigh = 3` - For critical guards like authentication
- `priorityMedium = 2` - For feature flag guards and similar
- `priorityLow = 1` - For analytics and other non-blocking guards

As soon as any guard returns a non-null value, the navigation is redirected to that route and remaining guards are not executed.

## Nested Routes

Nested routes are supported through the `compassBaseRoutes` parameter:

```dart
@named
@Singleton(as: CompassBaseRoute)
class ProfileRoute extends CompassRoute<ProfileRouteData> {
  ProfileRoute(
    @Named.from(ProfileSettingsRoute) CompassBaseRoute settingsRoute,
  ) : super(
    name: 'profile',
    isTopLevel: true,
    compassBaseRoutes: [settingsRoute],
    builder: (context, data, state) => ProfilePage(userId: data.userId),
  );
  
  // ...
}
```

## Testing Navigation

The Compass system is designed to be highly testable with proper separation of concerns.

### Unit Testing Routes

For unit testing, you can mock routes and verify navigation calls:

```dart
// Setup mocks
final mockRouter = MockCompassRouter();
final mockHomeRoute = MockHomeRoute();

// Test navigation
void testNavigation() {
  final viewModel = MyViewModel(mockRouter);
  
  viewModel.goToHome();
  
  verify(mockRouter.compassPoint(any)).called(1);
}
```

### Widget Testing with MockRoutes

The project includes a `MockRoutes` helper class that provides pre-configured mock implementations of your routes:

```dart
testWidgets('Navigate to profile when button is pressed', (tester) async {
  // Setup mock routes
  final mockProfileRoute = MockRoutes.mockProfileRoute();
  
  // Build widget tree
  await tester.pumpWidget(
    MaterialApp(
      home: MyWidget(profileRoute: mockProfileRoute),
    ),
  );
  
  // Trigger navigation
  await tester.tap(find.byType(ElevatedButton));
  
  // Verify navigation
  verify(
    mockProfileRoute.compassPoint(
      argThat(predicate<ProfileRouteData>(
        (data) => data.userId == '123',
      )),
    ),
  ).called(1);
});
```

### Verifying Navigation Parameters

The `MockRoutes` class also provides helper methods to verify navigation with specific parameters:

```dart
// Verify navigation to SendToken with specific parameters
MockRoutes.verifyTokenWalletSendNavigation(
  mockTokenWalletSendRoute,
  expectedOwner,
  expectedRootTokenContract,
  expectedDestination,
  expectedAmount,
);
```

### Testing Guards

To test navigation guards, you can create a test instance of the router with mock guards:

```dart
test('AuthGuard redirects to login when user is not authenticated', () {
  // Setup
  final mockAuthService = MockAuthService();
  when(mockAuthService.isAuthenticated).thenReturn(false);
  
  final authGuard = AuthGuard(mockAuthService);
  final router = TestCompassRouter([authGuard]);
  
  // Execute navigation to protected route
  final redirectResult = router.testRedirect(
    [mockHomeRoute, mockProfileRoute], // Simulate this navigation path
    buildContext: null,
  );
  
  // Verify redirection
  expect(redirectResult, isA<LoginRouteData>());
});
```

## Why Not Use Freezed with RouteData Classes

While Freezed is a powerful tool for creating immutable data classes in Flutter, it should **not** be used with RouteData classes in the Compass navigation system. Here's why:

1. **Type Transformation**
   - Freezed generates a new class that extends your original RouteData class
   - The generated class type is actually `_$YourClass` which implements `_YourClass`
   - This changes the runtime type of your objects from the expected `YourRouteData` to something like `_$_YourRouteData`

2. **Type-Based Resolution Issues**
   - The Compass router uses type-based lookup to find the correct route for a given RouteData
   - When you create a RouteData instance with Freezed, its actual runtime type doesn't match the type expected by the router
   - This mismatch causes the router to fail to find the correct route handler

3. **Example of the Problem**:

   ```dart
   // This is what the router expects
   final type = ProfileRouteData;
   
   // But with Freezed, you get this instead
   final actualType = freezedProfileRouteData.runtimeType; // _$_ProfileRouteData
   
   // Type comparison fails
   type == actualType; // false
   ```

4. **The Solution**
   - Create simple immutable classes with final fields
   - Implement custom equality and hashCode manually if needed
   - The minimal overhead of manually writing these classes is worth the correct type preservation

## Best Practices

1. **Keep route data immutable**
   - Create immutable classes with final fields (do NOT use Freezed)
   - Don't modify route data after creation

2. **Choose the right route type**
   - Use `CompassRoute` for routes with parameters
   - Use `CompassRouteParameterless` for routes without parameters
   - Use `CompassShellRoute` for tabbed or drawer navigation

3. **Organize route files effectively**
   - Place route files in the same feature folder as the screen they navigate to
   - Use `route.dart` naming convention

4. **Use the correct registration pattern for routes and guards**
   - Routes should be registered with `@named` and `@Singleton(as: CompassBaseRoute)`
   - Guards should be registered with `@named` and `@Singleton(as: CompassGuard)`
   - Inject routes into other routes using `@Named.from(ConcreteRouteType) CompassBaseRoute routeName`
   - The router scans the dependency injection container for all registered types
   - Use constructor injection for route dependencies

5. **Avoid using Freezed with RouteData classes**
   - Freezed should NOT be used with RouteData classes as it changes the original Type of RouteData
   - This type change interferes with the router's type-based lookup mechanisms
   - Using Freezed can cause incorrect route resolution and navigation errors
   - Instead, create simple immutable classes with final fields

6. **Make route data conversions robust**
   - Handle missing or invalid parameters gracefully
   - Provide sensible defaults where possible

7. **Leverage navigation guards for cross-cutting concerns**
   - Authentication
   - Feature flags
   - Analytics
   - Deep link handling

8. **Follow naming conventions**
   - Route classes: `FooRoute`
   - Route data classes: `FooRouteData`

9. **Prioritize type safety**
   - Avoid using `UnsafeRedirectCompassRouteData` unless absolutely necessary
   - Always check navigation results when using `compassPush`
   - Use route verification when redirecting in guards

10. **Router organization and discovery**

- The router automatically discovers all routes and guards registered as their base types
- Routes must be registered with `@named` and `@Singleton(as: CompassBaseRoute)`
- Guards must be registered with `@named` and `@Singleton(as: CompassGuard)`
- Only routes with `isTopLevel = true` are registered directly with GoRouter
- Only one route should have `isInitial = true` to define the app's entry point
- Guards are executed in priority order (highest to lowest)
- Routes are identified by both type and path for efficient lookup
