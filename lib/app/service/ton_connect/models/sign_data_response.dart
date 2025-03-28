import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_data_response.freezed.dart';
part 'sign_data_response.g.dart';

@freezed
sealed class SignDataResponse with _$SignDataResponse {
  const factory SignDataResponse.success({
    required String id,
    required SignDataResult result,
  }) = SignDataResponseSuccess;

  const factory SignDataResponse.error({
    required String id,
    required TonConnectError error,
  }) = SignDataResponseError;

  factory SignDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SignDataResponseFromJson(json);
}
