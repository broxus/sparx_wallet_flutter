import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_wokchain_data.freezed.dart';

part 'current_wokchain_data.g.dart';

@freezed
abstract class CurrentWokchainData with _$CurrentWokchainData {
  factory CurrentWokchainData({
    required String networkId,
    required String workchainId,
  }) = _CurrentWokchainData;

  factory CurrentWokchainData.fromJson(Map<String, dynamic> json) =>
      _$CurrentWokchainDataFromJson(json);
}
