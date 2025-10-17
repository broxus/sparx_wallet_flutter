import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';

class AddExistingWalletModel extends ElementaryModel
    with BleAvailabilityModelMixin {
  AddExistingWalletModel(ErrorHandler errorHandler, this._delegate)
    : super(errorHandler: errorHandler);

  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;
}
