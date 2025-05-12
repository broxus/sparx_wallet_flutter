import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/stever/stever_withdraw_request.dart';
import 'package:app/feature/wallet/staking/view/cancel_unstaking_page/cancel_unstaking_page_widget.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const walletCancelUnstakingRequestQueryParam = 'walletCancelUnstakingRequest';
const walletCancelUnstakingPublicKeyQueryParam =
    'walletCancelUnstakingPublicKey';
const walletCancelUnstakingAttachedFeeQueryParam =
    'walletCancelUnstakingStakingAttachedFee';
const walletCancelUnstakingExchangeRateQueryParam =
    'walletCancelUnstakingExchangeRate';
const walletCancelUnstakingStakingCurrencyCodeQueryParam =
    'walletCancelUnstakingStakingCurrencyCode';
const walletCancelUnstakingWithdrawHorsQueryParam =
    'walletCancelUnstakingWithdrawHors';
const walletCancelUnstakingTokenPriceQueryParam =
    'walletCancelUnstakingTokenPrice';
const walletCancelUnstakingEverPriceQueryParam =
    'walletCancelUnstakingEverPrice';

@singleton
class CancelUnstakingRoute extends CompassRoute<CancelUnstakingRouteData> {
  CancelUnstakingRoute({
    required this.tonWalletSendRoute,
  }) : super(
          name: 'wallet-cancel-unstaking',
          builder: (context, data, _) => CancelUnstakingPageWidget(
            request: data.request,
            accountKey: data.accountKey,
            attachedFee: data.attachedFee,
            exchangeRate: data.exchangeRate,
            stakeCurrency: data.stakeCurrency,
            withdrawHours: data.withdrawHours,
            tokenPrice: data.tokenPrice,
            everPrice: data.everPrice,
          ),
        );

  final TonWalletSendRoute tonWalletSendRoute;

  @override
  CancelUnstakingRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final requestJson = jsonDecode(
      queryParams[walletCancelUnstakingRequestQueryParam]!,
    ) as Map<String, dynamic>;

    final tokenPriceStr =
        queryParams[walletCancelUnstakingTokenPriceQueryParam];
    final everPriceStr = queryParams[walletCancelUnstakingEverPriceQueryParam];

    return CancelUnstakingRouteData(
      request: StEverWithdrawRequest.fromJson(requestJson),
      accountKey: PublicKey(
        publicKey: queryParams[walletCancelUnstakingPublicKeyQueryParam]!,
      ),
      attachedFee: BigInt.parse(
        queryParams[walletCancelUnstakingAttachedFeeQueryParam]!,
      ),
      exchangeRate: double.parse(
        queryParams[walletCancelUnstakingExchangeRateQueryParam]!,
      ),
      stakeCurrency: Currencies()[
          queryParams[walletCancelUnstakingStakingCurrencyCodeQueryParam]!]!,
      withdrawHours: int.parse(
        queryParams[walletCancelUnstakingWithdrawHorsQueryParam]!,
      ),
      tokenPrice: tokenPriceStr?.let(Fixed.tryParse),
      everPrice: everPriceStr?.let(Fixed.tryParse),
    );
  }
}

/// Data model for CancelUnstaking route
@freezed
class CancelUnstakingRouteData
    with _$CancelUnstakingRouteData
    implements CompassRouteDataQuery {
  const factory CancelUnstakingRouteData({
    /// StEver withdraw request
    required StEverWithdrawRequest request,

    /// Account public key
    required PublicKey accountKey,

    /// Attached fee
    required BigInt attachedFee,

    /// Exchange rate
    required double exchangeRate,

    /// Staking currency
    required Currency stakeCurrency,

    /// Withdraw hours
    required int withdrawHours,

    /// Token price (optional)
    Fixed? tokenPrice,

    /// Ever price (optional)
    Fixed? everPrice,
  }) = _CancelUnstakingRouteData;

  const CancelUnstakingRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final tokenPrice = this.tokenPrice;
    final everPrice = this.everPrice;

    return {
      walletCancelUnstakingRequestQueryParam: jsonEncode(request.toJson()),
      walletCancelUnstakingPublicKeyQueryParam: accountKey.publicKey,
      walletCancelUnstakingAttachedFeeQueryParam: attachedFee.toString(),
      walletCancelUnstakingExchangeRateQueryParam: exchangeRate.toString(),
      walletCancelUnstakingStakingCurrencyCodeQueryParam: stakeCurrency.isoCode,
      walletCancelUnstakingWithdrawHorsQueryParam: withdrawHours.toString(),
      if (tokenPrice != null)
        walletCancelUnstakingTokenPriceQueryParam: tokenPrice.toString(),
      if (everPrice != null)
        walletCancelUnstakingEverPriceQueryParam: everPrice.toString(),
    };
  }
}
