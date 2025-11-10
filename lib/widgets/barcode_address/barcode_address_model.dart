import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/barcode_address/barcode_address.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [BarcodeAddress]
@injectable
class BarcodeAddressModel extends ElementaryModel {
  BarcodeAddressModel(ErrorHandler errorHandler, this._messengerService)
    : super(errorHandler: errorHandler);

  final MessengerService _messengerService;

  void showSuccess(Address address) {
    setClipBoardData(address.address);
    _messengerService.show(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [address.toEllipseString()],
        ),
      ),
    );
  }
}
