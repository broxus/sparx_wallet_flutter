import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_model.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_state.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class TokenWalletTransactionsParams {
  const TokenWalletTransactionsParams({
    required this.owner,
    required this.rootTokenContract,
  });

  final Address owner;
  final Address rootTokenContract;
}

@injectable
class TokenWalletTransactionsWidgetModel
    extends
        CustomWidgetModelParametrized<
          TokenWalletTransactionsWidget,
          TokenWalletTransactionsModel,
          TokenWalletTransactionsParams
        > {
  TokenWalletTransactionsWidgetModel(super.model);

  static final _logger = Logger('TokenWalletTransactionsWidgetModel');

  // Single state notifier following the unified state pattern
  late final _walletTransactionsState =
      createNotifier<TokenWalletTransactionsState>(
        const TokenWalletTransactionsState.loading(),
      );

  // State getter
  StateNotifier<TokenWalletTransactionsState> get walletTransactionsState =>
      _walletTransactionsState;

  Address get owner => wmParams.value.owner;
  Address get rootTokenContract => wmParams.value.rootTokenContract;

  /// If not null, then state will check for coming new
  /// transactions and there is no new, then canLoadMore will be false.
  String? _lastLtWhenPreloaded;
  CustomCurrency? _tokenCustomCurrency;

  // ignore: use_late_for_private_fields_and_variables
  Currency? _cachedCurrency;

  /// List of ordinary transactions and flag that sign that transactions was
  /// loaded and mapped.
  bool _ordinaryLoaded = false;
  bool _isPreloading = false;
  List<TokenWalletOrdinaryTransaction> _ordinary = [];
  List<TransactionWithData<TokenWalletTransaction?>> _transactions = [];

  StreamSubscription<dynamic>? _ordinaryTransactionsSub;
  StreamSubscription<dynamic>? _walletSubscription;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
    _initWalletSubscription();
  }

  @override
  void dispose() {
    _closeSubs();
    _walletSubscription?.cancel();
    super.dispose();
  }

  /// Called from UI when user scrolled to the end of the list.
  /// NOTE: this method may be called multiple times
  void tryPreloadTransactions() {
    final lastPrevLt = switch (_walletTransactionsState.value) {
      TokenWalletTransactionsStateTransactions() => _lastLt(_transactions),
      _ => null,
    };
    final (isLoading, canLoadMore) = switch (_walletTransactionsState.value) {
      TokenWalletTransactionsStateTransactions(
        :final isLoading,
        :final canLoadMore,
      ) =>
        (isLoading, canLoadMore),
      _ => (true, false),
    };

    if (isLoading || !canLoadMore || lastPrevLt == null) {
      return;
    }

    _preloadTransactions(lastPrevLt);
  }

  Future<void> _init() async {
    _tokenCustomCurrency = await model.fetchTokenCustomCurrency(
      rootTokenContract,
    );
  }

  void _initWalletSubscription() {
    _walletSubscription = model
        .getWalletStream(owner, rootTokenContract)
        .listen((value) async {
          final wallet = value.$1?.wallet;
          final transport = value.$2.transport;

          if (wallet == null) {
            _closeSubs();
            return;
          }

          if (!wallet.isTransactionsPreloaded) {
            await wallet.preloadTransactions();
          }

          _createSubs(wallet, transport);
        });
  }

  void _closeSubs() {
    _ordinaryTransactionsSub?.cancel();
  }

  void _createSubs(GenericTokenWallet wallet, Transport transport) {
    _closeSubs();

    _ordinaryTransactionsSub =
        Rx.combineLatest2<
              void,
              List<TransactionWithData<TokenWalletTransaction?>>,
              List<TransactionWithData<TokenWalletTransaction?>>
            >(
              wallet.fieldUpdatesStream,
              model.getTransactionsStream(transport, owner, rootTokenContract),
              (_, b) => b,
            )
            .listen((transactions) {
              _transactions = transactions;
              _ordinary = model.mapOrdinaryTokenTransactions(
                rootTokenContract: rootTokenContract,
                transactions: transactions,
              );

              _ordinaryLoaded = true;

              _checkState(wallet.moneyBalance.currency);
            });
  }

  void _checkState(Currency currency) {
    if (_ordinaryLoaded) {
      _cachedCurrency = currency;
      _transactionsState(fromStream: true);
    } else {
      _walletTransactionsState.accept(
        const TokenWalletTransactionsState.loading(),
      );
    }
  }

  void _transactionsState({bool fromStream = false, bool isLoading = false}) {
    if (_ordinary.isEmpty) {
      _walletTransactionsState.accept(
        const TokenWalletTransactionsState.empty(),
      );
    } else {
      final transactions = _ordinary;

      var canLoadMore = switch (_walletTransactionsState.value) {
        TokenWalletTransactionsStateTransactions(:final canLoadMore) =>
          canLoadMore,
        _ => true,
      };
      final lastLt = _lastLt(_transactions);
      if (_lastLtWhenPreloaded != null && !isLoading && fromStream) {
        // we must check this state every time, because we may have multiple
        // inputs for this method (different transactions streams, but not now,
        // just copied from <AccountTransactionsTabCubit>)
        // and this why we do not assign null to <_lastLtWhenPreloaded>
        canLoadMore = lastLt != _lastLtWhenPreloaded;
      }

      _walletTransactionsState.accept(
        TokenWalletTransactionsState.transactions(
          transactions: transactions,
          tokenCurrency: _cachedCurrency!,
          isLoading: isLoading,
          canLoadMore: canLoadMore,
          tokenCustomCurrency: _tokenCustomCurrency,
        ),
      );
    }
  }

  /// Get last available prevTransactionLt
  String? _lastLt(
    List<TransactionWithData<TokenWalletTransaction?>> transactions,
  ) => transactions
      .lastWhereOrNull((t) => t.transaction.prevTransactionId != null)
      ?.transaction
      .prevTransactionId
      ?.lt;

  Future<void> _preloadTransactions(String lastPrevLt) async {
    if (_isPreloading) return;
    _isPreloading = true;

    _transactionsState(isLoading: true);
    _lastLtWhenPreloaded = lastPrevLt;

    try {
      await model.preloadTokenTransactions(
        owner: owner,
        rootTokenContract: rootTokenContract,
        fromLt: lastPrevLt,
      );
    } catch (e, t) {
      _logger.severe('_preloadTransactions', e, t);
    } finally {
      _isPreloading = false;
      _transactionsState();
    }
  }
}
