import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@injectable
class BiometryScreenModel extends ElementaryModel {
  BiometryScreenModel(
    this._biometryService,
  );

  final BiometryService _biometryService;

  Future<bool> checkFaceBiometry() async {
    final types = await _biometryService.getAvailableBiometry();
    return types.contains(BiometricType.face);
  }

  Future<void> enableBiometry(String localizedReason) =>
      _biometryService.setStatus(
        localizedReason: localizedReason,
        isEnabled: true,
      );
}
