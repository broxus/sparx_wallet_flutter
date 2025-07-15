import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'transaction_payload.freezed.dart';
part 'transaction_payload.g.dart';

@freezed
abstract class TransactionPayload with _$TransactionPayload {
  factory TransactionPayload({
    required List<TransactionPayloadMessage> messages,
    @JsonKey(name: 'valid_until') int? validUntil,
    TonNetwork? network,
    Address? from,
  }) = _TransactionPayload;

  factory TransactionPayload.fromJson(Map<String, dynamic> json) =>
      _$TransactionPayloadFromJson(json);
}
