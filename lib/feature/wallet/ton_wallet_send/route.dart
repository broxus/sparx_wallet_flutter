import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_widget.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _addressQueryParam = 'address';
const _publicKeyQueryParam = 'publicKey';
const _destinationQueryParam = 'destination';
const _amountQueryParam = 'amount';
const _popOnCompleteQueryParam = 'popOnComplete';
const _attachedAmountQueryParam = 'attachedAmount';
const _commentQueryParam = 'comment';
const _payloadQueryParam = 'payload';
const _resultMessageQueryParam = 'resultMessage';

@named
@Singleton(as: CompassBaseRoute)
class TonWalletSendRoute extends CompassRoute<TonWalletSendRouteData> {
  TonWalletSendRoute()
    : super(
        path: '/ton-send',
        builder: (context, data, _) => TonWalletSendWidget(data: data),
      );

  @override
  TonWalletSendRouteData fromQueryParams(Map<String, String> queryParams) {
    final attachedAmount = queryParams[_attachedAmountQueryParam];

    return TonWalletSendRouteData(
      address: Address.fromJson(queryParams[_addressQueryParam]!),
      publicKey: PublicKey.fromJson(queryParams[_publicKeyQueryParam]!),
      destination: Address.fromJson(queryParams[_destinationQueryParam]!),
      amount: BigInt.parse(queryParams[_amountQueryParam]!),
      popOnComplete: bool.parse(queryParams[_popOnCompleteQueryParam]!),
      attachedAmount: attachedAmount?.let(BigInt.parse),
      comment: queryParams[_commentQueryParam],
      payload: queryParams[_payloadQueryParam],
      resultMessage: queryParams[_resultMessageQueryParam],
    );
  }
}

class TonWalletSendRouteData implements CompassRouteDataQuery {
  const TonWalletSendRouteData({
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.popOnComplete,
    this.attachedAmount,
    this.comment,
    this.payload,
    this.resultMessage,
  });

  /// Address of TonWallet that will be used to send funds
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where funds should be sent
  final Address destination;

  /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
  /// Fixed.minorUnits.
  final BigInt amount;

  /// If true - after transaction send screen will be popped with true-result
  /// else - navigate to wallet
  final bool popOnComplete;

  /// Ammount that will be just added to [amount]
  final BigInt? attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Transaction payload
  final String? payload;

  /// Message that will be shown when transaction sending completed
  final String? resultMessage;

  @override
  Map<String, String> toQueryParams() {
    final comment = this.comment;
    final payload = this.payload;
    final resultMessage = this.resultMessage;
    final attachedAmount = this.attachedAmount;
    final popOnComplete = this.popOnComplete;

    return {
      _addressQueryParam: address.toJson(),
      _publicKeyQueryParam: publicKey.toJson(),
      _destinationQueryParam: destination.toJson(),
      _amountQueryParam: amount.toString(),
      _popOnCompleteQueryParam: popOnComplete.toString(),
      if (attachedAmount != null)
        _attachedAmountQueryParam: attachedAmount.toString(),
      if (comment != null) _commentQueryParam: comment,
      if (payload != null) _payloadQueryParam: payload,
      if (resultMessage != null) _resultMessageQueryParam: resultMessage,
    };
  }
}
