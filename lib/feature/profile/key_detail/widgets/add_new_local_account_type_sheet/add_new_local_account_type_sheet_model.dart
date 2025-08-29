import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class AddNewLocalAccountTypeSheetModel extends ElementaryModel {
  AddNewLocalAccountTypeSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

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
    required int workchain,
    String? name,
  }) =>
      key.accountList.addAccount(
        walletType: walletType,
        workchain: workchain,
        name: name,
      );

  void showMessage(Message message) => _messengerService.show(message);

  String defaultAccountName(WalletType type) =>
      _nekotonRepository.currentTransport.defaultAccountName(type);
}
