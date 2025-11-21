import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

@freezed
abstract class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String platform,
    required String appName,
    required String appVersion,
    required int maxProtocolVersion,
    required List<dynamic> features,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}
