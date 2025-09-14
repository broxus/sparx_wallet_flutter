import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class TokenWalletTransactionsModel extends ElementaryModel {
  TokenWalletTransactionsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._walletStorage,
  ) : super(errorHandler: errorHandler);

  final _logger = Logger('TokenWalletTransactionsModel');

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final TokenWalletStorageService _walletStorage;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Stream<(TokenWalletState?, TransportStrategy)> getWalletStream(
    Address owner,
    Address rootTokenContract,
  ) {
    return Rx.combineLatest2<TokenWalletState?, TransportStrategy,
        (TokenWalletState?, TransportStrategy)>(
      _nekotonRepository.tokenWalletsStream.map(
        (wallets) => wallets.firstWhereOrNull(
          (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
        ),
      ),
      _nekotonRepository.currentTransportStream,
      (a, b) => (a, b),
    );
  }

  Stream<List<TransactionWithData<TokenWalletTransaction?>>>
      getTransactionsStream(
    Transport transport,
    Address owner,
    Address rootTokenContract,
  ) {
    return _walletStorage
        .transactionsStream(
          networkId: transport.networkId,
          group: transport.group,
          owner: owner,
          rootTokenContract: rootTokenContract,
        )
        .map((transactions) => transactions ?? []);
  }

  Future<CustomCurrency?> fetchTokenCustomCurrency(
    Address rootTokenContract,
  ) async {
    try {
      return await _currenciesService.getOrFetchCurrency(
        currentTransport,
        rootTokenContract,
      );
    } catch (e, t) {
      _logger.severe('fetchTokenCustomCurrency', e, t);
      return null;
    }
  }

  List<TokenWalletOrdinaryTransaction> mapOrdinaryTokenTransactions({
    required Address rootTokenContract,
    required List<TransactionWithData<TokenWalletTransaction?>> transactions,
  }) {
    return _nekotonRepository.mapOrdinaryTokenTransactions(
      rootTokenContract: rootTokenContract,
      transactions: transactions,
    );
  }

  Future<void> preloadTokenTransactions({
    required Address owner,
    required Address rootTokenContract,
    required String fromLt,
  }) async {
    await _nekotonRepository.preloadTokenTransactions(
      owner: owner,
      rootTokenContract: rootTokenContract,
      fromLt: fromLt,
    );
  }

  Future<void> preloadWalletTransactions(GenericTokenWallet wallet) async {
    if (!wallet.isTransactionsPreloaded) {
      await wallet.preloadTransactions();
    }
  }

  Stream<void> getWalletFieldUpdatesStream(GenericTokenWallet wallet) {
    return wallet.fieldUpdatesStream;
  }
}
