import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/domain/store_url_generator.dart';
import 'package:app/feature/update_version/domain/update_service.dart';
import 'package:elementary/elementary.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateVersionModel extends ElementaryModel {
  UpdateVersionModel(
    ErrorHandler errorHandler,
    this._updateService,
    this._storeUrlGenerator,
  ) : super(errorHandler: errorHandler);

  final UpdateService _updateService;
  final StoreUrlGenerator _storeUrlGenerator;
  final _logger = Logger('UpdateVersionModel');

  Stream<UpdateRequest?> get updateRequests => _updateService.updateRequests;

  Future<void> dismissWarning() async {
    await _updateService.dismissWarning();
  }

  /// Open the update URL in the app store
  Future<void> openAppStore() async {
    try {
      final storeUrl = await _storeUrlGenerator.storeUrl();
      final url = Uri.parse(storeUrl);
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e, s) {
      handleError(e, stackTrace: s);
      _logger.severe('Error launching URL', e, s);
    }
  }
}
