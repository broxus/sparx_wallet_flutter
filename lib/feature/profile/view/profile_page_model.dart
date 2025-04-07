import 'package:app/app/service/app_version_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ProfilePageModel extends ElementaryModel {
  ProfilePageModel(
    ErrorHandler errorHandler,
    this._currentSeedService,
    this._biometryService,
    this._sessionService,
    this._appVersionService,
  ) : super(errorHandler: errorHandler);

  final CurrentSeedService _currentSeedService;
  final BiometryService _biometryService;
  final SessionService _sessionService;
  final AppVersionService _appVersionService;

  Future<String> get appVersion async {
    final appVersion = await _appVersionService.appVersion();
    final buildNumber = await _appVersionService.buildNumber();
    return '$appVersion.$buildNumber';
  }

  Stream<Seed?> get currentSeedStream => _currentSeedService.currentSeedStream;

  Stream<bool> get biometryAvailabilityStream =>
      _biometryService.availabilityStream;

  Stream<bool> get biometryEnabledStream => _biometryService.enabledStream;

  Future<void> logout() async {
    await _sessionService.clear();
  }

  Future<void> setBiometryEnabled({required bool enabled}) async {
    if (enabled && !await _biometryService.checkBiometryPermission()) return;

    await _biometryService.setStatus(
      localizedReason: LocaleKeys.biometryAuthReason.tr(),
      isEnabled: enabled,
    );
  }
}
