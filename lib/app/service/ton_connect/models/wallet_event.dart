import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_event.freezed.dart';
part 'wallet_event.g.dart';

@Freezed(unionKey: 'event')
sealed class WalletEvent with _$WalletEvent {
  @FreezedUnionValue('connect')
  const factory WalletEvent.connectSuccess({
    required String id,
    required ConnectEventSuccessPayload payload,
  }) = ConnectEventSuccess;

  @FreezedUnionValue('connect_error')
  const factory WalletEvent.connectError({
    required String id,
    required TonConnectError payload,
  }) = ConnectEventError;

  @FreezedUnionValue('disconnect')
  const factory WalletEvent.disconnect({
    required String id,
    @Default({}) Map<String, dynamic> payload,
  }) = DisconnectEvent;

  factory WalletEvent.fromJson(Map<String, dynamic> json) =>
      _$WalletEventFromJson(json);
}
