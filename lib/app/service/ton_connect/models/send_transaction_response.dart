import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction_response.freezed.dart';
part 'send_transaction_response.g.dart';

@freezed
sealed class SendTransactionResponse with _$SendTransactionResponse {
  const factory SendTransactionResponse.success({
    required String id,
    required String result,
  }) = SendTransactionResponseSuccess;

  const factory SendTransactionResponse.error({
    required String id,
    required TonConnectError error,
  }) = SendTransactionResponseError;

  factory SendTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseFromJson(json);
}
