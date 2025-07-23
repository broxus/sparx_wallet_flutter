import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';

class SignDataModel extends LedgerBaseModel {
  SignDataModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    LedgerService ledgerService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );
}
