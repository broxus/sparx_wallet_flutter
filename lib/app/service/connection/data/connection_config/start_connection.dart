import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_connection.freezed.dart';

part 'start_connection.g.dart';

@freezed
abstract class StartConnectionData with _$StartConnectionData {
  const factory StartConnectionData({required String connectionId}) =
      _StartConnectionData;

  factory StartConnectionData.fromJson(Map<String, dynamic> json) =>
      _$StartConnectionDataFromJson(json);
}
