import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/amount_input/amount_input.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// View for Ton/Token Wallet to prepare transfer

class WalletPrepareTransferView extends StatelessWidget {
  const WalletPrepareTransferView(
    this._wm, {
    this.account,
    this.localCustodians,
    this.selectedCustodian,
    this.selectedAsset,
    super.key,
  });

  final WalletPrepareTransferPageWidgetModel _wm;

  final KeyAccount? account;
  final List<PublicKey>? localCustodians;
  final PublicKey? selectedCustodian;
  final WalletPrepareTransferAsset? selectedAsset;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _wm.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SeparatedColumn(
                separatorSize: DimensSize.d16,
                children: [
                  if (account != null) AccountInfo(account: account!),
                  if (localCustodians != null && localCustodians!.length > 1)
                    CommonSelectDropdown<PublicKey>(
                      values: [
                        for (final c in localCustodians!)
                          CommonSheetDropdownItem<PublicKey>(
                            value: c,
                            title: _wm.getSeedName(c) ?? c.toEllipseString(),
                          ),
                      ],
                      titleText: LocaleKeys.custodianWord.tr(),
                      currentValue: selectedCustodian,
                      onChanged: _wm.onChangedCustodian,
                    ),
                  PrimaryTextField(
                    labelText: LocaleKeys.toInputLabel.tr(),
                    hintText: LocaleKeys.receiverAddress.tr(),
                    textEditingController: _wm.receiverController,
                    focusNode: _wm.receiverFocus,
                    onSubmit: _wm.onSubmittedReceiverAddress,
                    inputFormatters: [_wm.addressFilterFormatter],
                    validator: _wm.validateAddressField,
                    suffixes: [
                      _ScanQRButton(
                        receiver: _wm.receiverState,
                        onPressed: _wm.onPressedScan,
                      ),
                      _PasteButton(
                        receiver: _wm.receiverState,
                        onPaste: _wm.onPressedPasteAddress,
                        onClear: _wm.onPressedReceiverClear,
                      ),
                    ],
                  ),
                  AmountInput(
                    controller: _wm.amountController,
                    focusNode: _wm.amountFocus,
                    assets: _wm.assets,
                    selectedAsset: selectedAsset,
                    onSelectedAssetChanged: _wm.onChangeAsset,
                    onMaxAmount: _wm.setMaxBalance,
                    onSubmitted: _wm.onSubmittedAmountWord,
                  ),
                  _buildCommentWidget(),
                ],
              ),
            ),
          ),
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.continueWord.tr(),
            onPressed: _wm.onPressedNext,
          ),
          const SizedBox(height: DimensSize.d16),
        ],
      ),
    );
  }

  Widget _buildCommentWidget() => StateNotifierBuilder(
        listenableState: _wm.commentState,
        builder: (context, value) => value ?? false
            ? SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryTextField(
                    hintText: LocaleKeys.commentWord.tr(),
                    textEditingController: _wm.commentController,
                    focusNode: _wm.commentFocus,
                    onSubmit: (_) => _wm.onPressedNext(),
                    suffixes: [
                      _buildCommentSuffix(),
                    ],
                  ),
                  Text(
                    LocaleKeys.addCommentHint.tr(),
                    style: context.themeStyleV2.textStyles.labelXSmall.copyWith(
                      color: context.themeStyleV2.colors.content3,
                    ),
                  ),
                ],
              )
            : GhostButton(
                buttonShape: ButtonShape.rectangle,
                buttonSize: ButtonSize.medium,
                title: LocaleKeys.addComment.tr(),
                icon: LucideIcons.plus,
                onPressed: () {
                  _wm.commentState.accept(true);
                  _wm.commentFocus.requestFocus();
                },
              ),
      );

  Widget _buildCommentSuffix() => StateNotifierBuilder(
        listenableState: _wm.commentTextState,
        builder: (_, value) {
          if (value?.isNotEmpty ?? false) {
            return Padding(
              padding: const EdgeInsets.only(right: DimensSize.d8),
              child: FloatButton(
                buttonShape: ButtonShape.square,
                buttonSize: ButtonSize.small,
                icon: LucideIcons.x,
                onPressed: _wm.onPressedCleanComment,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}

class _ScanQRButton extends StatelessWidget {
  const _ScanQRButton({
    required this.receiver,
    required this.onPressed,
  });

  final StateNotifier<String?> receiver;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: receiver,
      builder: (_, value) => value?.isEmpty ?? true
          ? Padding(
              padding: const EdgeInsets.only(right: DimensSize.d4),
              child: PrimaryButton(
                buttonShape: ButtonShape.square,
                buttonSize: ButtonSize.small,
                icon: LucideIcons.scan,
                onPressed: onPressed,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _PasteButton extends StatelessWidget {
  const _PasteButton({
    required this.receiver,
    required this.onPaste,
    required this.onClear,
  });

  final StateNotifier<String?> receiver;
  final VoidCallback onPaste;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: DimensSize.d8),
      child: StateNotifierBuilder(
        listenableState: receiver,
        builder: (_, value) {
          if (value?.isEmpty ?? true) {
            return PrimaryButton(
              buttonShape: ButtonShape.square,
              buttonSize: ButtonSize.small,
              icon: LucideIcons.arrowDownToDot,
              onPressed: onPaste,
            );
          }

          return PrimaryButton(
            buttonShape: ButtonShape.square,
            icon: LucideIcons.x,
            onPressed: onClear,
            buttonSize: ButtonSize.small,
          );
        },
      ),
    );
  }
}
