import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_request.freezed.dart';
part 'connect_request.g.dart';

@freezed
class ConnectRequest with _$ConnectRequest {
  factory ConnectRequest({
    required String manifestUrl,
    required List<ConnectItem> items,
  }) = _ConnectRequest;

  factory ConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectRequestFromJson(json);
}
