import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class AccountCardModel extends ElementaryModel {
  AccountCardModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._balanceService,
    this._currencyConvertService,
    this._balanceStorage,
    this._messengerService,
    this._stakingService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final BalanceService _balanceService;
  final CurrencyConvertService _currencyConvertService;
  final BalanceStorageService _balanceStorage;
  final MessengerService _messengerService;
  final StakingService _stakingService;

  Stream<Money> getBalanceStream(Address address) {
    return _nekotonRepository.currentTransportStream.switchMap(
      (transport) => _balanceService.accountOverallBalance(address).map(
        (fiatBalance) {
          if (fiatBalance != null) {
            _balanceStorage.setOverallBalance(
              group: transport.transport.group,
              accountAddress: address,
              balance: fiatBalance,
            );
          }

          fiatBalance ??= _balanceStorage.getOverallBalance(
                transport.transport.group,
              )[address] ??
              Fixed.zero;

          return _currencyConvertService.convert(fiatBalance);
        },
      ),
    );
  }

  Stream<TonWalletState?> getWalletStateStream(Address address) =>
      _nekotonRepository.walletsMapStream.map((wallets) => wallets[address]);

  Future<void> retrySubscriptions(Address address) =>
      _nekotonRepository.retrySubscriptions(address);

  Future<void> tryUpdateWithdraws(Address address) async {
    if (_nekotonRepository.currentTransport.stakeInformation != null) {
      await _stakingService.tryUpdateWithdraws(address);
    }
  }

  void showMessage(Message message) => _messengerService.show(message);
}
