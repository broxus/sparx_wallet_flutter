import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/app/service/storage_service/storage_manager_service.dart';
import 'package:app/core/sentry.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Service that helps watching app lifecycle state.
@singleton
class SessionService {
  SessionService(
    this._nekotonRepository,
    this._storageManagerService,
    this._secureStorageService,
    this._identifyIconsService,
    this._browserService,
  );

  final NekotonRepository _nekotonRepository;
  final StorageManagerService _storageManagerService;
  final SecureStorageService _secureStorageService;
  final IIdentifyIconsService _identifyIconsService;
  final BrowserService _browserService;

  final _sentry = SentryWorker.instance;

  final _log = Logger('SessionService');

  Future<void> clear() async {
    await tryWrapper(
      () => _nekotonRepository.updateSubscriptions([]),
      onCatch: _captureException,
    );

    await tryWrapper(
      () => _nekotonRepository.updateTokenSubscriptions([]),
      onCatch: _captureException,
    );

    await tryWrapper(_storageManagerService.clear, onCatch: _captureException);

    await tryWrapper(
      _nekotonRepository.keyStore.reloadKeystore,
      onCatch: _captureException,
    );

    await tryWrapper(_identifyIconsService.clear, onCatch: _captureException);

    await tryWrapper(_secureStorageService.clear, onCatch: _captureException);

    await tryWrapper(_browserService.clear, onCatch: _captureException);
  }

  Future<void> _captureException(Object e, StackTrace s) async {
    _log.severe('SessionService captureException', e, s);
    _sentry.captureException(e, stackTrace: s);
  }
}
