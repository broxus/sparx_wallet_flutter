import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/nft/view/add_nft/add_nft_wm.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:app/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddNftWidget extends InjectedElementaryWidget<AddNftWidgetModel> {
  const AddNftWidget({super.key});

  @override
  Widget build(AddNftWidgetModel wm) {
    final theme = wm.themeStyleV2;

    return Scaffold(
      backgroundColor: theme.colors.background0,
      appBar: DefaultAppBar(titleText: LocaleKeys.addNFT.tr()),
      body: StateNotifierBuilder(
        listenableState: wm.currentAccountState,
        builder: (_, account) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (account != null) AccountInfo(account: account),
                const SizedBox(height: DimensSizeV2.d12),
                PrimaryTextField(
                  sizeType: PrimaryTextFieldSizeType.medium,
                  hintText: LocaleKeys.nftPasteHint.tr(),
                  textEditingController: wm.addressController,
                  inputFormatters: wm.addressFilterFormatter,
                  validator: wm.validateAddressField,
                  suffixes: [
                    ClipboardPasteButton(
                      value: wm.addressController,
                      onClear: wm.onPressedClear,
                      onPaste: wm.onPressedPaste,
                    ),
                  ],
                ),
                const SizedBox(height: DimensSizeV2.d6),
                StateNotifierBuilder(
                  listenableState: wm.errorState,
                  builder: (_, error) {
                    if (error == null || error.isEmpty) {
                      return Text(
                        LocaleKeys.nftImportHint.tr(),
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content1,
                        ),
                      );
                    }

                    return Text(
                      error,
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.negative,
                      ),
                    );
                  },
                ),
                const Spacer(),
                StateNotifierBuilder(
                  listenableState: wm.loadingState,
                  builder: (_, isLoading) => AccentButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.importWalletButtonText.tr(),
                    isLoading: isLoading ?? false,
                    onPressed: wm.onPressedImport,
                  ),
                ),
                const SizedBox(height: DimensSizeV2.d28),
              ],
            ),
          );
        },
      ),
    );
  }
}
