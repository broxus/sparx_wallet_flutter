import 'package:app/di/di.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class _MockErrorHandler extends Mock implements ErrorHandler {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationService localizationService;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() async {
    await getIt.reset();
    localizationService = LocalizationService();

    getIt
      ..registerSingleton<LocalizationService>(localizationService)
      ..registerFactory<LocalizationSheetModel>(
        () => LocalizationSheetModel(_MockErrorHandler(), localizationService),
      )
      ..registerFactory<LocalizationSheetWidgetModel>(
        () => LocalizationSheetWidgetModel(getIt<LocalizationSheetModel>()),
      );
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets(
    'showLocalizationSheet scrolls to the last locale on a small screen',
    (tester) async {
      // Arrange
      tester.view
        ..physicalSize = const Size(320, 568)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpSheetLauncher(tester);

      // Act
      await tester.tap(find.byKey(const ValueKey('open-localization-sheet')));
      await tester.pumpAndSettle();

      final chineseLocaleTitle = LocaleKeys.langChinese.tr();
      final scrollable = find.byType(Scrollable);

      await tester.scrollUntilVisible(
        find.text(chineseLocaleTitle),
        200,
        scrollable: scrollable,
      );
      await tester.pumpAndSettle();

      // Assert
      expect(scrollable, findsOneWidget);
      expect(find.text(chineseLocaleTitle), findsOneWidget);
    },
  );
}

Future<void> _pumpSheetLauncher(WidgetTester tester) async {
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
            home: Scaffold(
              body: Center(
                child: Builder(
                  builder: (context) => ElevatedButton(
                    key: const ValueKey('open-localization-sheet'),
                    onPressed: () => showLocalizationSheet(context: context),
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();
}
