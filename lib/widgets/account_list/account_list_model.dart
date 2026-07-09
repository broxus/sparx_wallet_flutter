import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class AccountListModel extends ElementaryModel {
  AccountListModel(ErrorHandler errorHandler, this._nekotonRepository)
    : super(errorHandler: errorHandler);

  final _log = Logger('AccountListModel');
  final NekotonRepository _nekotonRepository;

  String get symbol => currentTransport.nativeTokenTicker;

  List<KeyAccount> get accounts =>
      _nekotonRepository.allVisibleAccounts.toList();

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Future<Money?> getBalance(KeyAccount account) async {
    final balance = await _getWalletBalance(account);
    if (balance == null) return null;

    var currency = Currencies()[symbol];
    if (currency == null) {
      currency = Currency.create(symbol, 0, pattern: moneyPattern(0));
      _log.warning('Currency with symbol $symbol is not registered');
    }

    return Money.fromBigIntWithCurrency(balance, currency);
  }

  Future<BigInt?> _getWalletBalance(KeyAccount keyAccount) async {
    final wallet = _nekotonRepository.walletsMap[keyAccount.address]?.wallet;
    if (wallet != null) {
      return wallet.contractState.balance;
    }

    TonWallet? subscribed;
    try {
      subscribed = await TonWallet.subscribeByAddress(
        transport: currentTransport.transport,
        address: keyAccount.address,
      );

      return subscribed.contractState.balance;
    } catch (e) {
      _log.warning('Failed to subscribe to wallet: $e');
      return null;
    } finally {
      subscribed?.dispose();
    }
  }
}
