import 'package:app/app/service/service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/utils/utils.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryWorker {
  /// > Singleton
  factory SentryWorker() {
    return instance;
  }

  SentryWorker._();

  static final SentryWorker instance = SentryWorker._();

  /// < Singleton

  final _logger = Logger('Sentry');

  AppBuildType? _appBuildType;

  /// If dev build type - don't use sentry
  bool get _isUseSentry => _appBuildType != AppBuildType.development;

  Future<void> init({
    required AppBuildType appBuildType,
    required NekotonRepository nekotonRepository,
    required GeneralStorageService generalStorageService,
  }) async {
    _appBuildType = appBuildType;

    if (!_isUseSentry) {
      _logger.info(
        'Sentry is not used in the ${_appBuildType?.name} build type',
      );
      return;
    }

    Rx.combineLatest2(
      nekotonRepository.currentTransportStream,
      generalStorageService.currentAddressStream,
      (transport, address) => (transport, address),
    ).listen((event) {
      final (transport, address) = event;
      Sentry.configureScope((scope) {
        scope
          ..setUser(address?.let((it) => SentryUser(id: it.toString())))
          ..setContexts('network', transport.networkName);
      });
    });

    return SentryFlutter.init(
      (options) {
        options
          ..dsn = dsnDefineEnv
          ..tracesSampleRate = 1
          ..ignoreErrors = [
            'AnyhowException(Account not exists)',
            'AnyhowException(Network error)',
          ];
      },
    );
  }

  void captureException(
    dynamic exception, {
    dynamic stackTrace,
  }) {
    if (!_isUseSentry) {
      return;
    }
    Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
