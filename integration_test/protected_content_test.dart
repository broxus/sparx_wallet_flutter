import 'package:app/app/service/protected_content_service.dart';
import 'package:app/di/di.dart';
import 'package:app/widgets/protected_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProtectedContentService extends Mock
    implements ProtectedContentService {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockProtectedContentService mockService;

  setUp(() async {
    await getIt.reset();
    mockService = MockProtectedContentService();
    when(() => mockService.enableProtectedContent()).thenAnswer((_) async {});
    when(() => mockService.disableProtectedContent()).thenAnswer((_) async {});
    getIt.registerSingleton<ProtectedContentService>(mockService);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('ProtectedContent', () {
    testWidgets('calls enableProtectedContent on init', (tester) async {
      // Arrange
      const child = Text('secure');

      // Act
      await tester.pumpWidget(
        const MaterialApp(home: ProtectedContent(child: child)),
      );
      await tester.pumpAndSettle();

      // Assert
      verify(() => mockService.enableProtectedContent()).called(1);
      verifyNever(() => mockService.disableProtectedContent());
    });

    testWidgets('calls disableProtectedContent on dispose', (tester) async {
      // Arrange
      const protectedKey = ValueKey('protected');
      await tester.pumpWidget(
        const MaterialApp(
          home: ProtectedContent(key: protectedKey, child: Text('secure')),
        ),
      );
      await tester.pumpAndSettle();
      clearInteractions(mockService);

      // Act
      await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
      await tester.pumpAndSettle();

      // Assert
      verify(() => mockService.disableProtectedContent()).called(1);
      verifyNever(() => mockService.enableProtectedContent());
    });

    testWidgets('does not re-enable on rebuild of same state', (tester) async {
      // Arrange
      const protectedKey = ValueKey('protected');
      await tester.pumpWidget(
        const MaterialApp(
          home: ProtectedContent(key: protectedKey, child: Text('first')),
        ),
      );
      await tester.pumpAndSettle();
      clearInteractions(mockService);

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ProtectedContent(key: protectedKey, child: Text('second')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      verifyNever(() => mockService.enableProtectedContent());
      verifyNever(() => mockService.disableProtectedContent());
    });
  });
}
