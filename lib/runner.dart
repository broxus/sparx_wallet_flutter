import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/bootstrap/configurators/localization.dart';
import 'package:app/app/service/bootstrap/configurators/logger.dart';
import 'package:app/app/view/app.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/core/sentry.dart';
import 'package:app/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rive/rive.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

late AppBuildType currentAppBuildType;

Future<void> run(AppBuildType appBuildType) async {
  currentAppBuildType = appBuildType;

  Logger? log;

  void severe(String? msg, Object? e, StackTrace? s) {
    log?.severe(msg, e, s);
    if (log == null) {
      debugPrint('bootstrap error: $e');
      debugPrintStack(stackTrace: s, label: 'bootstrap stackTrace:');
    }
  }

  await runZonedGuarded(
    () async {
      SentryWidgetsFlutterBinding.ensureInitialized();

      await NekotonBridge.init();
      await RiveNative.init();

      await configureDi();

      await inject<LoggerConfigurator>().configure(appBuildType);

      log = Logger('bootstrap');

      await SentryWorker.instance.init(
        appBuildType: appBuildType,
        nekotonRepository: inject(),
        generalStorageService: inject(),
        runApp: () async {
          final originalFlutterOnError = FlutterError.onError;
          final originalDefaultOnError = PlatformDispatcher.instance.onError;

          FlutterError.onError = (details) {
            severe(
              details.exceptionAsString(),
              details,
              details.stack ?? StackTrace.current,
            );
            originalFlutterOnError?.call(details);
          };

          PlatformDispatcher.instance.onError = (error, stack) {
            severe(null, error, stack);
            return originalDefaultOnError?.call(error, stack) ?? false;
          };

          await inject<LocalizationConfigurator>().configure();

          DefaultAppBar.defaultPopAction = (context) => context.compassBack();
          DefaultAppBar.defaultCanPopAction = (context) => context.canPop();

          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.transparent,
            ),
          );

          final imagePickerImplementation = ImagePickerPlatform.instance;
          if (imagePickerImplementation is ImagePickerAndroid) {
            imagePickerImplementation.useAndroidPhotoPicker = true;
          }

          runApp(const App());
        },
      );
    },
    (error, stackTrace) async {
      severe(error.toString(), error, stackTrace);
      SentryWorker.instance.captureException(error, stackTrace: stackTrace);
    },
  );
}
