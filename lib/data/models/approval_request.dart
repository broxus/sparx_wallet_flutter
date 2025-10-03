import 'dart:async';

import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/data/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' show AddNetwork, Network;

part 'approval_request.freezed.dart';

@freezed
sealed class ApprovalRequest with _$ApprovalRequest {
  const factory ApprovalRequest.requestPermissions({
    required Uri origin,
    required List<Permission> permissions,
    required Completer<Permissions> completer,
  }) = ApprovalRequestPermissions;

  const factory ApprovalRequest.changeAccount({
    required Uri origin,
    required List<Permission> permissions,
    required Address? previousSelectedAccount,
    required Completer<Permissions> completer,
  }) = ApprovalRequestChangeAccount;

  const factory ApprovalRequest.addTip3Token({
    required Uri origin,
    required Address account,
    required TokenContractAsset details,
    required Completer<void> completer,
  }) = ApprovalRequestAddTip3Token;

  const factory ApprovalRequest.signData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required SignInputAuthLedger signInputAuthLedger,
    required Completer<SignInputAuth> completer,
  }) = ApprovalRequestSignData;

  const factory ApprovalRequest.encryptData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required Completer<SignInputAuth> completer,
  }) = ApprovalRequestEncryptData;

  const factory ApprovalRequest.decryptData({
    required Uri origin,
    required Address account,
    required PublicKey recipientPublicKey,
    required PublicKey sourcePublicKey,
    required Completer<SignInputAuth> completer,
  }) = ApprovalRequestDecryptData;

  const factory ApprovalRequest.callContractMethod({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required Address recipient,
    required FunctionCall payload,
    required SignInputAuthLedger signInputAuthLedger,
    required Completer<SignInputAuth> completer,
  }) = ApprovalRequestCallContractMethod;

  const factory ApprovalRequest.sendMessage({
    required Uri origin,
    required Address sender,
    required Address recipient,
    @amountJsonConverter required BigInt amount,
    required bool bounce,
    required FunctionCall? payload,
    required KnownPayload? knownPayload,
    required List<IgnoreTransactionTreeSimulationError>?
        ignoredComputePhaseCodes,
    required List<IgnoreTransactionTreeSimulationError>?
        ignoredActionPhaseCodes,
    required Completer<(PublicKey, SignInputAuth)> completer,
  }) = ApprovalRequestSendMessage;

  const factory ApprovalRequest.changeNetwork({
    required Uri origin,
    required int networkId,
    required List<Connection> connections,
    required Completer<TransportStrategy?> completer,
  }) = ApprovalRequestChangeNetwork;

  const factory ApprovalRequest.addNetwork({
    required Uri origin,
    required AddNetwork network,
    required bool switchNetwork,
    required Completer<Network?> completer,
  }) = ApprovalRequestAddNetwork;
}
