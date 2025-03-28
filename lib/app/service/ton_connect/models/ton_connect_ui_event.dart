import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_connect_ui_event.freezed.dart';

@freezed
sealed class TonConnectUiEvent with _$TonConnectUiEvent {
  factory TonConnectUiEvent.error({
    required String message,
  }) = TonConnectUiEventError;

  factory TonConnectUiEvent.connect({
    required ConnectRequest request,
    required DappManifest manifest,
    required Completer<(KeyAccount, List<ConnectItemReply>)?> completer,
  }) = TonConnectUiEventConnect;

  factory TonConnectUiEvent.sendTransaction({
    required TonAppConnection connection,
    required TransactionPayload payload,
    required Completer<SignedMessage?> completer,
  }) = TonConnectUiEventSendTransaction;

  factory TonConnectUiEvent.signData({
    required TonAppConnection connection,
    required SignDataPayload payload,
    required Completer<SignDataResult?> completer,
  }) = TonConnectUiEventSignData;
}
