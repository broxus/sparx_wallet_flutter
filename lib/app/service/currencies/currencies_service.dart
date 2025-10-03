import 'package:app/app/service/connection/connection.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const currencyRefreshInterval = Duration(seconds: 60);

/// Refresher that will try to update currencies for current accounts and
/// transport.
class CurrencyRefresher implements RefreshingInterface {
  CurrencyRefresher(
    this.currenciesService,
    this.nekotonRepository,
    this.currentAccountsService,
  );

  final NekotonRepository nekotonRepository;
  final CurrentAccountsService currentAccountsService;
  final CurrenciesService currenciesService;

  @override
  Future<void> refresh() => currenciesService._currencyChangedListener(
        currentAccountsService.currentAccounts?.displayAccounts,
        nekotonRepository.currentTransport,
      );

  @override
  String get refreshDescription => 'CurrencyRefresher';
}

/// Service that allows automatically updating currencies of tokens and native
/// wallets and save it to storage.
@singleton
class CurrenciesService {
  CurrenciesService({
    required this.dio,
    required this.nekotonRepository,
    required this.currentAccounts,
    required this.storageService,
    required this.appLifecycle,
    required this.defaultFetchStrategy,
    required this.tonFetchStrategy,
  });

  static final _logger = Logger('CurrenciesService');

  final Dio dio;
  final NekotonRepository nekotonRepository;
  final CurrentAccountsService currentAccounts;
  final GeneralStorageService storageService;
  final AppLifecycleService appLifecycle;
  final DefaultCurrenciesFetchStrategy defaultFetchStrategy;
  final TonCurrenciesFetchStrategy tonFetchStrategy;

  CurrenciesFetchStrategy get fetchStrategy =>
      // TODO(komarov): change to network type
      switch (nekotonRepository.currentTransport.networkGroup) {
        'ton' => tonFetchStrategy,
        _ => defaultFetchStrategy,
      };

  /// Get stream of currencies from storage for [group] of network.
  Stream<List<CustomCurrency>> currenciesStream(NetworkGroup group) =>
      storageService.currenciesStream(group);

  /// Get list of currencies from storage for [group] of network.
  List<CustomCurrency> currencies(NetworkGroup group) =>
      storageService.getCurrencies(group);

  RefreshPollingQueue? _poller;

  /// Init subscriptions for accounts and transport and start polling
  void init() {
    // skip 1 to avoid duplicate calls
    nekotonRepository.currentTransportStream
        .skip(1)
        .listen((_) => startPolling());
    currentAccounts.currentAccountsStream.skip(1).listen((_) => startPolling());

    appLifecycle.appLifecycleStateStream.listen((cycle) {
      switch (cycle) {
        case AppLifecycleState.resumed:
          startPolling(refreshImmediately: false);
        case AppLifecycleState.inactive:
        case AppLifecycleState.detached:
        case AppLifecycleState.paused:
        case AppLifecycleState.hidden:
          stopPolling();
      }
    });

    startPolling();
  }

  /// Start polling for updating currency
  void startPolling({bool refreshImmediately = true}) {
    _poller?.stop();

    _poller = RefreshPollingQueue(
      refresher: CurrencyRefresher(
        this,
        nekotonRepository,
        currentAccounts,
      ),
      refreshInterval: currencyRefreshInterval,
      stopPollingIfError: false,
    )..start(refreshImmediately: refreshImmediately);
  }

  /// Stop polling for currencies (when app turned into background)
  void stopPolling() {
    _poller?.stop();
  }

  /// Get single currency for [rootTokenContract] in scope of [transport], save
  /// this currency to storage and return.
  Future<CustomCurrency?> fetchCurrencyForContract(
    TransportStrategy transport,
    Address rootTokenContract,
  ) async {
    try {
      final abiBaseUrl = transport.currencyApiBaseUrl;

      if (abiBaseUrl != null && abiBaseUrl.isNotEmpty) {
        final currency = await fetchStrategy.fetchCurrency(
          apiBaseUrl: abiBaseUrl,
          address: rootTokenContract,
          networkType: transport.networkType,
          networkGroup: transport.transport.group,
        );

        storageService.saveOrUpdateCurrency(currency: currency);

        return currency;
      }
    } catch (e, st) {
      _logger.severe('getCurrencyForContract', e, st);
    }

    return null;
  }

  /// Get single currency for native token in scope of [transport], save
  /// this currency to storage and return.
  Future<CustomCurrency?> fetchCurrencyForNativeToken(
    TransportStrategy transport,
  ) =>
      fetchCurrencyForContract(transport, transport.nativeTokenAddress);

  Future<CustomCurrency?> getOrFetchCurrency(
    TransportStrategy transport,
    Address rootTokenContract,
  ) async =>
      currencies(transport.transport.group)
          .firstWhereOrNull((e) => e.address == rootTokenContract) ??
      await fetchCurrencyForContract(transport, rootTokenContract);

  Future<CustomCurrency?> getOrFetchNativeCurrency(
    TransportStrategy transport,
  ) async =>
      currencies(transport.transport.group)
          .firstWhereOrNull((e) => e.address == transport.nativeTokenAddress) ??
      await fetchCurrencyForNativeToken(transport);

  /// Update all currencies for [assets] and its token contracts in scope of
  /// [transport]. All currencies will be saved to storage.
  Future<void> _currencyChangedListener(
    List<KeyAccount>? assets,
    TransportStrategy transport,
  ) async {
    final abiBaseUrl = transport.currencyApiBaseUrl;
    if (assets == null || abiBaseUrl == null || abiBaseUrl.isEmpty) return;

    final rootTokenContracts = assets
        .map(
          (e) =>
              e.additionalAssets[transport.transport.group]?.tokenWallets ?? [],
        )
        .expand((e) => e)
        .map((e) => e.rootTokenContract)
        .toList();

    final currencies = await fetchStrategy.fetchCurrencies(
      nativeTokenAddress: transport.nativeTokenAddress,
      currencyAddresses: rootTokenContracts,
      apiBaseUrl: abiBaseUrl,
      networkType: transport.networkType,
      networkGroup: transport.transport.group,
    );

    storageService.saveOrUpdateCurrencies(
      currencies: currencies,
      group: transport.transport.group,
    );
  }
}
