import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Support service that listen for seed list and current key and emits
/// current account list from current key and seed list.
///
/// This service triggers [TonWalletRepository.updateSubscriptions] when
/// accounts changes.
///
/// To avoid starting subscriptions during app launch, call [init] in the end
/// of bootstrap process.
@singleton
class CurrentAccountsService {
  CurrentAccountsService(
    this._nekotonRepository,
    this._currentKeyService,
    this._storage,
    this._connectionsStorageService,
  );

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final GeneralStorageService _storage;
  final ConnectionsStorageService _connectionsStorageService;

  final _currentAccountsSubject = BehaviorSubject<AccountList?>();
  final _logger = Logger('CurrentAccountsService');

  /// Get stream of accounts in scope of current active key
  Stream<AccountList?> get currentAccountsStream => _currentAccountsSubject;

  /// Get accounts in scope of current active key
  AccountList? get currentAccounts => _currentAccountsSubject.valueOrNull;

  Address? get currentActiveAccountAddress => _storage.currentAddress;

  /// Get stream of current active account in wallet tab.
  /// This will automatically changes when [currentAccountsStream] emits new
  /// accounts for another key.
  ///
  /// Changes in this stream can also sign you that [currentAccountsStream]
  /// could provide a new value.
  ///
  /// You can affect for this stream, calling [updateCurrentActiveAccount]
  Stream<KeyAccount?> get currentActiveAccountStream =>
      CombineLatestStream.combine3(
        _storage.currentAddressStream,
        _currentAccountsSubject,
        _connectionsStorageService.currentConnectionIdStream,
        (address, accounts, _) {
          return accounts?.allAccounts.firstWhereOrNull(
            (account) =>
                account.address == address &&
                _connectionsStorageService.checkIsCurrentWorkchainIfExist(
                  account.workchain,
                ),
          );
        },
      );

  /// Get current active account in wallet tab.
  /// This will automatically changes when [currentAccountsStream] emits new
  /// accounts for another key.
  ///
  /// You can affect for this value, calling [updateCurrentActiveAccount]
  KeyAccount? get currentActiveAccount {
    final address = currentActiveAccountAddress;
    final accounts = currentAccounts;
    return accounts?.allAccounts.firstWhereOrNull(
      (account) => account.address == address,
    );
  }

  Future<void> init() async {
    // skip 1 to avoid duplicate calls
    _nekotonRepository.seedListStream
        .skip(1)
        .listen(
          (list) => _updateAccountsList(list, _currentKeyService.currentKey),
        );
    _currentKeyService.currentKeyStream
        .skip(1)
        .listen((key) => _updateAccountsList(_nekotonRepository.seedList, key));

    currentActiveAccountStream
        .distinct((prev, next) => prev == null && next == null)
        .listen((account) async {
          if (account != null) {
            await _updateSubscriptions(account);
          }
        });

    _initCurrentAccount();

    _updateAccountsList(
      _nekotonRepository.seedList,
      _currentKeyService.currentKey,
    );

    _nekotonRepository.currentTransportStream.distinct().listen(
      (transport) => _fetchAccountsForWorkchain(transport.workchainId),
    );
  }

  /// Try updating current active account for [currentAccounts]
  void updateCurrentActiveAccount(Address address) {
    if (currentActiveAccountAddress == address) return;
    _storage.setCurrentAddress(address);
  }

  void _initCurrentAccount() {
    final address = _storage.currentAddress;
    if (address == null) {
      return;
    }

    final key = _currentKeyService.currentKey?.let(
      (value) => _nekotonRepository.seedList.findSeedKey(value),
    );
    final account = key?.accountList.allAccounts.firstWhereOrNull(
      (KeyAccount account) => account.address == address,
    );

    if (account == null) {
      return;
    }

    updateCurrentActiveAccount(account.address);
  }

  void _tryUpdatingCurrentActiveAccount(AccountList? list) {
    if (list == null) {
      // means no accounts for this key and we should be logged out or another
      // accounts will be selected soon
      _storage.setCurrentAddress(null);
      _nekotonRepository.stopPolling();

      return;
    }

    final address = currentActiveAccountAddress;

    final keyChanged =
        address == null ||
        list.allAccounts.every(
          (account) =>
              account.address != address ||
              !_connectionsStorageService.checkIsCurrentWorkchain(
                account.workchain,
              ),
        );

    // key changed
    // for init method this will be called anyway.
    if (keyChanged) {
      final account =
          list.displayAccounts.firstWhereOrNull(
            (account) => _connectionsStorageService.checkIsCurrentWorkchain(
              account.workchain,
            ),
          ) ??
          list.allAccounts.firstWhereOrNull(
            (account) => _connectionsStorageService.checkIsCurrentWorkchain(
              account.workchain,
            ),
          );

      if (account != null) {
        updateCurrentActiveAccount(account.address);
      }
    }
  }

  void _updateAccountsList(SeedList list, PublicKey? currentKey) {
    if (currentKey == null) {
      _currentAccountsSubject.add(null);
      return;
    }

    final key = list.findSeedKey(currentKey);

    _tryUpdatingCurrentActiveAccount(key?.accountList);

    if (key == null) {
      _currentAccountsSubject.add(null);
      return;
    }

    if (_currentAccountsSubject.valueOrNull != key.accountList) {
      _currentAccountsSubject.add(key.accountList);
    }
  }

  /// Update Ton/Token wallet subscriptions when user changes current active key
  ///
  /// Old subscriptions will be automatically cancelled if haven't complete yet.
  Future<void> _updateSubscriptions(KeyAccount? account) async {
    if (account == null) {
      await _nekotonRepository.updateSubscriptions([]);
      await _nekotonRepository.updateTokenSubscriptions([]);
    } else {
      await _nekotonRepository.updateSubscriptions([account.account.tonWallet]);
      await _nekotonRepository.updateTokenSubscriptions([account.account]);
    }
  }

  Future<void> _fetchAccountsForWorkchain(int workchainId) async {
    final hasAny = _nekotonRepository.accountsStorage.accounts.any(
      (a) => a.address.workchain == workchainId,
    );

    if (hasAny) return;

    final publicKeys = _nekotonRepository.keyStore.keys
        .map((e) => e.publicKey)
        .toList();

    await _nekotonRepository.triggerAddingAccounts(
      publicKeys: publicKeys,
      workchainId: workchainId,
    );

    final notEmptyPublicKeys = _nekotonRepository.accountsStorage.accounts
        .where((a) => a.address.workchain == workchainId)
        .map((a) => a.publicKey)
        .toSet();

    for (final key in publicKeys) {
      if (notEmptyPublicKeys.contains(key)) continue;

      try {
        await _nekotonRepository.addDefaultAccount(
          publicKey: key,
          workchainId: workchainId,
        );
      } catch (e, s) {
        _logger.severe('_fetchAccountsForWorkchain', e, s);
      }
    }
  }
}
