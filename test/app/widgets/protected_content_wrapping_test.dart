import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/add_seed/check_seed_phrase/route.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/create_seed/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/feature/add_seed/import_wallet/route.dart';
import 'package:app/widgets/protected_content.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class _MockCompassBaseRoute extends Mock implements CompassBaseRoute {}

class _MockGoRouterState extends Mock implements GoRouterState {}

void main() {
  group('ProtectedContent wrappers', () {
    testWidgets('ImportWalletRoute builder wraps in ProtectedContent', (
      tester,
    ) async {
      // Arrange
      final route = ImportWalletRoute(_stubCompassRoute(), _stubCompassRoute());

      // Act
      final built = await _captureBuilderOutput(
        tester,
        (context) => route.builder!.call(
          context,
          route.createData(),
          _MockGoRouterState(),
        ),
      );

      // Assert
      expect(built, isA<ProtectedContent>());
    });

    testWidgets('EnterSeedPhraseRoute builder wraps in ProtectedContent', (
      tester,
    ) async {
      // Arrange
      final route = EnterSeedPhraseRoute(
        _stubCompassRoute(),
        _stubCompassRoute(),
      );
      const data = EnterSeedPhraseRouteData(
        isOnboarding: false,
        seedName: null,
      );

      // Act
      final built = await _captureBuilderOutput(
        tester,
        (context) => route.builder!.call(context, data, _MockGoRouterState()),
      );

      // Assert
      expect(built, isA<ProtectedContent>());
    });

    testWidgets(
      'CreateSeedOnboardingPasswordRoute builder wraps in ProtectedContent',
      (tester) async {
        // Arrange
        final route = CreateSeedOnboardingPasswordRoute(_stubCompassRoute());
        const data = CreateSeedOnboardingPasswordRouteData();

        // Act
        final built = await _captureBuilderOutput(
          tester,
          (context) => route.builder!.call(context, data, _MockGoRouterState()),
        );

        // Assert
        expect(built, isA<ProtectedContent>());
      },
    );

    testWidgets('CreateSeedPasswordRoute builder wraps in ProtectedContent', (
      tester,
    ) async {
      // Arrange
      final route = CreateSeedPasswordRoute();
      const data = CreateSeedPasswordRouteData(
        type: SeedAddType.create,
        name: 'name',
      );

      // Act
      final built = await _captureBuilderOutput(
        tester,
        (context) => route.builder!.call(context, data, _MockGoRouterState()),
      );

      // Assert
      expect(built, isA<ProtectedContent>());
    });

    testWidgets('CreateSeedRoute builder wraps in ProtectedContent', (
      tester,
    ) async {
      // Arrange
      final route = CreateSeedRoute(_stubCompassRoute(), _stubCompassRoute());
      const data = CreateSeedRouteData(seedName: 'name');

      // Act
      final built = await _captureBuilderOutput(
        tester,
        (context) => route.builder!.call(context, data, _MockGoRouterState()),
      );

      // Assert
      expect(built, isA<ProtectedContent>());
    });

    testWidgets('CheckSeedPhraseRoute builder wraps in ProtectedContent', (
      tester,
    ) async {
      // Arrange
      final route = CheckSeedPhraseRoute(_stubCompassRoute());
      final data = CheckSeedPhraseRouteData(
        seedPhrase: SecureString(iv: IV.fromLength(16), value: 'secret'),
        name: 'name',
      );

      // Act
      final built = await _captureBuilderOutput(
        tester,
        (context) => route.builder!.call(context, data, _MockGoRouterState()),
      );

      // Assert
      expect(built, isA<ProtectedContent>());
    });
  });
}

Future<Widget> _captureBuilderOutput(
  WidgetTester tester,
  Widget Function(BuildContext) builder,
) async {
  Widget? built;

  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) {
          built = builder(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return built!;
}

_MockCompassBaseRoute _stubCompassRoute() {
  final route = _MockCompassBaseRoute();
  when(
    () => route.route,
  ).thenReturn(GoRoute(path: '/dummy', builder: (_, __) => const SizedBox()));
  return route;
}
