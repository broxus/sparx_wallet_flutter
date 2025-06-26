import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'sign_data_payload.freezed.dart';
part 'sign_data_payload.g.dart';

/// https://github.com/ton-blockchain/ton-connect/blob/main/requests-responses.md#sign-data-experimental
@freezed
abstract class SignDataPayload with _$SignDataPayload {
  factory SignDataPayload({
    @JsonKey(name: 'schema_crc') required int schema,
    required String cell,
    PublicKey? publicKey,
  }) = _SignDataPayload;

  factory SignDataPayload.fromJson(Map<String, dynamic> json) =>
      _$SignDataPayloadFromJson(json);
}
