import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_wm.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/widgets/comment.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/widgets/custodian_dropdown.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/widgets/recipient_text_field.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/widgets/amount_input/amount_input.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/container/separated_column.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';

class WalletPrepareTransferPageDefaultLayout extends StatelessWidget {
  const WalletPrepareTransferPageDefaultLayout(
    this._wm, {
    required this.isCustodianSelectionVisible,
    this.account,
    this.localCustodians,
    this.selectedCustodian,
    this.selectedAsset,
    super.key,
  });

  final WalletPrepareTransferPageWidgetModel _wm;
  final bool isCustodianSelectionVisible;
  final KeyAccount? account;
  final List<PublicKey>? localCustodians;
  final PublicKey? selectedCustodian;
  final WalletPrepareTransferAsset? selectedAsset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(titleText: LocaleKeys.sendYourFunds.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SeparatedColumn(
                  spacing: DimensSize.d16,
                  children: [
                    if (account != null) AccountInfo(account: account!),
                    if (isCustodianSelectionVisible && localCustodians != null)
                      CustodianDropdown(
                        localCustodians: localCustodians!,
                        selectedCustodian: selectedCustodian,
                        getSeedName: _wm.getSeedName,
                        onChangedCustodian: _wm.onChangedCustodian,
                      ),
                    RecipientTextField(
                      receiverController: _wm.recipientUi.textController,
                      receiverFocus: _wm.recipientUi.focusNode,
                      inputFormatters: _wm.recipientUi.addressFormatters,
                      validateAddressField: _wm.validateAddressField,
                      onSubmittedReceiverAddress:
                          _wm.onSubmittedReceiverAddress,
                      onPressedScan: _wm.recipientUi.onPressedScan,
                      onPressedReceiverClear:
                          _wm.recipientUi.onPressedReceiverClear,
                      onPressedPasteAddress:
                          _wm.recipientUi.onPressedPasteAddress,
                    ),
                    AmountInput(
                      controller: _wm.amountUi.amountController,
                      focusNode: _wm.amountUi.amountFocus,
                      assets: _wm.assetsState,
                      selectedAsset: selectedAsset,
                      onSelectedAssetChanged: _wm.onChangeAsset,
                      onMaxAmount: _wm.setMaxBalance,
                      onSubmitted: _wm.onSubmittedAmountWord,
                    ),
                    WalletPrepareTransferComment(
                      commentState: _wm.commentUi.commentState,
                      textEditingController: _wm.commentUi.commentController,
                      focusNode: _wm.commentUi.commentFocus,
                      onPressedNext: _wm.onPressedNext,
                      onPressedPlus: _wm.onPressedPlus,
                      onPressedCleanComment:
                          _wm.commentUi.onPressedCleanComment,
                    ),
                  ],
                ),
              ),
            ),
            StateNotifierBuilder(
              listenableState: _wm.isInitialDataLoadedState,
              builder: (context, isInitialDataLoaded) {
                return AccentButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.continueWord.tr(),
                  onPressed: _wm.onPressedNext.takeIf(
                    (_) => isInitialDataLoaded ?? false,
                  ),
                );
              },
            ),
            const SizedBox(height: DimensSize.d16),
          ],
        ),
      ),
    );
  }
}
