import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_event_success_payload.freezed.dart';
part 'connect_event_success_payload.g.dart';

@freezed
class ConnectEventSuccessPayload with _$ConnectEventSuccessPayload {
  const factory ConnectEventSuccessPayload({
    required List<ConnectItemReply> items,
    required DeviceInfo device,
  }) = _ConnectEventSuccessPayload;

  factory ConnectEventSuccessPayload.fromJson(Map<String, dynamic> json) =>
      _$ConnectEventSuccessPayloadFromJson(json);
}
