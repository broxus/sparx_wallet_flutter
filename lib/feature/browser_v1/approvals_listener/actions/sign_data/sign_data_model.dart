import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';

class SignDataModel extends ElementaryModel with BleAvailabilityModelMixin {
  SignDataModel(
    ErrorHandler errorHandler,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;
}
