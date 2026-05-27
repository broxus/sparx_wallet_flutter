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
    final wallet = await _getWallet(account);
    if (wallet == null) return null;

    var currency = Currencies()[symbol];
    if (currency == null) {
      currency = Currency.create(symbol, 0, pattern: moneyPattern(0));
      _log.warning('Currency with symbol $symbol is not registered');
    }

    return Money.fromBigIntWithCurrency(wallet.contractState.balance, currency);
  }

  Future<TonWallet?> _getWallet(KeyAccount keyAccount) async =>
      _nekotonRepository.walletsMap[keyAccount.address]?.wallet ??
      (await _nekotonRepository.subscribe(keyAccount.account.tonWallet)).wallet;
}
