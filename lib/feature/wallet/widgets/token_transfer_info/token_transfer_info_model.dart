import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TokenTransferInfoModel extends ElementaryModel {
  TokenTransferInfoModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._assetsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final AssetsService _assetsService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  CustomCurrency? getCurrencyForNativeToken() => _currenciesService
      .currencies(transport.transport.group)
      .firstWhereOrNull((e) => e.address == transport.nativeTokenAddress);

  CustomCurrency? getCurrencyForContract(Address address) => _currenciesService
      .currencies(transport.transport.group)
      .firstWhereOrNull((e) => e.address == address);

  Future<CustomCurrency?> fetchCurrencyForNativeToken() =>
      _currenciesService.getOrFetchNativeCurrency(transport);

  Future<CustomCurrency?> fetchCurrencyForContract(Address address) =>
      _currenciesService.getOrFetchCurrency(transport, address);

  Future<TokenContractAsset?> getTokenAsset(Address address) =>
      _assetsService.getTokenContractAsset(address, transport);
}
