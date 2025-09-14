import 'package:app/app/service/balance_service.dart';
import 'package:app/app/service/currency_convert_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class TonWalletDetailsPageModel extends ElementaryModel {
  TonWalletDetailsPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currencyConvertService,
    this._balanceService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrencyConvertService _currencyConvertService;
  final BalanceService _balanceService;

  String get symbol => _nekotonRepository.currentTransport.nativeTokenTicker;

  Stream<Fixed> getTonWalletBalanceStream(Address address) =>
      _balanceService.tonWalletBalanceStream(address);

  Stream<Map<Address, TonWalletState>> get walletsMapStream =>
      _nekotonRepository.walletsMapStream;

  KeyAccount? findAccountByAddress(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Money convertCurrency(Fixed usdAmount) =>
      _currencyConvertService.convert(usdAmount);

  Future<void> retrySubscriptions(Address address) =>
      _nekotonRepository.retrySubscriptions(address);
}
