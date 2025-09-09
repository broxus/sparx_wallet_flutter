import 'package:app/app/router/router.dart';
import 'package:app/app/service/crash_detector/widget/crash_detector_widget.dart';
import 'package:app/app/service/localization/service/supported_locale_codes.dart';
import 'package:app/app/service/localization/widget/localization_service_widget.dart';
import 'package:app/app/view/app_wm.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class App extends InjectedElementaryWidget<AppWidgetModel> {
  const App({
    super.key,
  });

  @override
  Widget build(AppWidgetModel wm) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: fallbackLocale,
      useOnlyLangCode: true,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: _AppContent(
          router: wm.router,
          checkCrashDetected: wm.checkCrashDetected,
        ),
      ),
    );
  }
}

class _AppContent extends StatelessWidget {
  const _AppContent({
    required this.router,
    required this.checkCrashDetected,
  });

  final CompassRouter router;
  final Future<bool> Function() checkCrashDetected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // ignore: deprecated_member_use_from_same_package
      routerConfig: router.router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getPredefinedLightTheme(),
      darkTheme: getPredefinedDarkTheme(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: CompassRouterProvider(
          router: router,
          child: InAppNotification(
            child: CrashDetectorWidget(
              checkCrashDetected: checkCrashDetected,
              child: LocalizationServiceWidget(
                child: child ?? Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
