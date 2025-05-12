import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/token_wallet_send/view/token_wallet_send_widget.dart';
import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const tokenWalletSendOwnerQueryParam = 'tokenWalletSendOwner';
const tokenWalletSendContractQueryParam = 'tokenWalletSendContract';
const tokenWalletSendPublicKeyQueryParam = 'tokenWalletSendPublicKey';
const tokenWalletSendCommentQueryParam = 'tokenWalletSendComment';
const tokenWalletSendDestinationQueryParam = 'tokenWalletSendDestination';
const tokenWalletSendAmountQueryParam = 'tokenWalletSendAmount';
const tokenWalletSendAttachedAmountQueryParam = 'tokenWalletSendAttachedAmount';
const tokenWalletSendResultMessageQueryParam = 'tokenWalletSendResultMessage';
const tokenWalletSendNotifyReceiverQueryParam = 'tokenWalletSendNotifyReceiver';

@singleton
class TokenWalletSendRoute
    extends CompassRoute<TokenWalletSendRouteData> {
  TokenWalletSendRoute()
      : super(
          name: 'token-wallet-send',
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
    final attachedAmountStr =
        queryParams[tokenWalletSendAttachedAmountQueryParam];
    final notifyReceiverStr =
        queryParams[tokenWalletSendNotifyReceiverQueryParam];

    return TokenWalletSendRouteData(
      owner: Address(
        address: queryParams[tokenWalletSendOwnerQueryParam]!,
      ),
      rootTokenContract: Address(
        address: queryParams[tokenWalletSendContractQueryParam]!,
      ),
      publicKey: PublicKey(
        publicKey: queryParams[tokenWalletSendPublicKeyQueryParam]!,
      ),
      destination: Address(
        address: queryParams[tokenWalletSendDestinationQueryParam]!,
      ),
      amount: BigInt.parse(
        queryParams[tokenWalletSendAmountQueryParam]!,
      ),
      attachedAmount: attachedAmountStr?.let(BigInt.tryParse),
      comment: queryParams[tokenWalletSendCommentQueryParam],
      resultMessage: queryParams[tokenWalletSendResultMessageQueryParam],
      notifyReceiver: notifyReceiverStr?.let(bool.tryParse),
    );
  }
}

/// Data model for TokenWalletSend route
@freezed
class TokenWalletSendRouteData
    with _$TokenWalletSendRouteData
    implements CompassRouteDataQuery {
  const factory TokenWalletSendRouteData({
    /// Owner address
    required Address owner,

    /// Token contract address
    required Address rootTokenContract,

    /// Public key
    required PublicKey publicKey,

    /// Destination address
    required Address destination,

    /// Amount to send
    required BigInt amount,

    /// Attached amount (optional)
    BigInt? attachedAmount,

    /// Comment for transaction (optional)
    String? comment,

    /// Result message (optional)
    String? resultMessage,

    /// Notify receiver flag (optional)
    bool? notifyReceiver,
  }) = _TokenWalletSendRouteData;

  const TokenWalletSendRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final attachedAmount = this.attachedAmount;
    final comment = this.comment;
    final resultMessage = this.resultMessage;
    final notifyReceiver = this.notifyReceiver;

    return {
      tokenWalletSendOwnerQueryParam: owner.address,
      tokenWalletSendContractQueryParam: rootTokenContract.address,
      tokenWalletSendPublicKeyQueryParam: publicKey.publicKey,
      tokenWalletSendDestinationQueryParam: destination.address,
      tokenWalletSendAmountQueryParam: amount.toString(),
      if (attachedAmount != null)
        tokenWalletSendAttachedAmountQueryParam: attachedAmount.toString(),
      if (comment != null) tokenWalletSendCommentQueryParam: comment,
      if (resultMessage != null)
        tokenWalletSendResultMessageQueryParam: resultMessage,
      if (notifyReceiver != null)
        tokenWalletSendNotifyReceiverQueryParam: notifyReceiver.toString(),
    };
  }
}
