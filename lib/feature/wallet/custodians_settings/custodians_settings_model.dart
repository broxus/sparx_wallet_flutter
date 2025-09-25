import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/custodians_settings/custodian_data.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class CustodiansSettingsModel extends ElementaryModel {
  CustodiansSettingsModel(
    ErrorHandler errorHandler,
    this._storageService,
    this._messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final AppStorageService _storageService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  Future<TonWalletState> getWallet(Address address) =>
      _nekotonRepository.getWallet(address);

  List<CustodianData> getCustodiansForAccount(TonWallet wallet) =>
      wallet.custodians
          ?.map(
            (key) => CustodianData(
              name: _storageService.getValue<String>(
                    StorageKey.nameCustodian(key.toString()),
                  ) ??
                  key.toEllipseString(),
              key: key,
            ),
          )
          .toList() ??
      [];

  void showSuccessfulMessage() {
    _messengerService.show(
      Message.successful(
        message: LocaleKeys.custodianRenamed.tr(),
      ),
    );
  }

  Future<void> rename(PublicKey key, String newName) async {
    _storageService.addValue(
      StorageKey.nameCustodian(key.publicKey),
      newName,
    );
  }
}
