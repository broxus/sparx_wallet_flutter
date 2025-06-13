import 'package:app/app/service/app_version_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:the_logger/the_logger.dart';

@injectable
class LoggerConfigurator {
  LoggerConfigurator(
    this._appVersionService,
    this._nekotonRepository,
  );

  static const _devLogsRetainSessionCount = 100;
  static const _prodLogsRetainSessionCount = 50;

  final AppVersionService _appVersionService;
  final NekotonRepository _nekotonRepository;

  Future<void> configure(
    AppBuildType appBuildType,
  ) async {
    var retainStrategy = {Level.ALL: 100};

    /// This enables direct mobile logger (adb logcat / oslog)
    const mobileLogger = false;

    // /// Log levels depending on build type
    switch (appBuildType) {
      case AppBuildType.development:
        retainStrategy = {
          Level.ALL: _devLogsRetainSessionCount,
          Level.SEVERE: _devLogsRetainSessionCount,
        };
      case AppBuildType.staging:
        retainStrategy = {
          Level.ALL: _devLogsRetainSessionCount,
          Level.SEVERE: _devLogsRetainSessionCount,
        };
      case AppBuildType.production:
        retainStrategy = {
          Level.ALL: _prodLogsRetainSessionCount,
          Level.SEVERE: _prodLogsRetainSessionCount,
        };
    }

    final appVersion = await _appVersionService.appVersion();
    final buildNumber = await _appVersionService.buildNumber();

    final packageInfoString = '[$appVersion:$buildNumber]';

    final logger = TheLogger.i();
    await logger.init(
      retainStrategy: retainStrategy,
      sessionStartExtra: packageInfoString,
    );

    await _nekotonRepository.setupLogger(
      level: logger.minLevel,
      mobileLogger: mobileLogger,
    );
  }

  Future<void> startLogSession() async {
    try {
      await TheLogger.i().startSession();
    } catch (_) {}
  }
}
