import 'package:app/feature/profile/view/profile_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class _SimpleListenableState<T> extends ValueNotifier<T>
    implements ListenableState<T> {
  _SimpleListenableState(super.value);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets(
    'renders settings rows in Chinese on a small screen without overflow',
    (tester) async {
      // Arrange
      tester.view
        ..physicalSize = const Size(320, 568)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('zh')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          startLocale: const Locale('zh'),
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (_, __) => Builder(
              builder: (easyContext) => MaterialApp(
                locale: easyContext.locale,
                localizationsDelegates: easyContext.localizationDelegates,
                supportedLocales: easyContext.supportedLocales,
                theme: ThemeData(extensions: [getDefaultTheme()]),
                home: Scaffold(
                  body: ProfileView(
                    appVersion: '2.4.2.1',
                    isBiometryAvailable: _SimpleListenableState(false),
                    isBiometryEnabled: _SimpleListenableState(false),
                    seed: _SimpleListenableState<Seed?>(null),
                    onManageSeeds: () {},
                    onExportSeed: () {},
                    onContactSupport: () {},
                    onChangeLanguage: () {},
                    onFAQ: () {},
                    onLegal: () {},
                    onLogout: () {},
                    onBiomentryChanged: (_) {},
                    onManageDapps: () {},
                    onClearStorage: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();
      final exception = tester.takeException();

      // Assert
      expect(exception, isNull);
      expect(find.text('连接的 dApp'), findsOneWidget);
      expect(find.text('仅适用于 TON'), findsOneWidget);
    },
  );
}
