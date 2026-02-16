import 'package:app/feature/nft/view/add_nft/add_nft_wm.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/clipboard_paste_button.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/components/common/system_space.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/primary_text_field.dart';

class AddNftDefaultLayout extends StatelessWidget {
  const AddNftDefaultLayout(this._wm, {super.key});

  final AddNftWidgetModel _wm;

  @override
  Widget build(BuildContext context) {
    final theme = _wm.themeStyleV2;

    return Scaffold(
      backgroundColor: theme.colors.background0,
      appBar: DefaultAppBar(titleText: LocaleKeys.addNFT.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StateNotifierBuilder(
              listenableState: _wm.currentAccountState,
              builder: (_, account) {
                if (account == null) return const SizedBox.shrink();
                return AccountInfo(account: account);
              },
            ),

            const SizedBox(height: DimensSize.d12),
            PrimaryTextField(
              sizeType: PrimaryTextFieldSizeType.medium,
              hintText: LocaleKeys.nftPasteHint.tr(),
              textEditingController: _wm.addressController,
              inputFormatters: _wm.addressFilterFormatter,
              validator: _wm.validateAddressField,
              suffixes: [
                ClipboardPasteButton(
                  value: _wm.addressController,
                  onClear: _wm.onPressedClear,
                  onPaste: _wm.onPressedPaste,
                ),
              ],
            ),
            const SizedBox(height: DimensSize.d6),
            StateNotifierBuilder(
              listenableState: _wm.errorState,
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
              listenableState: _wm.loadingState,
              builder: (_, isLoading) => AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.importWalletButtonText.tr(),
                isLoading: isLoading ?? false,
                onPressed: _wm.onPressedImport,
              ),
            ),
            const SystemSpace(additionalPadding: DimensSize.d20),
          ],
        ),
      ),
    );
  }
}
