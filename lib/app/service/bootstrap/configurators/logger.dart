import 'package:app/app/service/app_version_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:the_logger/the_logger.dart';

@injectable
class LoggerConfigurator {
  LoggerConfigurator(this._appVersionService, this._nekotonRepository);

  static const _devLogsRetainSessionCount = 100;
  static const _prodLogsRetainSessionCount = 50;

  final AppVersionService _appVersionService;
  final NekotonRepository _nekotonRepository;

  Future<void> configure(AppBuildType appBuildType) async {
    /// This enables direct mobile logger (adb logcat / oslog)
    const mobileLogger = false;

    // /// Log levels depending on build type
    final retainStrategy = switch (appBuildType) {
      AppBuildType.development => {
        Level.ALL: _devLogsRetainSessionCount,
        Level.SEVERE: _devLogsRetainSessionCount,
      },
      AppBuildType.staging => {
        Level.ALL: _devLogsRetainSessionCount,
        Level.SEVERE: _devLogsRetainSessionCount,
      },
      AppBuildType.production => {
        Level.ALL: _prodLogsRetainSessionCount,
        Level.SEVERE: _prodLogsRetainSessionCount,
      },
    };

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
