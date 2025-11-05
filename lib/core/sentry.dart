import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@module
abstract class SentryModule {
  @lazySingleton
  SentryWorker getSentryWorker() {
    return SentryWorker.instance;
  }
}

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
  NekotonRepository? _nekotonRepository;
  GeneralStorageService? _generalStorageService;

  /// If dev build type - don't use sentry
  bool get _isUseSentry => _appBuildType != AppBuildType.development;

  Future<void> init({
    required AppBuildType appBuildType,
    required NekotonRepository nekotonRepository,
    required GeneralStorageService generalStorageService,
  }) async {
    _appBuildType = appBuildType;
    _nekotonRepository = nekotonRepository;
    _generalStorageService = generalStorageService;

    if (!_isUseSentry) {
      _logger.info(
        'Sentry is not used in the ${_appBuildType?.name} build type',
      );
      return;
    }

    return SentryFlutter.init((options) {
      options
        ..dsn = dsnDefineEnv
        ..tracesSampleRate = 1
        ..ignoreErrors = [
          'AnyhowException(Account not exists)',
          'AnyhowException(Network error)',
        ]
        ..beforeSend = (event, hint) {
          final error = event.throwable.toString();
          if (error == 'AnyhowException(Account not exists)' ||
              error == 'AnyhowException(Network error)') {
            return null; // Ignore these errors
          }

          return event;
        };
    });
  }

  void captureException(dynamic exception, {dynamic stackTrace}) {
    if (!_isUseSentry) {
      return;
    }
    Sentry.captureException(exception, stackTrace: stackTrace);
  }

  void configureScope() {
    if (_nekotonRepository == null || _generalStorageService == null) return;

    Rx.combineLatest3(
          _nekotonRepository!.currentTransportStream,
          _nekotonRepository!.accountsStorage.accountsStream,
          _generalStorageService!.currentAddressStream,
          (transport, accounts, address) => (transport, accounts, address),
        )
        .map((event) {
          final (transport, accounts, address) = event;
          final account = accounts.firstWhereOrNull(
            (it) => it.address == address,
          );
          return (transport, account);
        })
        .listen((event) {
          final (transport, account) = event;
          Sentry.configureScope((scope) {
            scope
              ..setUser(
                account?.let(
                  (it) =>
                      SentryUser(id: it.address.toString(), data: it.toJson()),
                ),
              )
              ..setContexts('network', transport.networkName);
          });
        });
  }
}
