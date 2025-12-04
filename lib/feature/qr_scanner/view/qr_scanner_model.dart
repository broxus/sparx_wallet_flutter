import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;

@injectable
class QrScannerModel extends ElementaryModel {
  QrScannerModel(
    ErrorHandler errorHandler,
    this._permissionsService,
    this._lifecycleService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final AppPermissionsService _permissionsService;
  final AppLifecycleService _lifecycleService;
  final MessengerService _messengerService;

  Stream<AppLifecycleState> get appLifecycleStateStream =>
      _lifecycleService.appLifecycleStateStream;

  QrScanResult tryGetResult({
    required String value,
    required List<QrScanType> types,
  }) {
    for (final type in types) {
      switch (type) {
        case QrScanType.address:
          final address = Address(address: value);
          if (address.isValid) {
            return QrScanResult.address(address);
          }

        case QrScanType.uri:
          final uri = Uri.tryParse(value);
          if (uri != null && uri.hasScheme) {
            return QrScanResult.uri(uri);
          }
      }
    }

    return const QrScanResult.invalid();
  }

  Future<bool> requestPhotos() => _permissionsService.requestPhotos();

  Future<bool> requestCamera() => _permissionsService.requestCamera();

  Future<void> openSettings() => _permissionsService.openSettings();

  void showMessage(Message message) => _messengerService.show(message);
}
