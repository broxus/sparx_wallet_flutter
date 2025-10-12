import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/token_wallet_details/route.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_model.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_widget.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TokenWalletAssetParams {
  const TokenWalletAssetParams({
    required this.asset,
    required this.owner,
  });

  final TokenContractAsset asset;
  final Address owner;
}

@injectable
class TokenWalletAssetWidgetModel extends CustomWidgetModelParametrized<
    TokenWalletAssetWidget, TokenWalletAssetModel, TokenWalletAssetParams> {
  TokenWalletAssetWidgetModel(super.model);

  // Outputs
  late final _errorState = createNotifier<Object>();
  late final _isRetryLoadingState = createNotifier<bool>(false);
  late final _fiatBalanceState = createNotifier<Money>();
  late final _tokenBalanceState = createNotifier<Money>();

  // Internal
  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  TokenWalletState? _wallet;

  NetworkGroup get _networkGroup => model.currentNetworkGroup;

  // Expose params to the widget
  TokenContractAsset get asset => wmParams.value.asset;
  Address get owner => wmParams.value.owner;

  ListenableState<Money> get fiatBalanceState => _fiatBalanceState;
  ListenableState<Money> get tokenBalanceState => _tokenBalanceState;
  ListenableState<Object> get errorState => _errorState;
  ListenableState<bool> get isRetryLoadingState => _isRetryLoadingState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _walletsSubscription = model.tokenWalletsStream.listen(
      (wallets) {
        final walletState = wallets.firstWhereOrNull(
          (w) => w.owner == owner && w.rootTokenContract == asset.address,
        );

        final oldWallet = _wallet?.wallet;
        final wallet = walletState?.wallet;
        if (wallet != null &&
            (oldWallet == null ||
                wallet != oldWallet ||
                oldWallet.transport.connectionParamsHash !=
                    wallet.transport.connectionParamsHash)) {
          _wallet = walletState;
          _closeSubs();

          _thisWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
            _tokenBalanceState.accept(wallet.moneyBalance);

            _tryUpdateBalances();
          });
          _balanceSubscription = model
              .tokenWalletFiatStream(
            owner: owner,
            rootTokenContract: asset.address,
          )
              .listen((balance) {
            _fiatBalanceState.accept(model.convert(balance));

            _tryUpdateBalances();
          });
          _errorState.accept(null);
        } else if ((walletState?.hasError ?? false) == true) {
          _errorState.accept(walletState!.error);
          _isRetryLoadingState.accept(false);
        }
      },
    );

    final balances = model.readCached(
      group: _networkGroup,
      owner: owner,
      rootTokenContract: asset.address,
    );
    if (balances != null) {
      _fiatBalanceState.accept(balances.fiatBalance);
      _tokenBalanceState.accept(balances.tokenBalance);
    }
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
      _isRetryLoadingState.accept(true);
      await model.retrySubscription(owner, asset.address);
    } finally {
      _isRetryLoadingState.accept(false);
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
      model.writeCached(
        group: _networkGroup,
        owner: owner,
        rootTokenContract: asset.address,
        fiatBalance: fiat,
        tokenBalance: token,
      );
    }
  }

  void openDetails() {
    context.compassContinue(
      TokenWalletDetailsRouteData(
        owner: owner,
        rootTokenContract: asset.address,
      ),
    );
  }
}
