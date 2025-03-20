import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_connect_error.freezed.dart';
part 'ton_connect_error.g.dart';

@freezed
class TonConnectError with _$TonConnectError {
  factory TonConnectError({
    required int code,
    required String message,
  }) = _TonConnectError;

  factory TonConnectError.fromJson(Map<String, dynamic> json) =>
      _$TonConnectErrorFromJson(json);
}
