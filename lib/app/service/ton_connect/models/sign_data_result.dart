import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_data_result.freezed.dart';
part 'sign_data_result.g.dart';

@freezed
abstract class SignDataResult with _$SignDataResult {
  factory SignDataResult({
    /// base64 encoded signature
    required String signature,

    /// UNIX timestamp in seconds (UTC) at the moment on creating the signature
    required String timestamp,
  }) = _SignDataResult;

  factory SignDataResult.fromJson(Map<String, dynamic> json) =>
      _$SignDataResultFromJson(json);
}
