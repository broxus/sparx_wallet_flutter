import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/app/service/ton_connect/session_crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = TonAppConnectionRemote;

  const factory TonAppConnection.injected({
    required ConnectItemReply replyItems,
  }) = TonAppConnectionInjected;

  factory TonAppConnection.fromJson(Map<String, dynamic> json) =>
      _$TonAppConnectionFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TonAppConnection) return false;

    if (this is TonAppConnectionInjected && other is TonAppConnectionInjected) {
      return true;
    } else if (this is TonAppConnectionRemote &&
        other is TonAppConnectionRemote) {
      final self = this as TonAppConnectionRemote;
      return self.clientId == other.clientId &&
          self.sessionCrypto.sessionId == other.sessionCrypto.sessionId;
    }
    return false;
  }

  @override
  int get hashCode {
    if (this is TonAppConnectionInjected) {
      return 0;
    } else if (this is TonAppConnectionRemote) {
      final self = this as TonAppConnectionRemote;
      return Object.hash(
        runtimeType,
        self.clientId,
        self.sessionCrypto.sessionId,
      );
    }
    return super.hashCode;
  }
}
