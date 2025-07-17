import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:elementary/elementary.dart';

class AddExistingWalletModel extends LedgerBaseModel {
  AddExistingWalletModel(
    ErrorHandler errorHandler,
    LedgerService ledgerService,
    MessengerService messengerService,
    AppPermissionsService permissionsService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );
}
