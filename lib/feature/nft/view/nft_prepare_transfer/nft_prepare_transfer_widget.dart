import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NftPrepareTransfer
    extends ElementaryWidget<NftPrepareTransferWidgetModel> {
  const NftPrepareTransfer({
    required this.routeData,
    Key? key,
    WidgetModelFactory wmFactory = defaultNftPrepareTransferWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final NftPrepareTransferRouteData routeData;

  @override
  Widget build(NftPrepareTransferWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.nftTransferTitle.tr(),
      ),
      body: EntityStateNotifierBuilder(
        listenableEntityState: wm.dataState,
        loadingBuilder: (_, __) => const Center(
          child: Padding(
            padding: EdgeInsets.all(DimensSizeV2.d16),
            child: CommonCircularProgressIndicator(
              size: CircularIndicatorSize.large,
            ),
          ),
        ),
        errorBuilder: (_, Exception? error, __) {
          return Center(
            child: WalletSubscribeErrorWidget(error: error ?? ''),
          );
        },
        builder: (_, data) {
          if (data == null) return const SizedBox.shrink();

          final theme = wm.theme;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d16,
            ),
            child: Form(
              key: wm.formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: DimensSize.d12,
                        children: [
                          if (!routeData.tokenFlag)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: DimensSizeV2.d4,
                              ),
                              child: Text(
                                LocaleKeys.nftTransferDescription.tr(),
                                style:
                                    theme.textStyles.paragraphMedium.copyWith(
                                  color: theme.colors.content1,
                                ),
                              ),
                            ),
                          AccountInfo(account: data.account),
                          _Item(
                            item: data.item,
                            collection: data.collection,
                          ),
                          if (data.localCustodians != null &&
                              data.localCustodians!.length > 1)
                            CommonSelectDropdown<PublicKey>(
                              values: [
                                for (final c in data.localCustodians!)
                                  CommonSheetDropdownItem<PublicKey>(
                                    value: c,
                                    title: wm.getSeedName(c) ??
                                        c.toEllipseString(),
                                  ),
                              ],
                              titleText: LocaleKeys.custodianWord.tr(),
                              currentValue: data.custodian,
                              onChanged: wm.onChangedCustodian,
                            ),
                          PrimaryTextField(
                            labelText: LocaleKeys.toInputLabel.tr(),
                            hintText: LocaleKeys.receiverAddress.tr(),
                            textEditingController: wm.receiverController,
                            isAutofocus: true,
                            focusNode: wm.receiverFocus,
                            onSubmit: wm.onSubmittedReceiverAddress,
                            inputFormatters: [wm.addressFilterFormatter],
                            validator: wm.validateAddressField,
                            suffixes: [
                              _ScanQRButton(
                                receiver: wm.receiverController,
                                onPressed: wm.onPressedScan,
                              ),
                              ClipboardPasteButton(
                                value: wm.receiverController,
                                onClear: wm.onPressedReceiverClear,
                                onPaste: wm.onPressedPasteAddress,
                              ),
                            ],
                          ),
                          if (data.item.wallet != null && routeData.tokenFlag)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              spacing: DimensSizeV2.d6,
                              children: [
                                PrimaryTextField(
                                  labelText: LocaleKeys.amountInputLabel.tr(),
                                  hintText: LocaleKeys.amountInputHint.tr(),
                                  textEditingController: wm.amountController,
                                  focusNode: wm.amountFocus,
                                  inputFormatters: [wm.amountFilterFormatter],
                                  validator: wm.validateAmountField,
                                  suffixes: [
                                    _MaxButton(onPressed: wm.onMaxBalance),
                                  ],
                                  onSubmit: (_) => wm.onSubmit(),
                                ),
                                Text(
                                  LocaleKeys.balance.tr(
                                    args: [
                                      data.item.wallet!.balance.toString(),
                                    ],
                                  ),
                                  style: theme.textStyles.labelXSmall.copyWith(
                                    color: theme.colors.content3,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  AccentButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.transfer.tr(),
                    onPressed: wm.onSubmit,
                  ),
                  const SizedBox(height: DimensSize.d24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
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

class _MaxButton extends StatelessWidget {
  const _MaxButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: DimensSize.d4),
      child: PrimaryButton(
        title: LocaleKeys.maxWord.tr(),
        buttonShape: ButtonShape.rectangle,
        buttonSize: ButtonSize.small,
        onPressed: onPressed,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.item,
    required this.collection,
  });

  final NftItem item;
  final NftCollection collection;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final balance = item.wallet?.balance;
    final supply = item.nft.supply;

    return ShapedContainerRow(
      color: theme.colors.background1,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d16,
        vertical: DimensSizeV2.d8,
      ),
      children: [
        SizedBox(
          width: DimensSizeV2.d40,
          height: DimensSizeV2.d40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius20),
            child: NftImage(imageUrl: item.nft.previewUrl),
          ),
        ),
        Expanded(
          child: Column(
            spacing: DimensSizeV2.d4,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.nft.name ?? LocaleKeys.unknown.tr(),
                style: theme.textStyles.labelMedium,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
              Text(
                collection.name ?? LocaleKeys.unknown.tr(),
                style: theme.textStyles.labelXSmall.copyWith(
                  color: theme.colors.content3,
                ),
              ),
            ],
          ),
        ),
        if (balance != null && supply != null)
          PrimaryCard(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d4,
              vertical: DimensSizeV2.d2,
            ),
            color: theme.colors.background2,
            borderRadius: BorderRadius.circular(
              DimensRadiusV2.radius6,
            ),
            child: Text(
              '$balance/$supply',
              style: theme.textStyles.labelXSmall,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
          ),
      ],
    );
  }
}
