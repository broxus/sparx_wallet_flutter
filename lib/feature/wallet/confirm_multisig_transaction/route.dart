import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_widget.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _walletAddressQueryParam = 'address';
const _localCustodiansQueryParam = 'localCustodians';
const _transactionIdQueryParam = 'transactionId';
const _idHashQueryParam = 'idHash';
const _destinationQueryParam = 'destination';
const _amountQueryParam = 'amount';
const _commentQueryParam = 'comment';
const _resultMessageQueryParam = 'resultMessage';

@named
@Singleton(as: CompassBaseRoute)
class ConfirmMultisigTransactionRoute
    extends CompassRoute<ConfirmMultisigTransactionRouteData> {
  ConfirmMultisigTransactionRoute()
      : super(
          path: '/confirm-multisig-transaction',
          builder: (context, data, _) => ConfirmMultisigTransactionWidget(
            walletAddress: data.walletAddress,
            localCustodians: data.localCustodians,
            transactionId: data.transactionId,
            transactionIdHash: data.transactionIdHash,
            destination: data.destination,
            amount: data.amount,
            comment: data.comment,
            resultMessage: data.resultMessage,
          ),
        );

  @override
  ConfirmMultisigTransactionRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final decoded = (jsonDecode(
      queryParams[_localCustodiansQueryParam]!,
    ) as List<dynamic>)
        .cast<String>();

    return ConfirmMultisigTransactionRouteData(
      walletAddress: Address(
        address: queryParams[_walletAddressQueryParam]!,
      ),
      localCustodians: decoded.map((e) => PublicKey(publicKey: e)).toList(),
      transactionId: queryParams[_transactionIdQueryParam]!,
      transactionIdHash: queryParams[_idHashQueryParam],
      destination: Address(
        address: queryParams[_destinationQueryParam]!,
      ),
      amount: BigInt.parse(
        queryParams[_amountQueryParam]!,
      ),
      comment: queryParams[_commentQueryParam],
      resultMessage: queryParams[_resultMessageQueryParam],
    );
  }
}

class ConfirmMultisigTransactionRouteData implements CompassRouteDataQuery {
  const ConfirmMultisigTransactionRouteData({
    required this.walletAddress,
    required this.localCustodians,
    required this.transactionId,
    required this.amount,
    required this.destination,
    this.transactionIdHash,
    this.comment,
    this.resultMessage,
  });

  /// Address of wallet which will be used to confirm transaction
  final Address walletAddress;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  final List<PublicKey> localCustodians;

  /// Transaction that should be confirmed
  final String transactionId;

  /// Amount of transaction
  final BigInt amount;

  /// Destination where funds should be sent
  final Address destination;

  /// Transaction id hash
  final String? transactionIdHash;

  /// Comment of transaction
  final String? comment;

  final String? resultMessage;

  @override
  Map<String, String> toQueryParams() {
    return {
      _walletAddressQueryParam: walletAddress.address,
      _localCustodiansQueryParam: jsonEncode(
        localCustodians.map((e) => e.publicKey).toList(),
      ),
      _transactionIdQueryParam: transactionId,
      _destinationQueryParam: destination.address,
      _amountQueryParam: amount.toString(),
      if (transactionIdHash != null) _idHashQueryParam: transactionIdHash!,
      if (comment != null) _commentQueryParam: comment!,
      if (resultMessage != null) _resultMessageQueryParam: resultMessage!,
    };
  }
}
