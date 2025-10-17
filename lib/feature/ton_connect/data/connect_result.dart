import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'connect_result.freezed.dart';

@freezed
sealed class ConnectResult with _$ConnectResult {
  factory ConnectResult.success({
    required KeyAccount account,
    required List<ConnectItemReply> replyItems,
    required DappManifest manifest,
  }) = ConnectResultSuccess;

  factory ConnectResult.error({required TonConnectError error}) =
      ConnectResultError;
}
