import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/wallet_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that stores information about additional token and display its
/// balances.
class TokenWalletAssetWidget
    extends
        InjectedElementaryParametrizedWidget<
          TokenWalletAssetWidgetModel,
          TokenWalletAssetParams
        > {
  TokenWalletAssetWidget({
    required TokenContractAsset asset,
    required Address owner,
    super.key,
  }) : super(
         wmFactoryParam: TokenWalletAssetParams(asset: asset, owner: owner),
       );

  @override
  Widget build(TokenWalletAssetWidgetModel wm) {
    final asset = wm.asset;

    return WalletAssetWidget(
      name: asset.name,
      tokenBalance: wm.tokenBalanceState,
      fiatBalance: wm.fiatBalanceState,
      error: wm.errorState,
      isRetryLoading: wm.isRetryLoadingState,
      icon: TokenWalletIconWidget(
        logoURI: asset.logoURI,
        address: asset.address,
        version: asset.version,
      ),
      onRetryPressed: wm.retry,
      onPressed: wm.openDetails,
    );
  }
}
