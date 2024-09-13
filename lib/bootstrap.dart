import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/service.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum AppBuildType { development, staging, production }

class AppBlocObserver extends BlocObserver {
  final _log = Logger('AppBlocObserver');

  // TODO(nesquikm): Maybe this this is a good point to debug something bad?
  // @override
  // void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
  //   super.onChange(bloc, change);
  //   _log.fine('onChange(${bloc.runtimeType}, $change)');
  // }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _log.severe('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  Widget Function() builder,
  AppBuildType appBuildType,
) async {
  final log = Logger('bootstrap');

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await configureDi();
      await configureLocalization();

      await inject<BootstrapService>().init(appBuildType);

      await SentryWorker.instance.init(appBuildType);

      FlutterError.onError = (details) {
        log.severe(details.exceptionAsString(), details, details.stack);
        SentryWorker.instance.captureException(
          details.exception,
          stackTrace: details.stack,
        );
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        log.severe(null, error, stack);
        SentryWorker.instance.captureException(error, stackTrace: stack);
        return true;
      };

      Bloc.observer = AppBlocObserver();

      DefaultAppBar.defaultPopAction =
          (context) => context.maybePop(preserveQueryParams: false);
      DefaultAppBar.defaultCanPopAction = (context) => context.canPop();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      runApp(
        EasyLocalization(
          supportedLocales: supportedLocales,
          path: 'assets/translations',
          fallbackLocale: fallbackLocale,
          useOnlyLangCode: true,
          child: ScreenUtilWrapper(
            child: AppWrapper(
              builder: builder,
            ),
          ),
        ),
      );
    },
    (error, stackTrace) async {
      log.severe(error.toString(), error, stackTrace);
      SentryWorker.instance.captureException(error, stackTrace: stackTrace);
    },
  );
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({required this.builder, super.key});

  final Widget Function() builder;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );

    appStartSession(setCrashDetected: true);
    // put it here so system faceid check window will appear after splashscreen
    _checkBiometry();
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        startLogSession();
        appStartSession(setCrashDetected: false);
      case AppLifecycleState.inactive:
        appStopSession();
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }

    inject<AppLifecycleService>().updateState(state);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    inject<LocalizationService>().refreshLocale();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }

  Future<void> _checkBiometry() async {
    final biometryService = inject<BiometryService>();
    final location = inject<NavigationService>().savedState.location;
    final canUpdateStatus = await biometryService.canUpdateStatus();

    if (canUpdateStatus && location == AppRoute.profile.path) {
      await biometryService.setStatus(
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
        isEnabled: true,
      );
    }
  }
}

class ScreenUtilWrapper extends StatelessWidget {
  const ScreenUtilWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: child,
    );
  }
}
