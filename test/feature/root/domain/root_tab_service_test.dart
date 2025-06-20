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
  bool get isBottomNavigationBarVisible => true;
}

class MockBrowserRoute extends Mock implements BrowserRoute {
  @override
  bool get isBottomNavigationBarVisible => true;

  @override
  Type get runtimeType => BrowserRoute;
}

class MockProfileRoute extends Mock implements ProfileRoute {
  @override
  bool get isBottomNavigationBarVisible => false;

  @override
  Type get runtimeType => ProfileRoute;
}

class MockCompassBaseGoRoute extends Mock
    implements CompassBaseGoRoute<CompassRouteData> {
  @override
  bool get isBottomNavigationBarVisible => false;
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

    group('isBottomBarVisibleStream', () {
      test(
        'should emit browser service scrolled state for BrowserRoute',
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
            rootTabService.isBottomBarVisibleStream,
            emits(true), // !false = true
          );
        },
      );

      test(
        'should emit inverted browser scrolled state for BrowserRoute',
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
            rootTabService.isBottomBarVisibleStream,
            emitsInOrder([
              true,
              false,
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
        'should emit route visibility for non-BrowserRoute '
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
            rootTabService.isBottomBarVisibleStream,
            emits(true),
          );
        },
      );

      test(
        'should emit route visibility for non-BrowserRoute with hidden nav bar',
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
            rootTabService.isBottomBarVisibleStream,
            emits(false),
          );
        },
      );

      test('should emit false when route is null', () {
        // Arrange
        final routesStream = BehaviorSubject<List<CompassBaseGoRoute>>.seeded(
          <CompassBaseGoRoute>[],
        );

        when(() => mockRouter.currentRoutesStream).thenAnswer(
          (_) => routesStream.stream,
        );

        // Act & Assert
        expect(
          rootTabService.isBottomBarVisibleStream,
          emits(false),
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
            rootTabService.isBottomBarVisibleStream,
            emitsInOrder([
              false, // Browser route with scrolled=true -> !true = false
              true, // Wallet route with visible nav bar
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
        RootTab? emittedTab;

        final subscription = rootTabService.scrollTabToTopSubject.listen((tab) {
          tabEmitted = true;
          emittedTab = tab;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.browser);

        // Wait a brief moment for the stream to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isTrue);
        expect(tabEmitted, isTrue);
        expect(emittedTab, equals(RootTab.browser));

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
        expect(tabEmitted, isFalse);

        await subscription.cancel();
      });

      test('should handle null current route as wallet tab', () async {
        // Arrange
        when(() => mockRouter.currentRoutes).thenReturn(<CompassBaseGoRoute>[]);

        var tabEmitted = false;
        RootTab? emittedTab;

        final subscription = rootTabService.scrollTabToTopSubject.listen((tab) {
          tabEmitted = true;
          emittedTab = tab;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.browser);

        // Wait a brief moment for the stream to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isTrue);
        expect(tabEmitted, isTrue);
        expect(emittedTab, equals(RootTab.browser));

        await subscription.cancel();
      });

      test('should handle unknown route type as wallet tab', () async {
        // Arrange
        final unknownRoute = MockCompassBaseGoRoute();
        when(() => mockRouter.currentRoutes).thenReturn([unknownRoute]);

        var tabEmitted = false;
        RootTab? emittedTab;

        final subscription = rootTabService.scrollTabToTopSubject.listen((tab) {
          tabEmitted = true;
          emittedTab = tab;
        });

        // Act
        final result =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.profile);

        // Wait a brief moment for the stream to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result, isTrue);
        expect(tabEmitted, isTrue);
        expect(emittedTab, equals(RootTab.profile));

        await subscription.cancel();
      });

      test('should work correctly with multiple consecutive calls', () async {
        // Arrange
        final walletRoute = MockWalletRoute();
        when(() => mockRouter.currentRoutes).thenReturn([walletRoute]);

        final emittedTabs = <RootTab>[];

        final subscription =
            rootTabService.scrollTabToTopSubject.listen(emittedTabs.add);

        // Act
        final result1 =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.browser);
        final result2 =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.browser);
        final result3 =
            rootTabService.tryToChangeTabAndCheckDiff(RootTab.profile);

        // Wait a brief moment for all streams to emit
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(result1, isTrue); // wallet -> browser (different)
        expect(
          result2,
          isTrue,
        ); // wallet -> browser (still different, method doesn't track state)
        expect(result3, isTrue); // wallet -> profile (different)
        expect(
          emittedTabs,
          equals([RootTab.browser, RootTab.browser, RootTab.profile]),
        );

        await subscription.cancel();
      });
    });
  });
}
