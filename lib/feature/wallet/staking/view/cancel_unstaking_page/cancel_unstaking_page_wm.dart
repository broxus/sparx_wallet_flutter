import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CancelUnstakingPageWmParams {
  const CancelUnstakingPageWmParams({
    required this.request,
    required this.accountKey,
    required this.exchangeRate,
    required this.withdrawHours,
    required this.stakeCurrency,
    required this.attachedFee,
    required this.tokenPrice,
    required this.everPrice,
  });

  final StEverWithdrawRequest request;
  final PublicKey accountKey;
  final double exchangeRate;
  final int withdrawHours;
  final Currency stakeCurrency;
  final BigInt attachedFee;
  final Fixed? tokenPrice;
  final Fixed? everPrice;
}

@injectable
class CancelUnstakingPageWidgetModel extends CustomWidgetModel<
    CancelUnstakingPageWidget, CancelUnstakingPageModel> {
  CancelUnstakingPageWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final CancelUnstakingPageWmParams _wmParams;

  late final _asset = createNotifier<TokenContractAsset>();

  StEverWithdrawRequest get request => _wmParams.request;
  PublicKey get accountKey => _wmParams.accountKey;
  double get exchangeRate => _wmParams.exchangeRate;
  int get withdrawHours => _wmParams.withdrawHours;
  Currency get stakeCurrency => _wmParams.stakeCurrency;
  BigInt get attachedFee => _wmParams.attachedFee;
  Fixed? get tokenPrice => _wmParams.tokenPrice;
  Fixed? get everPrice => _wmParams.everPrice;

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
      stakeCurrency: _wmParams.stakeCurrency,
    );
    if (!agreed) return;

    final payload = await model.getPayload(_wmParams.request.nonce);

    if (!context.mounted) return;

    final result = await contextSafe?.compassPush<bool>(
      TonWalletSendRouteData(
        address: _wmParams.request.accountAddress,
        amount: model.staking.stakeRemovePendingWithdrawAttachedFee,
        payload: payload,
        destination: model.staking.stakingValutAddress,
        publicKey: _wmParams.accountKey,
        resultMessage: LocaleKeys.stEverReturnInMinutes.tr(
          args: [_wmParams.stakeCurrency.symbol],
        ),
        popOnComplete: true,
      ),
    );

    if (result ?? false) {
      model.acceptCancelledWithdraw(_wmParams.request);
      contextSafe?.compassPointNamed(
        const WalletRouteData(),
      );
    }
  }
}
