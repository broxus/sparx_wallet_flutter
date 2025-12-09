import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

@named
@Singleton(as: CompassBaseRoute)
class PendingTransactionDetailsRoute
    extends CompassRoute<PendingTransactionDetailsRouteData> {
  PendingTransactionDetailsRoute()
    : super(
        path: '/multisig-pending-transaction-details',
        builder: (context, data, __) =>
            TonWalletMultisigPendingTransactionDetailsScreen(
              transaction: data.transaction,
              account: data.account,
              price: data.price,
            ),
      );

  static final _cache = <String, PendingTransactionDetailsRouteData>{};

  @override
  PendingTransactionDetailsRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final id = queryParams['cacheKey']!;
    final cached = _cache.remove(id)!;

    return cached;
  }
}

class PendingTransactionDetailsRouteData implements CompassRouteDataQuery {
  const PendingTransactionDetailsRouteData({
    required this.transaction,
    required this.price,
    required this.account,
  });

  final TonWalletMultisigPendingTransaction transaction;
  final Fixed price;
  final KeyAccount account;

  @override
  Map<String, String> toQueryParams() {
    final id = const Uuid().v4();
    PendingTransactionDetailsRoute._cache[id] = this;

    return {'cacheKey': id};
  }
}
