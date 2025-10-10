import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class WalletMultisigConfigModel extends ElementaryModel {
  WalletMultisigConfigModel(this._nekotonRepository, ErrorHandler errorHandler)
    : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  /// Validates the number of required confirmations
  bool validateRequireConfirmations(
    int requireConfirmations,
    int custodiansCount,
  ) {
    return requireConfirmations > 0 && requireConfirmations <= custodiansCount;
  }

  bool validateHours(int hours) {
    return hours > 0 && hours <= 24;
  }

  WalletType walletType(Address address) {
    return _nekotonRepository.seedList
            .findAccountByAddress(address)
            ?.account
            .tonWallet
            .contract ??
        const WalletType.multisig(MultisigType.multisig2_1);
  }

  bool validateConfig({
    required List<PublicKey> custodians,
    required int requireConfirmations,
    required int hours,
  }) {
    return validateRequireConfirmations(
          requireConfirmations,
          custodians.length,
        ) &&
        validateHours(hours);
  }
}
