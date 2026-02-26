import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/layouts/wallet_prepare_transfer_page_default_layout.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/layouts/wallet_prepare_transfer_page_small_layout.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_subscribe_error_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/utils/view_utils.dart';

class WalletPrepareTransferPage
    extends
        InjectedElementaryParametrizedWidget<
          WalletPrepareTransferPageWidgetModel,
          WalletPrepareTransferPageWmParams
        > {
  WalletPrepareTransferPage({
    required Address address,
    Address? destination,
    Address? rootTokenContract,
    String? tokenSymbol,
    super.key,
  }) : super(
         wmFactoryParam: WalletPrepareTransferPageWmParams(
           address: address,
           destination: destination,
           rootTokenContract: rootTokenContract,
           tokenSymbol: tokenSymbol,
         ),
       );

  @override
  Widget build(WalletPrepareTransferPageWidgetModel wm) {
    return EntityStateNotifierBuilder<WalletPrepareTransferData?>(
      listenableEntityState: wm.screenState,
      loadingBuilder: (_, __) => const _DefaultBody(),
      errorBuilder: (_, Exception? error, __) {
        return Center(child: WalletSubscribeErrorWidget(error: error ?? ''));
      },
      builder: (_, data) {
        if (data == null || data.isEmpty) {
          return ValueListenableBuilder(
            valueListenable: wm.addressState,
            builder: (_, addressState, __) {
              return _DefaultBody(child: _EmptyText(address: addressState));
            },
          );
        }

        final isCustodianSelectionVisible =
            data.localCustodians != null &&
            data.localCustodians!.isNotEmpty &&
            (data.localCustodians!.length > 1 ||
                data.localCustodians!.first != data.account?.publicKey);

        return GestureDetector(
          onTap: resetFocus,
          child: Form(
            key: wm.formKey,
            child: isSmallScreenHeight
                ? WalletPrepareTransferPageSmallLayout(
                    wm,
                    isCustodianSelectionVisible: isCustodianSelectionVisible,
                    account: data.account,
                    selectedCustodian: data.selectedCustodian,
                    localCustodians: data.localCustodians,
                    selectedAsset: data.selectedAsset,
                  )
                : WalletPrepareTransferPageDefaultLayout(
                    wm,
                    isCustodianSelectionVisible: isCustodianSelectionVisible,
                    account: data.account,
                    selectedCustodian: data.selectedCustodian,
                    localCustodians: data.localCustodians,
                    selectedAsset: data.selectedAsset,
                  ),
          ),
        );
      },
    );
  }
}

class _DefaultBody extends StatelessWidget {
  const _DefaultBody({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const DefaultAppBar(), body: child);
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText({required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Text(
          LocaleKeys.accountNotFound.tr(args: [address.address]),
          style: StyleRes.primaryBold.copyWith(
            color: context.themeStyle.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
