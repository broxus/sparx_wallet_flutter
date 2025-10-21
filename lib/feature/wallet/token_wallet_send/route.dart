import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/token_wallet_send/view/token_wallet_send_widget.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _ownerQueryParam = 'sendOwner';
const _contractQueryParam = 'sendContract';
const _publicKeyQueryParam = 'sendPublicKey';
const _commentQueryParam = 'sendComment';
const _destinationQueryParam = 'sendDestination';
const _amountQueryParam = 'sendAmount';
const _attachedAmountQueryParam = 'sendAttachedAmount';
const _resultMessageQueryParam = 'sendResultMessage';
const _notifyReceiverQueryParam = 'sendNotifyReceiver';

@named
@Singleton(as: CompassBaseRoute)
class TokenWalletSendRoute extends CompassRoute<TokenWalletSendRouteData> {
  TokenWalletSendRoute()
    : super(
        path: '/token-send',
        builder: (context, data, _) => TokenWalletSendWidget(
          owner: data.owner,
          rootTokenContract: data.rootTokenContract,
          publicKey: data.publicKey,
          destination: data.destination,
          amount: data.amount,
          attachedAmount: data.attachedAmount,
          comment: data.comment,
          resultMessage: data.resultMessage,
          notifyReceiver: data.notifyReceiver,
        ),
      );

  @override
  TokenWalletSendRouteData fromQueryParams(Map<String, String> queryParams) {
    final attachedAmountStr = queryParams[_attachedAmountQueryParam];
    final notifyReceiverStr = queryParams[_notifyReceiverQueryParam];

    return TokenWalletSendRouteData(
      owner: Address(address: queryParams[_ownerQueryParam]!),
      rootTokenContract: Address(address: queryParams[_contractQueryParam]!),
      publicKey: PublicKey(publicKey: queryParams[_publicKeyQueryParam]!),
      destination: Address(address: queryParams[_destinationQueryParam]!),
      amount: BigInt.parse(queryParams[_amountQueryParam]!),
      attachedAmount: attachedAmountStr?.let(BigInt.tryParse),
      comment: queryParams[_commentQueryParam],
      resultMessage: queryParams[_resultMessageQueryParam],
      notifyReceiver: notifyReceiverStr?.let(bool.tryParse),
    );
  }
}

class TokenWalletSendRouteData implements CompassRouteDataQuery {
  const TokenWalletSendRouteData({
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.amount,
    this.attachedAmount,
    this.comment,
    this.resultMessage,
    this.notifyReceiver,
  });

  /// Owner address
  final Address owner;

  /// Token contract address
  final Address rootTokenContract;

  /// Public key
  final PublicKey publicKey;

  /// Destination address
  final Address destination;

  /// Amount to send
  final BigInt amount;

  /// Attached amount (optional)
  final BigInt? attachedAmount;

  /// Comment for transaction (optional)
  final String? comment;

  /// Result message (optional)
  final String? resultMessage;

  /// Notify receiver flag (optional)
  final bool? notifyReceiver;

  @override
  Map<String, String> toQueryParams() {
    final attachedAmount = this.attachedAmount;
    final comment = this.comment;
    final resultMessage = this.resultMessage;
    final notifyReceiver = this.notifyReceiver;

    return {
      _ownerQueryParam: owner.address,
      _contractQueryParam: rootTokenContract.address,
      _publicKeyQueryParam: publicKey.publicKey,
      _destinationQueryParam: destination.address,
      _amountQueryParam: amount.toString(),
      if (attachedAmount != null)
        _attachedAmountQueryParam: attachedAmount.toString(),
      if (comment != null) _commentQueryParam: comment,
      if (resultMessage != null) _resultMessageQueryParam: resultMessage,
      if (notifyReceiver != null)
        _notifyReceiverQueryParam: notifyReceiver.toString(),
    };
  }
}
