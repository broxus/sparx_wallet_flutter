import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/app/service/currencies/currencies_fetch_strategy.dart';
import 'package:app/app/service/currencies/currencies_service.dart';
import 'package:app/app/service/current_accounts_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class _MockDio extends Mock implements Dio {}

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockCurrentAccountsService extends Mock
    implements CurrentAccountsService {}

class _MockGeneralStorageService extends Mock
    implements GeneralStorageService {}

class _MockAppLifecycleService extends Mock implements AppLifecycleService {}

class _MockDefaultCurrenciesFetchStrategy extends Mock
    implements DefaultCurrenciesFetchStrategy {}

class _MockTonCurrenciesFetchStrategy extends Mock
    implements TonCurrenciesFetchStrategy {}

class _MockTransportStrategy extends Mock implements CommonTransportStrategy {}

class _MockTransport extends Mock implements Transport {}

void main() {
  const networkGroup = 'ton';
  const rootTokenContract = Address(address: '0:root');
  const nativeTokenAddress = Address(address: '0:native');
  const cachedCurrency = CustomCurrency(
    address: rootTokenContract,
    price: '1.23',
    networkType: NetworkType.ton,
    networkGroup: networkGroup,
  );
  const fetchedCurrency = CustomCurrency(
    address: rootTokenContract,
    price: '4.56',
    networkType: NetworkType.ton,
    networkGroup: networkGroup,
  );
  const fetchedNativeCurrency = CustomCurrency(
    address: nativeTokenAddress,
    price: '7.89',
    networkType: NetworkType.ton,
    networkGroup: networkGroup,
  );

  late _MockDio dio;
  late _MockNekotonRepository nekotonRepository;
  late _MockCurrentAccountsService currentAccounts;
  late _MockGeneralStorageService storageService;
  late _MockAppLifecycleService appLifecycle;
  late _MockDefaultCurrenciesFetchStrategy defaultFetchStrategy;
  late _MockTonCurrenciesFetchStrategy tonFetchStrategy;
  late _MockTransportStrategy transport;
  late _MockTransport rawTransport;
  late CurrenciesService service;

  setUpAll(() {
    registerFallbackValue(const Address(address: '0:fallback'));
    registerFallbackValue(NetworkType.ton);
    registerFallbackValue(networkGroup);
    registerFallbackValue(<CustomCurrency>[]);
    registerFallbackValue(cachedCurrency);
  });

  setUp(() {
    dio = _MockDio();
    nekotonRepository = _MockNekotonRepository();
    currentAccounts = _MockCurrentAccountsService();
    storageService = _MockGeneralStorageService();
    appLifecycle = _MockAppLifecycleService();
    defaultFetchStrategy = _MockDefaultCurrenciesFetchStrategy();
    tonFetchStrategy = _MockTonCurrenciesFetchStrategy();
    transport = _MockTransportStrategy();
    rawTransport = _MockTransport();

    when(() => nekotonRepository.currentTransport).thenReturn(transport);
    when(() => transport.transport).thenReturn(rawTransport);
    when(() => rawTransport.group).thenReturn(networkGroup);
    when(() => transport.networkType).thenReturn(NetworkType.ton);
    when(() => transport.currencyApiBaseUrl).thenReturn('https://currencies');
    when(() => transport.nativeTokenAddress).thenReturn(nativeTokenAddress);
    when(() => storageService.getCurrencies(any())).thenReturn(const []);
    when(
      () =>
          storageService.saveOrUpdateCurrency(currency: any(named: 'currency')),
    ).thenReturn(null);

    service = CurrenciesService(
      dio: dio,
      nekotonRepository: nekotonRepository,
      currentAccounts: currentAccounts,
      storageService: storageService,
      appLifecycle: appLifecycle,
      defaultFetchStrategy: defaultFetchStrategy,
      tonFetchStrategy: tonFetchStrategy,
    );
  });

  group('CurrenciesService', () {
    test('uses ton fetch strategy for ton network', () {
      when(() => transport.networkType).thenReturn(NetworkType.ton);

      expect(service.fetchStrategy, same(tonFetchStrategy));
    });

    test('uses default fetch strategy for non-ton network', () {
      when(() => transport.networkType).thenReturn(NetworkType.ever);

      expect(service.fetchStrategy, same(defaultFetchStrategy));
    });

    test('fetchCurrencyForContract fetches currency and saves it', () async {
      when(
        () => tonFetchStrategy.fetchCurrency(
          address: rootTokenContract,
          apiBaseUrl: 'https://currencies',
          networkType: NetworkType.ton,
          networkGroup: networkGroup,
        ),
      ).thenAnswer((_) async => fetchedCurrency);

      final result = await service.fetchCurrencyForContract(
        transport,
        rootTokenContract,
      );

      expect(result, fetchedCurrency);
      verify(
        () => tonFetchStrategy.fetchCurrency(
          address: rootTokenContract,
          apiBaseUrl: 'https://currencies',
          networkType: NetworkType.ton,
          networkGroup: networkGroup,
        ),
      ).called(1);
      verify(
        () => storageService.saveOrUpdateCurrency(currency: fetchedCurrency),
      ).called(1);
    });

    test(
      'fetchCurrencyForContract returns null when api base url is empty',
      () async {
        when(() => transport.currencyApiBaseUrl).thenReturn('');

        final result = await service.fetchCurrencyForContract(
          transport,
          rootTokenContract,
        );

        expect(result, isNull);
        verifyNever(
          () => tonFetchStrategy.fetchCurrency(
            address: any(named: 'address'),
            apiBaseUrl: any(named: 'apiBaseUrl'),
            networkType: any(named: 'networkType'),
            networkGroup: any(named: 'networkGroup'),
          ),
        );
        verifyNever(
          () => storageService.saveOrUpdateCurrency(
            currency: any(named: 'currency'),
          ),
        );
      },
    );

    test(
      'fetchCurrencyForContract returns null when fetch strategy throws',
      () async {
        when(
          () => tonFetchStrategy.fetchCurrency(
            address: rootTokenContract,
            apiBaseUrl: 'https://currencies',
            networkType: NetworkType.ton,
            networkGroup: networkGroup,
          ),
        ).thenThrow(Exception('network failed'));

        final result = await service.fetchCurrencyForContract(
          transport,
          rootTokenContract,
        );

        expect(result, isNull);
        verifyNever(
          () => storageService.saveOrUpdateCurrency(
            currency: any(named: 'currency'),
          ),
        );
      },
    );

    test(
      'getOrFetchCurrency returns cached currency without fetching',
      () async {
        when(
          () => storageService.getCurrencies(networkGroup),
        ).thenReturn([cachedCurrency]);

        final result = await service.getOrFetchCurrency(
          transport,
          rootTokenContract,
        );

        expect(result, cachedCurrency);
        verifyNever(
          () => tonFetchStrategy.fetchCurrency(
            address: any(named: 'address'),
            apiBaseUrl: any(named: 'apiBaseUrl'),
            networkType: any(named: 'networkType'),
            networkGroup: any(named: 'networkGroup'),
          ),
        );
      },
    );

    test('getOrFetchCurrency fetches when currency is not cached', () async {
      when(
        () => storageService.getCurrencies(networkGroup),
      ).thenReturn(const []);
      when(
        () => tonFetchStrategy.fetchCurrency(
          address: rootTokenContract,
          apiBaseUrl: 'https://currencies',
          networkType: NetworkType.ton,
          networkGroup: networkGroup,
        ),
      ).thenAnswer((_) async => fetchedCurrency);

      final result = await service.getOrFetchCurrency(
        transport,
        rootTokenContract,
      );

      expect(result, fetchedCurrency);
      verify(
        () => tonFetchStrategy.fetchCurrency(
          address: rootTokenContract,
          apiBaseUrl: 'https://currencies',
          networkType: NetworkType.ton,
          networkGroup: networkGroup,
        ),
      ).called(1);
    });

    test(
      'getOrFetchNativeCurrency returns cached native currency when present',
      () async {
        when(
          () => storageService.getCurrencies(networkGroup),
        ).thenReturn([fetchedNativeCurrency]);

        final result = await service.getOrFetchNativeCurrency(transport);

        expect(result, fetchedNativeCurrency);
        verifyNever(
          () => tonFetchStrategy.fetchCurrency(
            address: any(named: 'address'),
            apiBaseUrl: any(named: 'apiBaseUrl'),
            networkType: any(named: 'networkType'),
            networkGroup: any(named: 'networkGroup'),
          ),
        );
      },
    );

    test('fetchCurrencyForNativeToken uses native token address', () async {
      when(
        () => tonFetchStrategy.fetchCurrency(
          address: nativeTokenAddress,
          apiBaseUrl: 'https://currencies',
          networkType: NetworkType.ton,
          networkGroup: networkGroup,
        ),
      ).thenAnswer((_) async => fetchedNativeCurrency);

      final result = await service.fetchCurrencyForNativeToken(transport);

      expect(result, fetchedNativeCurrency);
      verify(
        () => tonFetchStrategy.fetchCurrency(
          address: nativeTokenAddress,
          apiBaseUrl: 'https://currencies',
          networkType: NetworkType.ton,
          networkGroup: networkGroup,
        ),
      ).called(1);
    });
  });
}
