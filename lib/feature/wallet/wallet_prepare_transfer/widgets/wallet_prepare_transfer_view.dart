import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/widgets/widgets.dart';
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
    final isCustodianSelectionVisible = localCustodians != null &&
        localCustodians!.isNotEmpty &&
        (localCustodians!.length > 1 ||
            localCustodians!.first != account?.publicKey);

    return Form(
      key: _wm.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SeparatedColumn(
                spacing: DimensSize.d16,
                children: [
                  if (account != null) AccountInfo(account: account!),
                  if (isCustodianSelectionVisible)
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
                        receiver: _wm.receiverController,
                        onPressed: _wm.onPressedScan,
                      ),
                      ClipboardPasteButton(
                        value: _wm.receiverController,
                        onClear: _wm.onPressedReceiverClear,
                        onPaste: _wm.onPressedPasteAddress,
                      ),
                    ],
                  ),
                  AmountInput(
                    controller: _wm.amountController,
                    focusNode: _wm.amountFocus,
                    assets: _wm.assetsState,
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
                      ValueListenableBuilder(
                        valueListenable: _wm.commentController,
                        builder: (_, value, __) {
                          if (value.text.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding:
                                const EdgeInsets.only(right: DimensSize.d8),
                            child: FloatButton(
                              buttonShape: ButtonShape.square,
                              buttonSize: ButtonSize.small,
                              icon: LucideIcons.x,
                              onPressed: _wm.onPressedCleanComment,
                            ),
                          );
                        },
                      ),
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
}

class _ScanQRButton extends StatelessWidget {
  const _ScanQRButton({
    required this.receiver,
    required this.onPressed,
  });

  final ValueNotifier<TextEditingValue> receiver;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: receiver,
      builder: (_, value, ___) => value.text.isEmpty
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
