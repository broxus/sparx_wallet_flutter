import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class AddNewLocalAccountTypeSheetModel extends ElementaryModel {
  AddNewLocalAccountTypeSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._connectionsStorageService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final ConnectionsStorageService _connectionsStorageService;

  SeedKey? findSeedKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedKey(publicKey);

  List<WalletType> get availableWalletTypes => List<WalletType>.from(
    _nekotonRepository.currentTransport.availableWalletTypes,
  );

  WalletType get defaultWalletType =>
      _nekotonRepository.currentTransport.defaultWalletType;

  List<WalletType> getCreatedAccountTypes(SeedKey key) =>
      key.createdAccountTypes;

  Future<Address> addAccount({
    required SeedKey key,
    required WalletType walletType,
    String? name,
  }) {
    final currentWorkchainId = _connectionsStorageService.currentWorkchainId;

    if (currentWorkchainId == null) {
      throw Exception(LocaleKeys.addAccountError.tr());
    }

    return key.accountList.addAccount(
      walletType: walletType,
      workchain: currentWorkchainId,
      name: name,
    );
  }

  void showMessage(Message message) => _messengerService.show(message);

  String defaultAccountName(WalletType type) =>
      _nekotonRepository.currentTransport.defaultAccountName(type);
}
