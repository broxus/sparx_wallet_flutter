import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_icon.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/wallet_asset_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that stores information about native token and display its balance
class TonWalletAssetWidget
    extends
        InjectedElementaryParametrizedWidget<
          TonWalletAssetWidgetModel,
          TonWalletAsset
        > {
  const TonWalletAssetWidget({required TonWalletAsset tonWallet, super.key})
    : super(wmFactoryParam: tonWallet);

  @override
  Widget build(TonWalletAssetWidgetModel wm) {
    return DoubleSourceBuilder(
      firstSource: wm.tokenNameState,
      secondSource: wm.iconPathState,
      builder: (_, tokenName, iconPath) {
        if (tokenName == null || iconPath == null) {
          return const SizedBox.shrink();
        }

        return WalletAssetWidget(
          name: tokenName,
          tokenBalance: wm.tokenBalanceState,
          fiatBalance: wm.fiatBalanceState,
          error: wm.errorState,
          isRetryLoading: wm.isRetryLoadingState,
          icon: TonWalletIconWidget(path: iconPath),
          onRetryPressed: wm.retry,
          onPressed: wm.openDetails,
        );
      },
    );
  }
}
