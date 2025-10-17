import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/change_notifier_listener.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point to screen where user can add new asset(contract) to account with
/// [Address].
/// User can add existed asset or custom.
class SelectNewAssetPage
    extends
        InjectedElementaryParametrizedWidget<
          SelectNewAssetPageWidgetModel,
          Address
        > {
  const SelectNewAssetPage({required Address address, super.key})
    : super(wmFactoryParam: address);

  @override
  Widget build(SelectNewAssetPageWidgetModel wm) {
    return GestureDetector(
      onTap: wm.onTap,
      child: Scaffold(
        appBar: DefaultAppBar(titleText: LocaleKeys.selectNewAssets.tr()),
        body: DoubleSourceBuilder(
          firstSource: wm.contractsState,
          secondSource: wm.tabState,
          builder: (context, contracts, tab) {
            final list = contracts ?? [];
            return Padding(
              padding: const EdgeInsets.only(
                top: DimensSizeV2.d16,
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChangeNotifierListener(
                    changeNotifier: wm.focus,
                    builder: (context) {
                      final hasFocus = wm.focus.hasFocus;

                      if (hasFocus) return const SizedBox.shrink();

                      return SwitcherSegmentControls<SelectNewAssetTabs>(
                        currentValue: tab ?? SelectNewAssetTabs.select,
                        values: [
                          PrimarySegmentControl(
                            title: LocaleKeys.searchWord.tr(),
                            value: SelectNewAssetTabs.select,
                            size: SegmentControlSize.xsmall,
                            state: SegmentControlState.normal,
                          ),
                          PrimarySegmentControl(
                            title: LocaleKeys.customToken.tr(),
                            value: SelectNewAssetTabs.custom,
                            size: SegmentControlSize.xsmall,
                            state: SegmentControlState.normal,
                          ),
                        ],
                        onTabChanged: wm.changeTab,
                      );
                    },
                  ),
                  const SizedBox(height: DimensSizeV2.d16),
                  Expanded(
                    child: switch (tab) {
                      SelectNewAssetTabs.custom => SelectNewAssetCustomEnter(
                        focus: wm.focus,
                        contracts: list.where((c) => c.$1.isCustom).toList(),
                        onAddCustom: wm.addCustom,
                        onInvalidPaste: wm.onInvalidPaste,
                        onEnableAsset: wm.enableAsset,
                        onDisableAsset: wm.disableAsset,
                      ),
                      _ => SelectNewAssetSelectTab(
                        focus: wm.focus,
                        contracts: list,
                        onEnableAsset: wm.enableAsset,
                        onDisableAsset: wm.disableAsset,
                      ),
                    },
                  ),
                  StateNotifierBuilder(
                    listenableState: wm.showButtonState,
                    builder: (_, showButton) => AnimatedSize(
                      duration: defaultAnimationDuration,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: DimensSize.d16),
                        height: (showButton ?? false) ? DimensSizeV2.d90 : 0.0,
                        child: Center(
                          child: StateNotifierBuilder(
                            listenableState: wm.isLoadingState,
                            builder: (_, isLoading) => PrimaryButton(
                              buttonShape: ButtonShape.pill,
                              title: LocaleKeys.saveChanges.tr(),
                              isLoading: isLoading ?? false,
                              onPressed: wm.saveChanges,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
