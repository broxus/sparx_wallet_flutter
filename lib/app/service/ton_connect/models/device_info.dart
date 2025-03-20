import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String platform,
    required String appName,
    required String appVersion,
    required int maxProtocolVersion,
    required List<Feature> features,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}
