import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_event.freezed.dart';
part 'connect_event.g.dart';

@Freezed(unionKey: 'event')
sealed class ConnectEvent with _$ConnectEvent {
  @FreezedUnionValue('connect')
  const factory ConnectEvent.success({
    required num id,
    required ConnectEventSuccessPayload payload,
  }) = ConnectEventSuccess;

  @FreezedUnionValue('connect_error')
  const factory ConnectEvent.error() = ConnectEventError;

  factory ConnectEvent.fromJson(Map<String, dynamic> json) =>
      _$ConnectEventFromJson(json);
}
