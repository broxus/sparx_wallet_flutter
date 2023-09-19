import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'token_wallet_transactions_state.dart';

part 'token_wallet_transactions_cubit.freezed.dart';

/// Cubit that allows mapping transactions for [TokenWallet] from storage to UI
/// elements.
class TokenWalletTransactionsCubit extends Cubit<TokenWalletTransactionsState> {
  TokenWalletTransactionsCubit({
    required this.owner,
    required this.rootTokenContract,
    required this.nekotonRepository,
    required this.walletStorage,
  }) : super(const TokenWalletTransactionsState.loading()) {
    _walletSubscription = Rx.combineLatest2<TokenWallet?, TransportStrategy,
        (TokenWallet?, TransportStrategy)>(
      nekotonRepository.tokenWalletsStream.map(
        (wallets) => wallets.firstWhereOrNull(
          (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
        ),
      ),
      nekotonRepository.currentTransportStream,
      (a, b) => (a, b),
    ).listen(
      (value) {
        final wallet = value.$1;
        final transport = value.$2.transport;

        if (wallet == null) {
          _closeSubs();

          return;
        }

        _createSubs(wallet, transport);
      },
    );
  }

  final _logger = Logger('TokenWalletTransactionsCubit');

  final Address owner;
  final Address rootTokenContract;
  final NekotonRepository nekotonRepository;
  final TokenWalletStorageService walletStorage;

  /// If not null, then [_transactionsState] will check for coming new
  /// transactions and there is no new, then [_canLoadMore] will be false.
  String? _lastLtWhenPreloaded;
  bool _isPreloadingTransactions = false;
  bool _canLoadMore = true;

  /// Called from UI when user scrolled to the end of the list.
  /// NOTE: this method may be called multiple times
  void tryPreloadTransactions() {
    final lastPrevLt = state.whenOrNull(
      transactions: (transactions, _, __) => _lastLt(transactions),
    );
    if (_isPreloadingTransactions || !_canLoadMore || lastPrevLt == null) {
      return;
    }

    _preloadTransactions(lastPrevLt);
  }

  Currency? _cachedCurrency;

  /// List of ordinary transactions and flag that sign that transactions was
  /// loaded and mapped.
  bool _ordinaryLoaded = false;
  List<TokenWalletOrdinaryTransaction> _ordinary = [];

  StreamSubscription<dynamic>? _ordinaryTransactionsSub;
  late StreamSubscription<dynamic> _walletSubscription;

  @override
  Future<void> close() {
    _closeSubs();
    _walletSubscription.cancel();

    return super.close();
  }

  void _closeSubs() {
    _ordinaryTransactionsSub?.cancel();
  }

  void _createSubs(TokenWallet wallet, Transport transport) {
    _closeSubs();

    _ordinaryTransactionsSub = Rx.combineLatest2<
        void,
        List<TransactionWithData<TokenWalletTransaction?>>?,
        List<TransactionWithData<TokenWalletTransaction?>>>(
      wallet.fieldUpdatesStream,
      walletStorage.transactionsStream(
        networkId: transport.networkId,
        group: transport.group,
        owner: owner,
        rootTokenContract: rootTokenContract,
      ),
      (_, b) => b ?? [],
    ).listen(
      (transactions) {
        _ordinary = nekotonRepository.mapOrdinaryTokenTransactions(
          rootTokenContract: rootTokenContract,
          transactions: transactions,
        );

        _ordinaryLoaded = true;

        _checkState(wallet.moneyBalance.currency);
      },
    );
  }

  void _checkState(Currency currency) {
    if (_ordinaryLoaded) {
      _cachedCurrency = currency;
      _transactionsState(true);
    } else {
      emit(const TokenWalletTransactionsState.loading());
    }
  }

  void _transactionsState([bool fromStream = false]) {
    if (_ordinary.isEmpty) {
      _canLoadMore = false;
      emit(const TokenWalletTransactionsState.empty());
    } else {
      final transactions = [..._ordinary]
        ..sort((a, b) => b.date.compareTo(a.date));

      final lastLt = _lastLt(transactions);
      if (_lastLtWhenPreloaded != null &&
          lastLt == _lastLtWhenPreloaded &&
          !_isPreloadingTransactions &&
          fromStream) {
        _canLoadMore = false;
        _lastLtWhenPreloaded = null;
      }

      emit(
        TokenWalletTransactionsState.transactions(
          transactions: transactions,
          tokenCurrency: _cachedCurrency!,
          isLoading: _isPreloadingTransactions,
        ),
      );
    }
  }

  /// Get last available prevTransactionLt
  String? _lastLt(
    List<TokenWalletOrdinaryTransaction> transactions,
  ) =>
      transactions
          .lastWhereOrNull((t) => t.prevTransactionLt != null)
          ?.prevTransactionLt;

  Future<void> _preloadTransactions(String lastPrevLt) async {
    _isPreloadingTransactions = true;
    _transactionsState();
    _lastLtWhenPreloaded = lastPrevLt;

    try {
      await nekotonRepository.preloadTokenTransactions(
        owner: owner,
        rootTokenContract: rootTokenContract,
        fromLt: lastPrevLt,
      );
    } catch (e, t) {
      _logger.severe('_preloadTransactions', e, t);
    } finally {
      _isPreloadingTransactions = false;
      _transactionsState();
    }
  }
}
