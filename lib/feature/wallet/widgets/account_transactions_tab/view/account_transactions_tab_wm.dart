import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class AccountTransactionsTabWmParams {
  AccountTransactionsTabWmParams({
    required this.account,
  });

  final KeyAccount account;
}

@injectable
class AccountTransactionsTabWidgetModel extends CustomWidgetModelParametrized<
    AccountTransactionsTab,
    AccountTransactionsTabModel,
    AccountTransactionsTabWmParams> {
  AccountTransactionsTabWidgetModel(super.model);

  final _logger = Logger('AccountTransactionsTabWM');

  late final _state =
      createNotifier(const AccountTransactionsUiState.loading());

  StateNotifier<AccountTransactionsUiState> get state => _state;

  // Internal
  CustomCurrency? _nativeCurrency;
  String? _lastLtWhenPreloaded;
  bool _isPreloading = false;

  bool _multisigLoaded = false;
  bool _ordinaryLoaded = false;
  bool _pendingLoaded = false;
  bool _expiredLoaded = false;

  List<TonWalletMultisigOrdinaryTransaction> _multisigOrdinary = [];
  List<TonWalletMultisigPendingTransaction> _multisigPending = [];
  List<TonWalletMultisigExpiredTransaction> _multisigExpired = [];
  List<TransactionWithData<TransactionAdditionalInfo?>> _transactions = [];

  List<TonWalletOrdinaryTransaction> _ordinary = [];
  List<TonWalletPendingTransaction> _pending = [];
  List<TonWalletExpiredTransaction> _expired = [];

  StreamSubscription<dynamic>? _ordinaryTransactionsSub;
  StreamSubscription<dynamic>? _expiredTransactionsSub;
  StreamSubscription<dynamic>? _pendingTransactionsSub;
  StreamSubscription<dynamic>? _multisigTransactionsSub;
  StreamSubscription<dynamic>? _walletSubscription;

  TransportStrategy get _transport => model.currentTransport;
  KeyAccount get _account => wmParams.value.account;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _walletSubscription = Rx.combineLatest2<TonWalletState?, TransportStrategy,
        (TonWalletState?, TransportStrategy)>(
      model.walletsMapStream.map((wallets) => wallets[_account.address]),
      model.currentTransportStream,
      (a, b) => (a, b),
    ).listen((value) {
      final wallet = value.$1?.wallet;
      final transport = value.$2.transport;

      if (wallet == null) {
        _closeSubs();
        _emitLoading();
        return;
      }

      _createSubs(wallet, transport);
    });

    _initNativeCurrency();
  }

  @override
  void dispose() {
    _closeSubs();
    _walletSubscription?.cancel();
    super.dispose();
  }

  void tryPreloadTransactions() {
    final current = _state.value;
    final lastPrevLt = _lastLt(_transactions);
    final isLoading = switch (current) {
      AccountTransactionsUiData(:final isLoading) => isLoading,
      _ => true,
    };
    final canLoadMore = switch (current) {
      AccountTransactionsUiData(:final canLoadMore) => canLoadMore,
      _ => false,
    };

    if (isLoading || !canLoadMore || lastPrevLt == null) return;

    _preloadTransactions(lastPrevLt);
  }

  Future<void> _initNativeCurrency() async {
    _nativeCurrency = await model.getOrFetchNativeCurrency(_transport);
  }

  void _createSubs(TonWallet wallet, Transport transport) {
    _closeSubs();

    _multisigTransactionsSub = Rx.combineLatest2<
        void,
        List<TransactionWithData<TransactionAdditionalInfo?>>?,
        List<TransactionWithData<TransactionAdditionalInfo?>>>(
      wallet.fieldUpdatesStream,
      model.transactionsStream(
        networkId: transport.networkId,
        group: transport.group,
        address: wallet.address,
      ),
      (_, b) => b ?? [],
    ).listen((transactions) async {
      final multisigTransactions = wallet.unconfirmedTransactions;
      _transactions = transactions;

      try {
        _multisigExpired = await model.mapMultisigExpiredTransactions(
          walletAddress: wallet.address,
          transactions: transactions,
          multisigPendingTransactions: multisigTransactions,
        );
      } catch (_) {}
      try {
        _multisigOrdinary = await model.mapMultisigOrdinaryTransactions(
          walletAddress: wallet.address,
          transactions: transactions,
          multisigPendingTransactions: multisigTransactions,
        );
      } catch (_) {}

      try {
        _multisigPending = await model.mapMultisigPendingTransactions(
          walletAddress: wallet.address,
          transactions: transactions,
          multisigPendingTransactions: multisigTransactions,
        );
      } catch (_) {}

      _multisigLoaded = true;
      _checkState();
    });

    _pendingTransactionsSub = model
        .pendingTransactionsRawStream(
      networkId: transport.networkId,
      group: transport.group,
      address: wallet.address,
    )
        .listen((pending) {
      _pending = model.mapPendingTransactions(
        walletAddress: wallet.address,
        pendingTransactions: pending ?? [],
      );
      _pendingLoaded = true;
      _checkState();
    });

    _expiredTransactionsSub = model
        .expiredTransactionsRawStream(
      networkId: transport.networkId,
      group: transport.group,
      address: wallet.address,
    )
        .listen((expired) {
      _expired = model.mapExpiredTransactions(
        walletAddress: wallet.address,
        expiredTransactions: expired ?? [],
      );
      _expiredLoaded = true;
      _checkState();
    });

    _ordinaryTransactionsSub = model
        .transactionsStream(
      networkId: transport.networkId,
      group: transport.group,
      address: wallet.address,
    )
        .listen((ordinary) {
      _ordinary = model.mapOrdinaryTransactions(
        walletAddress: wallet.address,
        transactions: ordinary ?? [],
      );
      _ordinaryLoaded = true;
      _checkState();
    });
  }

  void _checkState() {
    if (_multisigLoaded &&
        _pendingLoaded &&
        _expiredLoaded &&
        _ordinaryLoaded) {
      _transactionsState(fromStream: true);
    } else {
      _emitLoading();
    }
  }

  void _transactionsState({
    bool fromStream = false,
    bool isLoading = false,
  }) {
    if (_multisigExpired.isEmpty &&
        _multisigPending.isEmpty &&
        _multisigOrdinary.isEmpty &&
        _expired.isEmpty &&
        _pending.isEmpty &&
        _ordinary.isEmpty) {
      _state.accept(const AccountTransactionsUiState.empty());
      return;
    }

    final transactions = [
      ..._multisigOrdinary.map(
        (e) => AccountTransactionItem(
          date: e.date,
          transaction: e,
          prevTransactionLt: e.prevTransactionLt,
          type: AccountTransactionType.multisigOrdinary,
        ),
      ),
      ..._multisigPending.map(
        (e) => AccountTransactionItem(
          date: e.date,
          transaction: e,
          prevTransactionLt: e.prevTransactionLt,
          type: AccountTransactionType.multisigPending,
        ),
      ),
      ..._multisigExpired.map(
        (e) => AccountTransactionItem(
          date: e.date,
          transaction: e,
          prevTransactionLt: e.prevTransactionLt,
          type: AccountTransactionType.multisigExpired,
        ),
      ),
      ..._ordinary.map(
        (e) => AccountTransactionItem(
          date: e.date,
          transaction: e,
          prevTransactionLt: e.prevTransactionLt,
          type: AccountTransactionType.ordinary,
        ),
      ),
      ..._pending.map(
        (e) => AccountTransactionItem(
          date: e.date,
          transaction: e,
          prevTransactionLt: null,
          type: AccountTransactionType.pending,
        ),
      ),
      ..._expired.map(
        (e) => AccountTransactionItem(
          date: e.date,
          transaction: e,
          prevTransactionLt: null,
          type: AccountTransactionType.expired,
        ),
      ),
    ]..sort((a, b) => b.compareTo(a));

    var canLoadMore = switch (_state.value) {
      AccountTransactionsUiData(:final canLoadMore) => canLoadMore,
      _ => true,
    };
    final lastLt = _lastLt(_transactions);

    if (_lastLtWhenPreloaded != null && !isLoading && fromStream) {
      canLoadMore = lastLt != _lastLtWhenPreloaded;
    }

    _state.accept(
      AccountTransactionsUiState.data(
        transactions: transactions,
        isLoading: isLoading,
        canLoadMore: canLoadMore,
        price: Fixed.parse(_nativeCurrency?.price ?? '0'),
      ),
    );
  }

  String? _lastLt(
    List<TransactionWithData<TransactionAdditionalInfo?>> transactions,
  ) =>
      transactions
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
      await model.preloadTransactions(
        address: _account.address,
        fromLt: lastPrevLt,
      );
    } catch (e, t) {
      _logger.severe('_preloadTransactions', e, t);
    } finally {
      _isPreloading = false;
      _transactionsState();
    }
  }

  void _closeSubs() {
    _multisigTransactionsSub?.cancel();
    _ordinaryTransactionsSub?.cancel();
    _expiredTransactionsSub?.cancel();
    _pendingTransactionsSub?.cancel();
  }

  void _emitLoading() {
    _state.accept(const AccountTransactionsUiState.loading());
  }
}
