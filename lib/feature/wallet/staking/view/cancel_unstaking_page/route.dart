import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/stever/stever_withdraw_request.dart';
import 'package:app/feature/wallet/staking/view/cancel_unstaking_page/cancel_unstaking_page_widget.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _requestQueryParam = 'request';
const _publicKeyQueryParam = 'publicKey';
const _attachedFeeQueryParam = 'stakingAttachedFee';
const _exchangeRateQueryParam = 'exchangeRate';
const _stakingCurrencyCodeQueryParam = 'stakingCurrencyCode';
const _withdrawHorsQueryParam = 'withdrawHors';
const _tokenPriceQueryParam = 'tokenPrice';
const _everPriceQueryParam = 'everPrice';

@named
@Singleton(as: CompassBaseRoute)
class CancelUnstakingRoute extends CompassRoute<CancelUnstakingRouteData> {
  CancelUnstakingRoute(
    @Named.from(TonWalletSendRoute) CompassBaseRoute tonWalletSendRoute,
  ) : super(
        path: '/cancel-unstaking',
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
        compassBaseRoutes: [tonWalletSendRoute],
      );

  @override
  CancelUnstakingRouteData fromQueryParams(Map<String, String> queryParams) {
    final request = queryParams.require(_requestQueryParam);
    final publicKey = queryParams.require(_publicKeyQueryParam);
    final attachedFee = queryParams.require(_attachedFeeQueryParam);
    final exchangeRate = queryParams.require(_exchangeRateQueryParam);
    final stakingCurrencyCode = queryParams.require(
      _stakingCurrencyCodeQueryParam,
    );
    final withdrawHours = queryParams.require(_withdrawHorsQueryParam);
    final requestJson = jsonDecode(request) as Map<String, dynamic>;
    final stakeCurrency = Currencies()[stakingCurrencyCode];

    if (stakeCurrency == null) {
      throw ArgumentError.value(
        stakingCurrencyCode,
        _stakingCurrencyCodeQueryParam,
        'Unsupported currency code',
      );
    }

    final tokenPriceStr = queryParams[_tokenPriceQueryParam];
    final everPriceStr = queryParams[_everPriceQueryParam];

    return CancelUnstakingRouteData(
      request: StEverWithdrawRequest.fromJson(requestJson),
      accountKey: PublicKey(publicKey: publicKey),
      attachedFee: BigInt.parse(attachedFee),
      exchangeRate: double.parse(exchangeRate),
      stakeCurrency: stakeCurrency,
      withdrawHours: int.parse(withdrawHours),
      tokenPrice: tokenPriceStr?.let(Fixed.tryParse),
      everPrice: everPriceStr?.let(Fixed.tryParse),
    );
  }
}

class CancelUnstakingRouteData implements CompassRouteDataQuery {
  const CancelUnstakingRouteData({
    required this.request,
    required this.accountKey,
    required this.attachedFee,
    required this.exchangeRate,
    required this.stakeCurrency,
    required this.withdrawHours,
    this.tokenPrice,
    this.everPrice,
  });

  /// StEver withdraw request
  final StEverWithdrawRequest request;

  /// Account public key
  final PublicKey accountKey;

  /// Attached fee
  final BigInt attachedFee;

  /// Exchange rate
  final double exchangeRate;

  /// Staking currency
  final Currency stakeCurrency;

  /// Withdraw hours
  final int withdrawHours;

  /// Token price (optional)
  final Fixed? tokenPrice;

  /// Ever price (optional)
  final Fixed? everPrice;

  @override
  Map<String, String> toQueryParams() {
    final tokenPrice = this.tokenPrice;
    final everPrice = this.everPrice;

    return {
      _requestQueryParam: jsonEncode(request.toJson()),
      _publicKeyQueryParam: accountKey.publicKey,
      _attachedFeeQueryParam: attachedFee.toString(),
      _exchangeRateQueryParam: exchangeRate.toString(),
      _stakingCurrencyCodeQueryParam: stakeCurrency.isoCode,
      _withdrawHorsQueryParam: withdrawHours.toString(),
      if (tokenPrice != null) _tokenPriceQueryParam: tokenPrice.toString(),
      if (everPrice != null) _everPriceQueryParam: everPrice.toString(),
    };
  }
}
