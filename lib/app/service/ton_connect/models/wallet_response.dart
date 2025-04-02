import 'package:app/app/service/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_response.freezed.dart';
part 'wallet_response.g.dart';

@freezed
sealed class WalletResponse with _$WalletResponse {
  /// https://github.com/ton-blockchain/ton-connect/blob/main/requests-responses.md#structure
  ///
  /// [WalletResponseSuccess] model is not compatible
  /// with [SignDataResponseSuccess] model
  const factory WalletResponse.success({
    required String id,
    required String result,
  }) = WalletResponseSuccess;

  const factory WalletResponse.error({
    required String id,
    required TonConnectError error,
  }) = WalletResponseError;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);
}
