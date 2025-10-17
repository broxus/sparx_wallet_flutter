import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/token_wallet_details/view/token_wallet_details_model.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TokenWalletDetailsWmParams {
  const TokenWalletDetailsWmParams({
    required this.owner,
    required this.rootTokenContract,
  });

  final Address owner;
  final Address rootTokenContract;
}

@injectable
class TokenWalletDetailsWidgetModel
    extends
        CustomWidgetModelParametrized<
          InjectedElementaryParametrizedWidget<
            TokenWalletDetailsWidgetModel,
            TokenWalletDetailsWmParams
          >,
          TokenWalletDetailsModel,
          TokenWalletDetailsWmParams
        > {
  TokenWalletDetailsWidgetModel(super.model);

  late final ScrollController scrollController = createScrollController();
  late final _contractNameState = createValueNotifier('');
  late final _tokenBalanceState = createNotifier<Money>();
  late final _fiatBalanceState = createNotifier<Money>();
  late final _canSendState = createNotifier(false);
  late final _errorState = createNotifier<Object>();
  late final _loadingErrorState = createNotifier(false);

  ValueListenable<String> get contractNameState => _contractNameState;
  ListenableState<Money> get tokenBalanceState => _tokenBalanceState;
  ListenableState<Money> get fiatBalanceState => _fiatBalanceState;
  ListenableState<bool> get canSendState => _canSendState;
  ListenableState<Object> get errorState => _errorState;
  ListenableState<bool> get loadingErrorState => _loadingErrorState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Address get owner => wmParams.value.owner;
  Address get rootTokenContract => wmParams.value.rootTokenContract;

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;
  KeyAccount? _keyAccount;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void dispose() {
    _walletsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();
    super.dispose();
  }

  Future<void> onRetry() async {
    try {
      _loadingErrorState.accept(true);
      await model.retryTokenSubscription(owner, rootTokenContract);
    } finally {
      _loadingErrorState.accept(false);
    }
  }

  void onSend() {
    final balance = _tokenBalanceState.value;
    if (balance == null) return;

    contextSafe?.compassContinue(
      WalletPrepareSpecifiedTransferRouteData(
        address: owner,
        rootTokenContract: rootTokenContract,
        tokenSymbol: balance.currency.isoCode,
      ),
    );
  }

  Future<void> _init() async {
    _errorState.accept(null);

    _keyAccount = model.findAccountByAddress(owner);
    if (_keyAccount == null) return;

    final contract = model.maybeGetTokenContract(
      rootTokenContract,
      model.currentTransport,
    );
    _contractNameState.value = contract?.name ?? '';

    // set initial token balance using contract symbol if available
    _tokenBalanceState.accept(
      Money.fromBigIntWithCurrency(
        BigInt.zero,
        Currency.create(contract?.symbol ?? '?', 0),
      ),
    );

    // initial fiat balance to 0
    _fiatBalanceState.accept(model.convertFiat(Fixed.zero));

    // subscribe for wallets list to find our wallet state
    _walletsSubscription = model.tokenWalletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
      );

      if (walletState == null) return;

      _walletsSubscription?.cancel();

      if (walletState.hasError) {
        _errorState.accept(walletState.error);
        _loadingErrorState.accept(false);
        return;
      }

      final wallet = walletState.wallet!;

      _thisWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
        _tokenBalanceState.accept(wallet.moneyBalance);
      });

      _balanceSubscription = model
          .tokenWalletBalanceStream(
            owner: owner,
            rootTokenContract: rootTokenContract,
          )
          .listen((balance) {
            _fiatBalanceState.accept(model.convertFiat(balance));
          });

      _checkIfCanSend();
    });
  }

  Future<void> _checkIfCanSend() async {
    if (_keyAccount == null) return;

    final isGaslessAvailable = await model.isGaslessAvailable(
      keyAccount: _keyAccount!,
      rootTokenContract: rootTokenContract,
    );
    if (isGaslessAvailable) {
      _canSendState.accept(true);
      return;
    }

    final local = await model.getLocalCustodians(owner);
    _canSendState.accept(local != null && local.isNotEmpty);
  }
}
