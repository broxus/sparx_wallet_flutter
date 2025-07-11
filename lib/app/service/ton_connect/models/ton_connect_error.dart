import 'package:app/app/service/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_connect_error.freezed.dart';
part 'ton_connect_error.g.dart';

@freezed
abstract class TonConnectError with _$TonConnectError {
  factory TonConnectError({
    required TonConnectErrorCode code,
    required String message,
  }) = _TonConnectError;

  factory TonConnectError.fromJson(Map<String, dynamic> json) =>
      _$TonConnectErrorFromJson(json);
}
