import 'package:app/widgets/widgets.dart';
import 'package:clock/clock.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('TransactionExpirationCountdown', () {
    testWidgets('renders formatted countdown and updates when value changes', (
      tester,
    ) async {
      // Arrange
      final initialTime = DateTime(2026);
      var currentTime = initialTime;

      await withClock(Clock(() => currentTime), () async {
        await _prepareLocalization(tester);

        // Act
        await _pumpCountdown(
          tester,
          expireAt: currentTime.add(
            const Duration(hours: 2, minutes: 5, seconds: 30),
          ),
        );

        // Assert
        expect(find.text('Expires in 2 h 5 min'), findsOneWidget);

        // Arrange
        currentTime = initialTime.add(const Duration(days: 1));

        // Act
        await _pumpCountdown(
          tester,
          expireAt: currentTime.subtract(const Duration(seconds: 1)),
        );

        // Assert
        expect(find.text('Expired'), findsOneWidget);
        expect(find.textContaining('Expires in'), findsNothing);

        // Arrange
        final lessThanMinuteStart = initialTime.add(const Duration(days: 2));
        currentTime = lessThanMinuteStart;
        final lessThanMinuteExpireAt = lessThanMinuteStart.add(
          const Duration(seconds: 45),
        );

        // Act
        await _pumpCountdown(tester, expireAt: lessThanMinuteExpireAt);

        // Assert
        expect(find.text('Expires in < 1 min'), findsOneWidget);

        // Act
        currentTime = lessThanMinuteStart.add(const Duration(seconds: 44));
        await tester.pump(const Duration(seconds: 44));

        // Assert
        expect(find.text('Expires in < 1 min'), findsOneWidget);

        // Act
        currentTime = lessThanMinuteStart.add(const Duration(seconds: 45));
        await tester.pump(const Duration(seconds: 1));

        // Assert
        expect(find.text('Expired'), findsOneWidget);

        // Arrange
        final minuteBoundaryStart = initialTime.add(const Duration(days: 3));
        currentTime = minuteBoundaryStart;
        final minuteBoundaryExpireAt = minuteBoundaryStart.add(
          const Duration(minutes: 5, seconds: 30),
        );

        // Act
        await _pumpCountdown(tester, expireAt: minuteBoundaryExpireAt);

        // Assert
        expect(find.text('Expires in 5 min'), findsOneWidget);

        // Act
        currentTime = minuteBoundaryStart.add(const Duration(seconds: 30));
        await tester.pump(const Duration(seconds: 30));

        // Assert
        expect(find.text('Expires in 5 min'), findsOneWidget);

        // Act
        currentTime = minuteBoundaryStart.add(const Duration(seconds: 31));
        await tester.pump(const Duration(seconds: 1));

        // Assert
        expect(find.text('Expires in 4 min'), findsOneWidget);

        // Arrange
        final updateStart = initialTime.add(const Duration(days: 4));
        currentTime = updateStart;
        final initialExpireAt = updateStart.add(const Duration(minutes: 10));
        final updatedExpireAt = updateStart.add(const Duration(hours: 1));

        // Act
        await _pumpCountdown(tester, expireAt: initialExpireAt);
        await _pumpCountdown(tester, expireAt: updatedExpireAt);

        // Assert
        expect(find.text('Expires in 1 h'), findsOneWidget);
        expect(find.text('Expires in 10 min'), findsNothing);

        await _disposeCountdown(tester);
      });
    });
  });
}

Future<void> _prepareLocalization(WidgetTester tester) async {
  await _pumpLocalizedApp(tester, const SizedBox.shrink());
  await tester.pumpAndSettle();
}

Future<void> _pumpCountdown(
  WidgetTester tester, {
  required DateTime expireAt,
}) async {
  await _pumpLocalizedApp(
    tester,
    TransactionExpirationCountdown(expireAt: expireAt),
  );
  await tester.pump();
}

Future<void> _pumpLocalizedApp(WidgetTester tester, Widget body) async {
  const locale = Locale('en');

  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [locale],
      path: 'assets/translations',
      fallbackLocale: locale,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, __) => Builder(
          builder: (easyContext) => MaterialApp(
            locale: locale,
            localizationsDelegates: easyContext.localizationDelegates,
            supportedLocales: easyContext.supportedLocales,
            theme: ThemeData(extensions: [getDefaultTheme()]),
            home: Scaffold(body: body),
          ),
        ),
      ),
    ),
  );
}

Future<void> _disposeCountdown(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpAndSettle();
}
