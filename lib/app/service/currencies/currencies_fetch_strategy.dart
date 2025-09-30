import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

abstract class CurrenciesFetchStrategy {
  Future<List<CustomCurrency>> fetchCurrencies({
    required Address nativeTokenAddress,
    required List<Address> currencyAddresses,
    required String apiBaseUrl,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
  });

  Future<CustomCurrency> fetchCurrency({
    required Address address,
    required String apiBaseUrl,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
  });
}

@singleton
class DefaultCurrenciesFetchStrategy implements CurrenciesFetchStrategy {
  DefaultCurrenciesFetchStrategy(this._dio);

  final Dio _dio;

  @override
  Future<List<CustomCurrency>> fetchCurrencies({
    required Address nativeTokenAddress,
    required List<Address> currencyAddresses,
    required String apiBaseUrl,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      apiBaseUrl,
      data: {
        'currencyAddresses': [...currencyAddresses, nativeTokenAddress],
        'limit': currencyAddresses.length + 1,
        'offset': 0,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    final data = response.data ?? {};
    final currencies = data['currencies'] as List<dynamic>;

    return currencies
        .map(
          (element) => CustomCurrency.fromJson(
            (element as Map<String, dynamic>)
              ..putIfAbsent(
                'networkType',
                () => networkType,
              )
              ..putIfAbsent(
                'networkGroup',
                () => networkGroup,
              ),
          ),
        )
        .toList();
  }

  @override
  Future<CustomCurrency> fetchCurrency({
    required Address address,
    required String apiBaseUrl,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
  }) async {
    final endpoint = '$apiBaseUrl/$address';
    final response = await _dio.post<Map<String, dynamic>>(endpoint);
    final data = response.data ?? {};

    return CustomCurrency.fromJson(
      data
        ..putIfAbsent(
          'networkType',
          () => networkType,
        )
        ..putIfAbsent(
          'networkGroup',
          () => networkGroup,
        ),
    );
  }
}

@singleton
class TonCurrenciesFetchStrategy implements CurrenciesFetchStrategy {
  TonCurrenciesFetchStrategy(this._dio);

  final Dio _dio;

  @override
  Future<List<CustomCurrency>> fetchCurrencies({
    required Address nativeTokenAddress,
    required List<Address> currencyAddresses,
    required String apiBaseUrl,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
  }) async {
    final addresses = [...currencyAddresses.map((e) => e.address), 'TON'];
    final response = await _dio.get<Map<String, dynamic>>(
      '$apiBaseUrl/rates?tokens=${addresses.join(',')}&currencies=USD',
    );
    final data = response.data ?? {};
    final rates = data['rates'] as Map<String, dynamic>;

    rates[nativeTokenAddress.toRaw()] = rates['TON'];
    rates.remove('TON');

    return rates.entries.map((element) {
      final address = element.key;
      final prices = (element.value as Map<String, dynamic>)['prices'];
      final price =
          (prices as Map<String, dynamic>?)?['USD']?.toString() ?? '0';

      return CustomCurrency(
        address: Address(address: address),
        price: price,
        networkGroup: networkGroup,
        networkType: networkType,
      );
    }).toList();
  }

  @override
  Future<CustomCurrency> fetchCurrency({
    required Address address,
    required String apiBaseUrl,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$apiBaseUrl/rates?tokens=$address&currencies=USD',
    );
    final data = response.data ?? {};
    final rates = data['rates'] as Map<String, dynamic>;
    final prices =
        (rates[address.toString()] as Map<String, dynamic>)['prices'];
    final price = (prices as Map<String, dynamic>?)?['USD']?.toString() ?? '0';

    return CustomCurrency(
      address: address,
      price: price,
      networkGroup: networkGroup,
      networkType: networkType,
    );
  }
}
