import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class TonWalletAssetModel extends ElementaryModel {
  TonWalletAssetModel(
    ErrorHandler errorHandler,
    this._balanceStorage,
    this._balanceService,
    this._currencyConvertService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final BalanceStorageService _balanceStorage;
  final BalanceService _balanceService;
  final CurrencyConvertService _currencyConvertService;
  final NekotonRepository _nekotonRepository;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Stream<TransportStrategy> get currentTransportStream =>
      _nekotonRepository.currentTransportStream;

  Stream<Map<Address, TonWalletState>> get walletsMapStream =>
      _nekotonRepository.walletsMapStream;

  Stream<Fixed> getTonWalletBalanceStream(Address address) =>
      _balanceService.tonWalletBalanceStream(address);

  Map<Address, List<AccountBalanceModel>> getBalances(
    NetworkGroup networkGroup,
  ) => _balanceStorage.getBalances(networkGroup);

  void setBalances({
    required NetworkGroup networkGroup,
    required Address accountAddress,
    required AccountBalanceModel balance,
  }) {
    _balanceStorage.setBalances(
      group: networkGroup,
      accountAddress: accountAddress,
      balance: balance,
    );
  }

  Money convert(Fixed balance) => _currencyConvertService.convert(balance);

  Future<void> retrySubscriptions(Address address) =>
      _nekotonRepository.retrySubscriptions(address);
}
