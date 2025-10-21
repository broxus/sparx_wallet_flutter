import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/account_asset_tab_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/route.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_widget.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountAssetsTab
    extends
        InjectedElementaryParametrizedWidget<
          AccountAssetsTabWidgetModel,
          AccountAssetsTabParams
        > {
  AccountAssetsTab({
    required this.confirmImportCallback,
    required KeyAccount account,
    required bool isShowingNewTokens,
    required String manifestUrl,
    super.key,
  }) : super(
         wmFactoryParam: AccountAssetsTabParams(
           account: account,
           isShowingNewTokens: isShowingNewTokens,
           manifestUrl: manifestUrl,
         ),
       );

  final VoidCallback confirmImportCallback;

  @override
  Widget build(AccountAssetsTabWidgetModel wm) {
    return SliverMainAxisGroup(
      slivers: [
        DecoratedSliver(
          decoration: BoxDecoration(
            color: wm.theme.colors.background1,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensRadiusV2.radius16),
              bottom: Radius.circular(DimensRadiusV2.radius16),
            ),
          ),
          sliver: StateNotifierBuilder(
            listenableState: wm.assetsState,
            builder: (_, assetsState) {
              final list = assetsState ?? [];
              final itemCount = list.length + 1;
              final lastIndex = itemCount - 1;

              return SliverList.separated(
                itemCount: itemCount,
                separatorBuilder: (_, index) {
                  if (index == lastIndex) {
                    return const SizedBox(height: DimensSizeV2.d12);
                  }
                  return Container(
                    height: DimensSize.d24,
                    color: wm.theme.colors.background1,
                  );
                },
                itemBuilder: (_, index) {
                  final asset = index == 0
                      ? TonWalletAssetWidget(tonWallet: wm.tonWallet)
                      : TokenWalletAssetWidget(
                          key: ValueKey(list[index - 1].address),
                          asset: list[index - 1],
                          owner: wm.tonWallet.address,
                        );

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: wm.theme.colors.background1,
                      borderRadius: BorderRadius.vertical(
                        top: index == 0
                            ? const Radius.circular(DimensRadiusV2.radius16)
                            : Radius.zero,
                        bottom: index == lastIndex
                            ? const Radius.circular(DimensRadiusV2.radius16)
                            : Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? DimensSizeV2.d16 : 0,
                        bottom: index == lastIndex ? DimensSizeV2.d16 : 0,
                      ),
                      child: asset,
                    ),
                  );
                },
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: StateNotifierBuilder(
            listenableState: wm.numberNewTokensState,
            builder: (_, newTokensCount) => _FooterAssetsWidget(
              address: wm.address,
              isShowingNewTokens: wm.isShowingNewTokens,
              confirmImportCallback: confirmImportCallback,
              numberNewTokens: newTokensCount,
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterAssetsWidget extends StatelessWidget {
  const _FooterAssetsWidget({
    required this.address,
    required this.isShowingNewTokens,
    required this.confirmImportCallback,
    required this.numberNewTokens,
  });

  final Address address;
  final bool isShowingNewTokens;
  final VoidCallback confirmImportCallback;
  final int? numberNewTokens;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d6),
        if (isShowingNewTokens && numberNewTokens == null)
          const ProgressIndicatorWidget(size: DimensSizeV2.d18),
        if (isShowingNewTokens && (numberNewTokens ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(top: DimensSizeV2.d6),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: theme.textStyles.paragraphSmall,
                children: [
                  TextSpan(
                    text: LocaleKeys.newTokensLabel.tr(
                      args: ['$numberNewTokens'],
                    ),
                    style: theme.textStyles.paragraphSmall.copyWith(
                      color: theme.colors.content0,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showSelectTokesModal(
                          context,
                          address,
                          confirmImportCallback,
                        );
                      },
                  ),
                  TextSpan(text: ' ${LocaleKeys.foundInThisAccountLabel.tr()}'),
                  const TextSpan(text: '\n'),
                ],
              ),
            ),
          ),
        Text(
          LocaleKeys.dontSeeYourToken.tr(),
          style: theme.textStyles.paragraphSmall,
        ),
        const SizedBox(height: DimensSizeV2.d2),
        SeparatedRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showSelectTokesModal(context, address, confirmImportCallback);
              },
              child: Text(
                LocaleKeys.refreshToFind.tr(),
                style: theme.textStyles.labelSmall,
              ),
            ),
            Text(
              LocaleKeys.orWord.tr(),
              style: theme.textStyles.paragraphSmall,
            ),
            GestureDetector(
              onTap: () {
                context.compassContinue(
                  SelectNewAssetRouteData(address: address),
                );
              },
              child: Text(
                LocaleKeys.manageAssets.tr(),
                style: theme.textStyles.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
