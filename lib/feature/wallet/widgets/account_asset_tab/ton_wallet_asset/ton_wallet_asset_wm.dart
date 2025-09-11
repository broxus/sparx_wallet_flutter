import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/ton_wallet_details/route.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_model.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class TonWalletAssetWidgetModel extends CustomWidgetModelParametrized<
    TonWalletAssetWidget, TonWalletAssetModel, TonWalletAsset> {
  TonWalletAssetWidgetModel(super.model);

  // Outputs
  late final _errorState = createNotifier<Object>();
  late final _retryLoadingState = createNotifier<bool>(false);
  late final _fiatBalanceState = createNotifier<Money>();
  late final _tokenBalanceState = createNotifier<Money>();
  late final _tokenNameState = createNotifier(
    model.currentTransport.nativeTokenTicker,
  );
  late final _iconPathState =
      createNotifier(model.currentTransport.nativeTokenIcon);

  // Internal
  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  TonWalletState? _wallet;

  NetworkGroup get _networkGroup => model.currentTransport.transport.group;

  Address get _nativeTokenContract => model.currentTransport.nativeTokenAddress;

  ListenableState<Money> get fiatBalance => _fiatBalanceState;
  ListenableState<Money> get tokenBalance => _tokenBalanceState;
  ListenableState<String> get tokenName => _tokenNameState;
  ListenableState<String> get iconPath => _iconPathState;
  ListenableState<Object> get error => _errorState;
  ListenableState<bool> get isRetryLoading => _retryLoadingState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _walletsSubscription = model.currentTransportStream.switchMap((transport) {
      // Update token meta when transport changes
      _tokenNameState.accept(transport.nativeTokenTicker);
      _iconPathState.accept(transport.nativeTokenIcon);

      _closeSubs();

      final balances = model
          .getBalances(_networkGroup)[wmParams.value.address]
          ?.tokenBalance(_nativeTokenContract, isNative: true);

      _fiatBalanceState.accept(balances?.fiatBalance);
      _tokenBalanceState.accept(balances?.tokenBalance);

      return model.walletsMapStream;
    }).listen((Map<Address, TonWalletState> wallets) {
      final walletState = wallets[wmParams.value.address];

      final oldWallet = _wallet?.wallet;
      final wallet = walletState?.wallet;
      if (wallet != null &&
          (oldWallet == null ||
              wallet != oldWallet ||
              oldWallet.transport.connectionParamsHash !=
                  wallet.transport.connectionParamsHash)) {
        _wallet = walletState;
        _closeSubs();

        _thisWalletSubscription = wallet.fieldUpdatesStream.listen(
          (_) {
            _tokenBalanceState.accept(
              Money.fromBigIntWithCurrency(
                wallet.contractState.balance,
                Currencies()[model.currentTransport.nativeTokenTicker]!,
              ),
            );

            _tryUpdateBalances();
          },
        );
        _balanceSubscription =
            model.getTonWalletBalanceStream(wmParams.value.address).listen(
          (balance) {
            _fiatBalanceState.accept(model.convert(balance));

            _tryUpdateBalances();
          },
        );
        _errorState.accept(null);
      } else if ((walletState?.hasError ?? false) == true) {
        final ws = walletState!;
        _errorState.accept(ws.error);
        _retryLoadingState.accept(false);
      }
    });
  }

  @override
  void dispose() {
    _walletsSubscription?.cancel();
    _closeSubs();
    super.dispose();
  }

  Future<void> retry() async {
    final err = _errorState.value;
    if (err == null) return;

    try {
      _retryLoadingState.accept(true);
      await model.retrySubscriptions(wmParams.value.address);
    } finally {
      _retryLoadingState.accept(false);
    }
  }

  void _closeSubs() {
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();
  }

  void _tryUpdateBalances() {
    final fiat = _fiatBalanceState.value;
    final token = _tokenBalanceState.value;
    if (fiat != null && token != null) {
      model.setBalances(
        networkGroup: _networkGroup,
        accountAddress: wmParams.value.address,
        balance: AccountBalanceModel(
          rootTokenContract: _nativeTokenContract,
          fiatBalance: fiat,
          tokenBalance: token,
          isNative: true,
        ),
      );
    }
  }

  void openDetails() {
    context.compassContinue(
      TonWalletDetailsRouteData(address: wmParams.value.address),
    );
  }
}
