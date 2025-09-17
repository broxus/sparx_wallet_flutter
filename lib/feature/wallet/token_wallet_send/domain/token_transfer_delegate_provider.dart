import 'package:app/feature/wallet/wallet.dart';
import 'package:app/http/repository/gasless_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
final class TokenTransferDelegateProvider {
  TokenTransferDelegateProvider(
    this._nekotonRepository,
    this._gaslessRepository,
    this._gaslessTokenTransferDelegate,
    this._basicTokenTransferDelegate,
  );

  final NekotonRepository _nekotonRepository;
  final GaslessRepository _gaslessRepository;
  final GaslessTokenTransferDelegate _gaslessTokenTransferDelegate;
  final BasicTokenTransferDelegate _basicTokenTransferDelegate;

  Future<TokenTransferDelegate> provide({
    required KeyAccount keyAccount,
    required Address rootTokenContract,
  }) async {
    final masterKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(keyAccount.publicKey)!
        .masterKey;

    if (!masterKey.isLedger &&
        keyAccount.account.tonWallet.contract ==
            const WalletType.walletV5R1()) {
      final config = await _gaslessRepository.getConfig();
      final isGaslessAvailable = config != null &&
          config.gasJettons
              .any((jetton) => jetton.masterId == rootTokenContract);

      if (isGaslessAvailable) return _gaslessTokenTransferDelegate;
    }

    return _basicTokenTransferDelegate;
  }
}
