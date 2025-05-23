import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/router/routs/wallet/ton_wallet_send_route_data.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

CancelUnstakingPageWidgetModel defaultCancelUnstakingPageWidgetModelFactory(
  BuildContext context,
) =>
    CancelUnstakingPageWidgetModel(
      CancelUnstakingPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
      inject(),
    );

class CancelUnstakingPageWidgetModel extends CustomWidgetModel<
    CancelUnstakingPageWidget, CancelUnstakingPageModel> {
  CancelUnstakingPageWidgetModel(super.model, this._tonWalletSendNavigator);

  final TonWalletSendRoute _tonWalletSendNavigator;

  late final _asset = createNotifier<TokenContractAsset>();

  ListenableState<TokenContractAsset> get asset => _asset;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Currency get nativeCurrency => model.nativeCurrency;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    _asset.accept(
      await model.getTokenContractAsset(),
    );
  }

  Future<void> tryCancelUnstaking() async {
    final agreed = await showVerifyCancelUnstakingSheet(
      context: context,
      stakeCurrency: widget.stakeCurrency,
    );
    if (!agreed) return;

    final payload = await model.getPayload(widget.request.nonce);

    if (!context.mounted) return;

    final result = await _tonWalletSendNavigator.push(
      context,
      TonWalletSendRouteData(
        address: widget.request.accountAddress,
        amount: model.staking.stakeRemovePendingWithdrawAttachedFee,
        payload: payload,
        destination: model.staking.stakingValutAddress,
        publicKey: widget.accountKey,
        resultMessage: LocaleKeys.stEverReturnInMinutes.tr(
          args: [widget.stakeCurrency.symbol],
        ),
        popOnComplete: true,
      ),
    );

    if (result ?? false) {
      model.acceptCancelledWithdraw(widget.request);
      contextSafe?.goNamed(AppRoute.wallet.name);
    }
  }
}
