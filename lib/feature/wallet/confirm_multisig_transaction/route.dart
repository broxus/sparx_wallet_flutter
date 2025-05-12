import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

const confirmMultisigTransactionWalletAddressQueryParam =
    'tonWalletConfirmTransactionAddress';
const confirmMultisigTransactionLocalCustodiansQueryParam =
    'tonWalletConfirmTransactionLocalCustodians';
const confirmMultisigTransactionTransactionIdQueryParam =
    'tonWalletConfirmTransactionTransactionId';
const confirmMultisigTransactionIdHashQueryParam =
    'tonWalletConfirmTransactionIdHash';
const confirmMultisigTransactionDestinationQueryParam =
    'tonWalletConfirmTransactionDestination';
const confirmMultisigTransactionAmountQueryParam =
    'tonWalletConfirmTransactionAmount';
const confirmMultisigTransactionCommentQueryParam =
    'tonWalletConfirmTransactionComment';

@singleton
class ConfirmMultisigTransactionRoute
    extends CompassRoute<ConfirmMultisigTransactionRouteData> {
  ConfirmMultisigTransactionRoute()
      : super(
          name: 'confirm-multisig-transaction',
          builder: (context, data, _) => ConfirmMultisigTransactionWidget(
            walletAddress: data.walletAddress,
            localCustodians: data.localCustodians,
            transactionId: data.transactionId,
            transactionIdHash: data.transactionIdHash,
            destination: data.destination,
            amount: data.amount,
            comment: data.comment,
          ),
        );

  @override
  ConfirmMultisigTransactionRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final decoded = (jsonDecode(
      queryParams[confirmMultisigTransactionLocalCustodiansQueryParam]!,
    ) as List<dynamic>)
        .cast<String>();

    return ConfirmMultisigTransactionRouteData(
      walletAddress: Address(
        address:
            queryParams[confirmMultisigTransactionWalletAddressQueryParam]!,
      ),
      localCustodians: decoded.map((e) => PublicKey(publicKey: e)).toList(),
      transactionId:
          queryParams[confirmMultisigTransactionTransactionIdQueryParam]!,
      transactionIdHash:
          queryParams[confirmMultisigTransactionIdHashQueryParam],
      destination: Address(
        address: queryParams[confirmMultisigTransactionDestinationQueryParam]!,
      ),
      amount: BigInt.parse(
        queryParams[confirmMultisigTransactionAmountQueryParam]!,
      ),
      comment: queryParams[confirmMultisigTransactionCommentQueryParam],
    );
  }
}

/// Data model for ConfirmMultisigTransaction route
@freezed
class ConfirmMultisigTransactionRouteData
    with _$ConfirmMultisigTransactionRouteData
    implements CompassRouteDataQuery {
  const factory ConfirmMultisigTransactionRouteData({
    /// Address of wallet which will be used to confirm transaction
    required Address walletAddress,

    /// Local custodians that CAN CONFIRM transaction (not all local)
    required List<PublicKey> localCustodians,

    /// Transaction that should be confirmed
    required String transactionId,

    /// Amount of transaction
    required BigInt amount,

    /// Destination where funds should be sent
    required Address destination,

    /// Transaction id hash
    String? transactionIdHash,

    /// Comment of transaction
    String? comment,
  }) = _ConfirmMultisigTransactionRouteData;

  const ConfirmMultisigTransactionRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final params = {
      confirmMultisigTransactionWalletAddressQueryParam: walletAddress.address,
      confirmMultisigTransactionLocalCustodiansQueryParam: jsonEncode(
        localCustodians.map((e) => e.publicKey).toList(),
      ),
      confirmMultisigTransactionTransactionIdQueryParam: transactionId,
      confirmMultisigTransactionDestinationQueryParam: destination.address,
      confirmMultisigTransactionAmountQueryParam: amount.toString(),
    };

    if (transactionIdHash != null) {
      params[confirmMultisigTransactionIdHashQueryParam] = transactionIdHash!;
    }

    if (comment != null) {
      params[confirmMultisigTransactionCommentQueryParam] = comment!;
    }

    return params;
  }
}
