import 'package:app/feature/ton_connect/data/sign_data_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'sign_data_result.freezed.dart';
part 'sign_data_result.g.dart';

@freezed
abstract class SignDataResult with _$SignDataResult {
  factory SignDataResult({
    required String signature,
    required Address address,
    required int timestamp,
    required String domain,
    required SignDataPayload payload,
  }) = _SignDataResult;

  factory SignDataResult.fromJson(Map<String, dynamic> json) =>
      _$SignDataResultFromJson(json);
}
