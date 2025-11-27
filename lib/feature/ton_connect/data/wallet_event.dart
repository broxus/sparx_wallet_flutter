import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_event.freezed.dart';
part 'wallet_event.g.dart';

@Freezed(unionKey: 'event')
sealed class WalletEvent with _$WalletEvent {
  @FreezedUnionValue('connect')
  const factory WalletEvent.connectSuccess({
    required int id,
    required ConnectEventSuccessPayload payload,
  }) = ConnectEventSuccess;

  @FreezedUnionValue('connect_error')
  const factory WalletEvent.connectError({
    required int id,
    required TonConnectError payload,
  }) = ConnectEventError;

  @FreezedUnionValue('disconnect')
  const factory WalletEvent.disconnect({
    required int id,
    @Default({}) Map<String, dynamic> payload,
  }) = DisconnectEvent;

  factory WalletEvent.fromJson(Map<String, dynamic> json) =>
      _$WalletEventFromJson(json);
}
