import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'transaction_payload_message.freezed.dart';
part 'transaction_payload_message.g.dart';

@freezed
class TransactionPayloadMessage with _$TransactionPayloadMessage {
  factory TransactionPayloadMessage({
    required Address address,
    required String amount,
    String? payload,
    String? stateInit,
  }) = _TransactionPayloadMessage;

  factory TransactionPayloadMessage.fromJson(Map<String, dynamic> json) =>
      _$TransactionPayloadMessageFromJson(json);
}
