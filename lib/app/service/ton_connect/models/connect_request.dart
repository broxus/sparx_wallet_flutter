import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_request.freezed.dart';
part 'connect_request.g.dart';

@freezed
abstract class ConnectRequest with _$ConnectRequest {
  factory ConnectRequest({
    required String manifestUrl,
    required List<ConnectItem> items,
  }) = _ConnectRequest;

  factory ConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectRequestFromJson(json);
}
