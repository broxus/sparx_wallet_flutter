import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

/// Model for wallet account actions, handles business logic
@injectable
class WalletAccountActionsModel extends ElementaryModel {
  WalletAccountActionsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._stakingService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final StakingService _stakingService;

  bool get hasStake =>
      _nekotonRepository.currentTransport.stakeInformation != null;

  String get nativeTokenTicker =>
      _nekotonRepository.currentTransport.nativeTokenTicker;

  Address get nativeTokenAddress =>
      _nekotonRepository.currentTransport.nativeTokenAddress;

  Stream<TonWallet> getWalletStateStream(Address address) => _nekotonRepository
      .walletsMapStream
      .mapNotNull((wallets) => wallets[address]?.wallet);

  Stream<List<StEverWithdrawRequest>> getWithdrawRequestsStream(
    Address address,
  ) => _stakingService.withdrawRequestsStream(address);

  Future<List<PublicKey>?> getLocalCustodians(Address address) async {
    try {
      return await _nekotonRepository.getLocalCustodians(address);
    } catch (_) {
      return null;
    }
  }

  Future<UnsignedMessage> prepareDeploy(Address address) =>
      _nekotonRepository.prepareDeploy(address, defaultSendTimeout);

  Future<BigInt> estimateDeploymentFees({
    required Address address,
    required UnsignedMessage message,
  }) => _nekotonRepository.estimateDeploymentFees(
    address: address,
    message: message,
  );

  void showError(Object data) => handleError(data);
}
