import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AddAccountModel extends LedgerBaseModel {
  AddAccountModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    LedgerService ledgerService,
    this._nekotonRepository,
    this._currentSeedService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final NekotonRepository _nekotonRepository;
  final CurrentSeedService _currentSeedService;

  Stream<List<Seed>> get seedWithAccounts =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.seeds,
      );

  Stream<Seed?> get currentAccount => _currentSeedService.currentSeedStream;
}
