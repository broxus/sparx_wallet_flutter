import 'package:app/feature/ton_connect/data/ton_network.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_data_payload.freezed.dart';
part 'sign_data_payload.g.dart';

/// https://github.com/ton-blockchain/ton-connect/blob/main/requests-responses.md#sign-data
@Freezed(unionKey: 'type')
sealed class SignDataPayload with _$SignDataPayload {
  @FreezedUnionValue('cell')
  const factory SignDataPayload.cell({
    required String schema,
    required String cell,
    TonNetwork? network,
    String? from,
  }) = SignDataPayloadCell;

  @FreezedUnionValue('text')
  const factory SignDataPayload.text({
    required String text,
    TonNetwork? network,
    String? from,
  }) = SignDataPayloadText;

  @FreezedUnionValue('binary')
  const factory SignDataPayload.binary({
    required String bytes,
    TonNetwork? network,
    String? from,
  }) = SignDataPayloadBinary;

  factory SignDataPayload.fromJson(Map<String, dynamic> json) =>
      _$SignDataPayloadFromJson(json);
}
