import 'package:app/core/sentry.dart';
import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/domain/store_url_generator.dart';
import 'package:app/feature/update_version/domain/update_service.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class UpdateVersionModel extends ElementaryModel {
  UpdateVersionModel(
    ErrorHandler errorHandler,
    this._updateService,
    this._storeUrlGenerator,
    this._sentry,
  ) : super(errorHandler: errorHandler);

  final UpdateService _updateService;
  final StoreUrlGenerator _storeUrlGenerator;
  final SentryWorker _sentry;

  final _logger = Logger('UpdateVersionModel');

  ValueStream<UpdateRequest?> get updateRequests =>
      _updateService.updateRequests;

  Future<String> get storeUrl => _storeUrlGenerator.storeUrl();

  bool get isCloseAvailable =>
      updateRequests.value?.status != UpdateStatus.blocking;

  void dismissWarning() {
    _updateService.dismissWarning();
  }

  /// Open the update URL in the app store
  Future<void> openAppStore() async {
    try {
      final isInAppFlowSuccess = await _inAppUpdateFlow();
      if (!isInAppFlowSuccess) {
        final storeUrl = await _storeUrlGenerator.storeUrl();
        final url = Uri.parse(storeUrl);
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e, s) {
      handleError(e, stackTrace: s);

      _sentry.captureException(e, stackTrace: s);
    }

    dismissWarning();
  }

  Future<bool> _inAppUpdateFlow() async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability ==
          UpdateAvailability.updateNotAvailable) {
        _logger.warning('In app update not available $updateInfo');
        return false;
      }

      if (!updateInfo.immediateUpdateAllowed) {
        _logger.warning('In app update not available $updateInfo');
        return false;
      }

      final immediateUpdateStatus = await InAppUpdate.performImmediateUpdate();

      if (immediateUpdateStatus == AppUpdateResult.inAppUpdateFailed) {
        _logger.warning('In app update failed  $updateInfo');
        return false;
      }

      _logger.info('In app update finised $updateInfo');
      return true;
    } catch (e, s) {
      _logger.severe('Error catch during in app update', e, s);
      _sentry.captureException(e, stackTrace: s);

      return false;
    }
  }
}
