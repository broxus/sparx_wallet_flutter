import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_widget.dart';
import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const tonWalletSendAddressQueryParam = 'address';
const tonWalletSendPublicKeyQueryParam = 'publicKey';
const tonWalletSendDestinationQueryParam = 'destination';
const tonWalletSendAmountQueryParam = 'amount';
const tonWalletSendPopOnCompleteQueryParam = 'popOnComplete';
const tonWalletSendAttachedAmountQueryParam = 'attachedAmount';
const tonWalletSendCommentQueryParam = 'comment';
const tonWalletSendPayloadQueryParam = 'payload';
const tonWalletSendResultMessageQueryParam = 'resultMessage';

@named
@Singleton(as: CompassBaseRoute)
class TonWalletSendRoute extends CompassRoute<TonWalletSendRouteData> {
  TonWalletSendRoute()
      : super(
          name: 'ton-wallet-send',
          builder: (context, data, _) => TonWalletSendWidget(data: data),
        );

  @override
  TonWalletSendRouteData fromQueryParams(Map<String, String> queryParams) {
    final attachedAmount = queryParams[tonWalletSendAttachedAmountQueryParam];

    return TonWalletSendRouteData(
      address: Address.fromJson(queryParams[tonWalletSendAddressQueryParam]!),
      publicKey:
          PublicKey.fromJson(queryParams[tonWalletSendPublicKeyQueryParam]!),
      destination:
          Address.fromJson(queryParams[tonWalletSendDestinationQueryParam]!),
      amount: BigInt.parse(queryParams[tonWalletSendAmountQueryParam]!),
      popOnComplete:
          bool.parse(queryParams[tonWalletSendPopOnCompleteQueryParam]!),
      attachedAmount: attachedAmount?.let(BigInt.parse),
      comment: queryParams[tonWalletSendCommentQueryParam],
      payload: queryParams[tonWalletSendPayloadQueryParam],
      resultMessage: queryParams[tonWalletSendResultMessageQueryParam],
    );
  }
}

/// Data model for TonWalletSend route
@freezed
class TonWalletSendRouteData
    with _$TonWalletSendRouteData
    implements CompassRouteDataQuery {
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

  @override
  Map<String, String> toQueryParams() {
    final comment = this.comment;
    final payload = this.payload;
    final resultMessage = this.resultMessage;
    final attachedAmount = this.attachedAmount;
    final popOnComplete = this.popOnComplete;

    return {
      tonWalletSendAddressQueryParam: address.toJson(),
      tonWalletSendPublicKeyQueryParam: publicKey.toJson(),
      tonWalletSendDestinationQueryParam: destination.toJson(),
      tonWalletSendAmountQueryParam: amount.toString(),
      tonWalletSendPopOnCompleteQueryParam: popOnComplete.toString(),
      if (attachedAmount != null)
        tonWalletSendAttachedAmountQueryParam: attachedAmount.toString(),
      if (comment != null) tonWalletSendCommentQueryParam: comment,
      if (payload != null) tonWalletSendPayloadQueryParam: payload,
      if (resultMessage != null)
        tonWalletSendResultMessageQueryParam: resultMessage,
    };
  }
}
