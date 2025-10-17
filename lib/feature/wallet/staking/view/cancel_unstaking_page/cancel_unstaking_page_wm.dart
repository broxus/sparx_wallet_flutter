import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
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
class CancelUnstakingPageWidgetModel
    extends
        CustomWidgetModelParametrized<
          CancelUnstakingPageWidget,
          CancelUnstakingPageModel,
          CancelUnstakingPageWmParams
        > {
  CancelUnstakingPageWidgetModel(super.model);

  late final _assetState = createNotifier<TokenContractAsset>();

  StEverWithdrawRequest get request => wmParams.value.request;
  PublicKey get accountKey => wmParams.value.accountKey;
  double get exchangeRate => wmParams.value.exchangeRate;
  int get withdrawHours => wmParams.value.withdrawHours;
  Currency get stakeCurrency => wmParams.value.stakeCurrency;
  BigInt get attachedFee => wmParams.value.attachedFee;
  Fixed? get tokenPrice => wmParams.value.tokenPrice;
  Fixed? get everPrice => wmParams.value.everPrice;

  ListenableState<TokenContractAsset> get assetState => _assetState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Currency get nativeCurrency => model.nativeCurrency;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    _assetState.accept(await model.getTokenContractAsset());
  }

  Future<void> tryCancelUnstaking() async {
    final agreed = await showVerifyCancelUnstakingSheet(
      context: context,
      stakeCurrency: wmParams.value.stakeCurrency,
    );
    if (!agreed) return;

    final (payload, fees) = await FutureExt.wait2(
      model.getPayload(wmParams.value.request.nonce),
      model.computeFees(),
    );

    if (!context.mounted) return;

    final result = await contextSafe?.compassPush<bool>(
      TonWalletSendRouteData(
        address: wmParams.value.request.accountAddress,
        amount: fees.removePendingWithdrawAttachedFee,
        payload: payload,
        destination: model.staking.stakingValutAddress,
        publicKey: wmParams.value.accountKey,
        resultMessage: LocaleKeys.stEverReturnInMinutes.tr(
          args: [wmParams.value.stakeCurrency.symbol],
        ),
        popOnComplete: true,
      ),
    );

    if (result ?? false) {
      model.acceptCancelledWithdraw(wmParams.value.request);
      contextSafe?.compassPointNamed(const WalletRouteData());
    }
  }
}
