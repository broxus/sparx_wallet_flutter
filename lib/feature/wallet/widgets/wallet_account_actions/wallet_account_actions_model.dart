import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
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
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final StakingService _stakingService;
  final MessengerService _messengerService;

  bool get hasStake =>
      _nekotonRepository.currentTransport.stakeInformation != null;

  String get nativeTokenTicker =>
      _nekotonRepository.currentTransport.nativeTokenTicker;

  Address get nativeTokenAddress =>
      _nekotonRepository.currentTransport.nativeTokenAddress;

  Stream<TonWallet> getWalletStateStream(Address address) =>
      _nekotonRepository.walletsMapStream.mapNotNull(
        (wallets) => wallets[address]?.wallet,
      );

  Stream<List<StEverWithdrawRequest>> getWithdrawRequestsStream(
    Address address,
  ) =>
      _stakingService.withdrawRequestsStream(address);

  Future<List<PublicKey>?> getLocalCustodians(Address address) =>
      _nekotonRepository.getLocalCustodians(address);

  Future<UnsignedMessage> prepareDeploy(Address address) =>
      _nekotonRepository.prepareDeploy(address, defaultSendTimeout);

  Future<BigInt> estimateDeploymentFees({
    required Address address,
    required UnsignedMessage message,
  }) =>
      _nekotonRepository.estimateDeploymentFees(
        address: address,
        message: message,
      );

  void showMessage(Message message) => _messengerService.show(message);
}
