import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/app/service/ton_connect/session_crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_app_connection.freezed.dart';
part 'ton_app_connection.g.dart';

@Freezed(equal: false)
@immutable
sealed class TonAppConnection with _$TonAppConnection {
  const TonAppConnection._();

  const factory TonAppConnection.remote({
    required String clientId,
    required SessionCrypto sessionCrypto,
    required List<ConnectItemReply> replyItems,
    required Address walletAddress,
    required DappManifest manifest,
  }) = TonAppConnectionRemote;

  const factory TonAppConnection.injected({
    required String origin,
    required List<ConnectItemReply> replyItems,
    required Address walletAddress,
    required DappManifest manifest,
  }) = TonAppConnectionInjected;

  factory TonAppConnection.fromJson(Map<String, dynamic> json) =>
      _$TonAppConnectionFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TonAppConnection) return false;

    if (this is TonAppConnectionInjected && other is TonAppConnectionInjected) {
      final self = this as TonAppConnectionInjected;
      return self.origin == other.origin &&
          self.walletAddress == other.walletAddress;
    } else if (this is TonAppConnectionRemote &&
        other is TonAppConnectionRemote) {
      final self = this as TonAppConnectionRemote;
      return self.clientId == other.clientId &&
          self.sessionCrypto.sessionId == other.sessionCrypto.sessionId &&
          self.walletAddress == other.walletAddress;
    }
    return false;
  }

  @override
  int get hashCode {
    if (this is TonAppConnectionInjected) {
      final self = this as TonAppConnectionInjected;
      return Object.hash(
        runtimeType,
        self.origin,
        self.walletAddress,
      );
    } else if (this is TonAppConnectionRemote) {
      final self = this as TonAppConnectionRemote;
      return Object.hash(
        runtimeType,
        self.clientId,
        self.sessionCrypto.sessionId,
        self.walletAddress,
      );
    }
    return super.hashCode;
  }
}
