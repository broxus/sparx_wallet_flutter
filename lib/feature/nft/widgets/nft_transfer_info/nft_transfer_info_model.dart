import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class NftTransferInfoModel extends ElementaryModel {
  NftTransferInfoModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  CustomCurrency? getCurrencyForNativeToken() => _currenciesService
      .currencies(transport.transport.group)
      .firstWhereOrNull((e) => e.address == transport.nativeTokenAddress);

  Future<CustomCurrency?> fetchCurrencyForNativeToken() =>
      _currenciesService.getOrFetchNativeCurrency(transport);
}
