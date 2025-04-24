import 'package:app/app/router/app_route.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_page.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_send_route_data.freezed.dart';

// TODO(LevitskiyDaniil): Move to TonWalletSendPage directory after refactoring.
@lazySingleton
class TonWalletSendRoute extends SparxRoute<TonWalletSendRouteData, bool> {
  @override
  late final appRoute = AppRoute.tonWalletSend;

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    final data = TonWalletSendRouteData.fromQueryParams(
      state.uri.queryParameters,
    );

    return TonWalletSendPage(data: data);
  }
}

/// Data model for TonWalletSend route
@freezed
class TonWalletSendRouteData
    with _$TonWalletSendRouteData
    implements RouteDataQuery {
  const factory TonWalletSendRouteData({
    /// Address of TonWallet that will be used to send funds
    required Address address,

    /// Custodian of [address] that will be initiator of transaction (for not
    /// multisig this is main key).
    required PublicKey publicKey,

    /// Address where funds should be sent
    required Address destination,

    /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
    /// [Fixed.minorUnits].
    required BigInt amount,

    /// If true - after transaction send screen will be popped with true-result
    /// else - navigate to wallet
    required bool popOnComplete,

    /// Ammount that will be just added to [amount]
    BigInt? attachedAmount,

    /// Comment for transaction
    String? comment,

    /// Transaction payload

    String? payload,

    /// Message that will be shown when transaction sending completed
    String? resultMessage,
  }) = _TonWalletSendRouteData;

  const TonWalletSendRouteData._();

  factory TonWalletSendRouteData.fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final attachedAmount = queryParams['attachedAmount'];

    return TonWalletSendRouteData(
      address: Address.fromJson(queryParams['address']!),
      publicKey: PublicKey.fromJson(queryParams['publicKey']!),
      destination: Address.fromJson(queryParams['destination']!),
      amount: BigInt.parse(queryParams['amount']!),
      popOnComplete: bool.parse(queryParams['popOnComplete']!),
      attachedAmount: attachedAmount?.let(BigInt.parse),
      comment: queryParams['comment'],
      payload: queryParams['payload'],
      resultMessage: queryParams['resultMessage'],
    );
  }

  @override
  Map<String, String> toQueryParams() {
    final comment = this.comment;
    final payload = this.payload;
    final resultMessage = this.resultMessage;
    final attachedAmount = this.attachedAmount;
    final popOnComplete = this.popOnComplete;

    return {
      'address': address.toJson(),
      'publicKey': publicKey.toJson(),
      'destination': destination.toJson(),
      'amount': amount.toString(),
      'popOnComplete': popOnComplete.toString(),
      if (attachedAmount != null) 'attachedAmount': attachedAmount.toString(),
      if (comment != null) 'comment': comment,
      if (payload != null) 'payload': payload,
      if (resultMessage != null) 'resultMessage': resultMessage,
    };
  }
}

abstract class SparxRoute<T extends RouteDataQuery, R> extends BaseRoute<T, R>
    with RouteDataQueryMixin<T, R> {}

/// Base route class to provide common navigation functionality
abstract class BaseRoute<T, R> {
  /// Get route for this navigator
  GoRoute get route;

  /// Convert route data to location string
  String toLocation(T data);

  /// Push the route onto navigation stack and return a value when popped
  Future<R?> push(BuildContext context, T data) {
    return context.push<R>(toLocation(data));
  }

  /// Navigate to this route replacing current route in the stack
  void go(BuildContext context, T data) {
    context.go(toLocation(data));
  }

  /// Navigate further in the flow (implementation depends on app needs)
  void goFurther(BuildContext context, T data) {
    context.go(toLocation(data));
  }
}

mixin RouteDataQueryMixin<T extends RouteDataQuery, R> on BaseRoute<T, R> {
  AppRoute get appRoute;

  Widget builder(
    BuildContext context,
    GoRouterState state,
  );

  @override
  late final route = GoRoute(
    path: appRoute.path,
    builder: builder,
  );

  @override
  String toLocation(T data) {
    return appRoute.pathWithData(
      queryParameters: data.toQueryParams(),
    );
  }
}

// ignore: one_member_abstracts
abstract interface class RouteDataQuery {
  /// Convert route data to query parameters
  Map<String, String> toQueryParams();
}
