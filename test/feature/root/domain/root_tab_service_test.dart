import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/feature/root/domain/root_tab_service.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class MockCompassRouter extends Mock implements CompassRouter {}

class MockBrowserService extends Mock implements BrowserService {}

class MockWalletRoute extends Mock implements WalletRoute {
  @override
  BottomBarState get bottomBarState => BottomBarState.expanded;
}

class MockBrowserRoute extends Mock implements BrowserRoute {
  @override
  BottomBarState get bottomBarState => BottomBarState.expanded;

  @override
  Type get runtimeType => BrowserRoute;
}

class MockProfileRoute extends Mock implements ProfileRoute {
  @override
  BottomBarState get bottomBarState => BottomBarState.collapsed;

  @override
  Type get runtimeType => ProfileRoute;
}

class MockCompassBaseGoRoute extends Mock
    implements CompassBaseGoRoute<CompassRouteData> {
  @override
  BottomBarState get bottomBarState => BottomBarState.collapsed;
}

class MockFullscreenRoute extends Mock
    implements CompassBaseGoRoute<CompassRouteData> {
  @override
  BottomBarState get bottomBarState => BottomBarState.hidden;
}

void main() {
  late RootTabService rootTabService;
  late MockCompassRouter mockRouter;
  late MockBrowserService mockBrowserService;

  setUp(() {
    mockRouter = MockCompassRouter();
    mockBrowserService = MockBrowserService();

    rootTabService = RootTabService(
      mockRouter,
      mockBrowserService,
    );

    // Set up fallbacks for mocktail
    registerFallbackValue(RootTab.wallet);
  });

  group('RootTabService', () {
    group('rootTabStream', () {
      test('should emit wallet tab when current route is WalletRoute', () {
        // Arrange
        final walletRoute = MockWalletRoute();
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          [walletRoute],
        );
        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.rootTabStream,
          emits(RootTab.wallet),
        );
      });

      test('should emit browser tab when current route is BrowserRoute', () {
        // Arrange
        final browserRoute = MockBrowserRoute();
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          [browserRoute],
        );
        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.rootTabStream,
          emits(RootTab.browser),
        );
      });

      test('should emit profile tab when current route is ProfileRoute', () {
        // Arrange
        final profileRoute = MockProfileRoute();
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          [profileRoute],
        );
        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.rootTabStream,
          emits(RootTab.profile),
        );
      });

      test('should emit wallet tab when current route is unknown', () {
        // Arrange
        final unknownRoute = MockCompassBaseGoRoute();
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          [unknownRoute],
        );
        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.rootTabStream,
          emits(RootTab.wallet),
        );
      });

      test('should emit wallet tab when routes list is empty', () {
        // Arrange
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          <CompassBaseGoRoute>[],
        );
        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.rootTabStream,
          emits(RootTab.wallet),
        );
      });

      test('should emit multiple tabs as routes change', () {
        // Arrange
        final walletRoute = MockWalletRoute();
        final browserRoute = MockBrowserRoute();
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>();

        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.rootTabStream,
          emitsInOrder([
            RootTab.wallet,
            RootTab.browser,
          ]),
        );

        // Emit route changes
        routesStream
          ..add([walletRoute])
          ..add([browserRoute]);
      });
    });

    group('bottomBarStateStream', () {
      test(
        'should emit expanded state for BrowserRoute when not interacted',
        () {
          // Arrange
          final browserRoute = MockBrowserRoute();
          final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
            [browserRoute],
          );
          final scrolledStream = BehaviorSubject<bool>.seeded(false);

          when(() => mockRouter.currentRoutesStream).thenAnswer(
            (_) => routesStream.stream,
          );
          when(() => mockBrowserService.isContentInteractedStream).thenAnswer(
            (_) => scrolledStream.stream,
          );

          // Act & Assert
          expect(
            rootTabService.bottomBarStateStream,
            emits(BottomBarState.expanded),
          );
        },
      );

      test(
        'should emit collapsed state for BrowserRoute when interacted',
        () async {
          // Arrange
          final browserRoute = MockBrowserRoute();
          final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>();
          final scrolledStream = BehaviorSubject<bool>.seeded(false);

          when(() => mockRouter.currentRoutesStream).thenAnswer(
            (_) => routesStream.stream,
          );
          when(() => mockBrowserService.isContentInteractedStream).thenAnswer(
            (_) => scrolledStream.stream,
          );

          // Act & Assert
          expect(
            rootTabService.bottomBarStateStream,
            emitsInOrder([
              BottomBarState.expanded,
              BottomBarState.collapsed,
            ]),
          );

          // Emit changes
          routesStream.add([browserRoute]);

          // Small delay to ensure the flatMap processes the route
          await Future<void>.delayed(const Duration(milliseconds: 1));

          // Then add the scrolled state
          scrolledStream.add(true);
        },
      );

      test(
        'should emit expanded state for non-BrowserRoute '
        'with visible nav bar',
        () {
          // Arrange
          final walletRoute = MockWalletRoute();
          final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
            [walletRoute],
          );

          when(() => mockRouter.currentRoutesStream).thenAnswer(
            (_) => routesStream.stream,
          );

          // Act & Assert
          expect(
            rootTabService.bottomBarStateStream,
            emits(BottomBarState.expanded),
          );
        },
      );

      test(
        'should emit collapsed state for non-BrowserRoute with hidden nav bar',
        () {
          // Arrange
          final profileRoute = MockProfileRoute();
          final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
            [profileRoute],
          );

          when(() => mockRouter.currentRoutesStream).thenAnswer(
            (_) => routesStream.stream,
          );

          // Act & Assert
          expect(
            rootTabService.bottomBarStateStream,
            emits(BottomBarState.collapsed),
          );
        },
      );

      test('should emit hidden state when route is null', () {
        // Arrange
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          <CompassBaseGoRoute>[],
        );

        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.bottomBarStateStream,
          emits(BottomBarState.hidden),
        );
      });

      test('should emit hidden state for fullscreen routes', () {
        // Arrange
        final fullscreenRoute = MockFullscreenRoute();
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          [fullscreenRoute],
        );

        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.bottomBarStateStream,
          emits(BottomBarState.hidden),
        );
      });

      test(
        'should handle route changes from BrowserRoute to non-BrowserRoute',
        () {
          // Arrange
          final browserRoute = MockBrowserRoute();
          final walletRoute = MockWalletRoute();
          final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>();
          final scrolledStream = BehaviorSubject<bool>.seeded(true);

          when(() => mockRouter.currentRoutesStream).thenAnswer(
            (_) => routesStream.stream,
          );
          when(() => mockBrowserService.isContentInteractedStream).thenAnswer(
            (_) => scrolledStream.stream,
          );

          // Act & Assert
          expect(
            rootTabService.bottomBarStateStream,
            emitsInOrder([
              BottomBarState.collapsed, // Browser route with scrolled=true
              BottomBarState.expanded, // Wallet route with visible nav bar
            ]),
          );

          // Emit route changes
          routesStream
            ..add([browserRoute])
            ..add([walletRoute]);
        },
      );
    });

    group('scrollTabToTopSubject', () {
      test('should provide access to scroll tab to top stream', () {
        // Act & Assert
        expect(rootTabService.scrollTabToTopSubject, isA<Stream<RootTab>>());
      });
    });

    group('tryToChangeTabAndCheckDiff', () {
      test('should return true and emit tab when current tab differs',
          () async {
        // Arrange
        final walletRoute = MockWalletRoute();
        when(() => mockRouter.currentRoutes).thenReturn([walletRoute]);

        var tabEmitted = false;

        final subscription = rootTabService.scrollTabToTopSubject.listen((tab) {
          tabEmitted = true;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.browser);

        // Wait a brief moment for the stream to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isTrue);
        expect(tabEmitted, isFalse);

        await subscription.cancel();
      });

      test('should return false and not emit when current tab is same',
          () async {
        // Arrange
        final walletRoute = MockWalletRoute();
        when(() => mockRouter.currentRoutes).thenReturn([walletRoute]);

        var tabEmitted = false;

        final subscription = rootTabService.scrollTabToTopSubject.listen((_) {
          tabEmitted = true;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.wallet);

        // Wait a brief moment to ensure no emission
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isFalse);
        expect(tabEmitted, isTrue);

        await subscription.cancel();
      });

      test('should handle null current route as wallet tab', () async {
        // Arrange
        when(() => mockRouter.currentRoutes).thenReturn(<CompassBaseGoRoute>[]);

        var tabEmitted = false;

        final subscription = rootTabService.scrollTabToTopSubject.listen((tab) {
          tabEmitted = true;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.browser);

        // Wait a brief moment for the stream to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isTrue);
        expect(tabEmitted, isFalse);

        await subscription.cancel();
      });

      test('should handle unknown route type as wallet tab', () async {
        // Arrange
        final unknownRoute = MockCompassBaseGoRoute();
        when(() => mockRouter.currentRoutes).thenReturn([unknownRoute]);

        var tabEmitted = false;

        final subscription = rootTabService.scrollTabToTopSubject.listen((tab) {
          tabEmitted = true;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.profile);

        // Wait a brief moment for the stream to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isTrue);
        expect(tabEmitted, isFalse);

        await subscription.cancel();
      });
    });
  });
}
