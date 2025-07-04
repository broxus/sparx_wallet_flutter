import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_wm.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/widgets/wallet_prepare_transfer_view.dart';
import 'package:app/feature/wallet/widgets/wallet_subscribe_error_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletPrepareTransferPage
    extends ElementaryWidget<WalletPrepareTransferPageWidgetModel> {
  const WalletPrepareTransferPage({
    required this.address,
    this.destination,
    this.rootTokenContract,
    this.tokenSymbol,
    Key? key,
    WidgetModelFactory wmFactory =
        defaultWalletPrepareTransferPageWidgetModelFactory,
  })  : assert(
          rootTokenContract == null && tokenSymbol == null ||
              rootTokenContract != null && tokenSymbol != null,
          // ignore: lines_longer_than_80_chars
          'rootTokenContract and tokenSymbol must be provided or not provided together',
        ),
        super(wmFactory, key: key);

  final Address address;
  final Address? destination;
  final Address? rootTokenContract;
  final String? tokenSymbol;

  @override
  Widget build(WalletPrepareTransferPageWidgetModel wm) {
    return EntityStateNotifierBuilder<WalletPrepareTransferData?>(
      listenableEntityState: wm.screenState,
      loadingBuilder: (_, __) => const _DefaultBody(),
      errorBuilder: (_, Exception? error, __) {
        return Center(
          child: WalletSubscribeErrorWidget(error: error ?? ''),
        );
      },
      builder: (_, data) {
        if (data == null || data.isEmpty) {
          return StateNotifierBuilder(
            listenableState: wm.addressState,
            builder: (context, addressState) {
              return _DefaultBody(
                child: _EmptyText(address: addressState ?? address),
              );
            },
          );
        }

        return _DataBody(
          wm,
          account: data.account,
          selectedCustodian: data.selectedCustodian,
          localCustodians: data.localCustodians,
          selectedAsset: data.selectedAsset,
        );
      },
    );
  }
}

class _DefaultBody extends StatelessWidget {
  const _DefaultBody({
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: child,
    );
  }
}

class _DataBody extends StatelessWidget {
  const _DataBody(
    this._wm, {
    this.account,
    this.localCustodians,
    this.selectedCustodian,
    this.selectedAsset,
  });

  final WalletPrepareTransferPageWidgetModel _wm;
  final KeyAccount? account;
  final List<PublicKey>? localCustodians;
  final PublicKey? selectedCustodian;
  final WalletPrepareTransferAsset? selectedAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: DefaultAppBar(
          titleText: LocaleKeys.sendYourFunds.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          child: WalletPrepareTransferView(
            _wm,
            account: account,
            selectedCustodian: selectedCustodian,
            localCustodians: localCustodians,
            selectedAsset: selectedAsset,
          ),
        ),
      ),
    );
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText({
    required this.address,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.accountNotFound.tr(args: [address.address]),
        style: StyleRes.primaryBold.copyWith(
          color: context.themeStyle.colors.textPrimary,
        ),
      ),
    );
  }
}
