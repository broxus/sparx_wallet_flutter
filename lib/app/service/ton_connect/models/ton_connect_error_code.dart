import 'package:json_annotation/json_annotation.dart';

/// https://github.com/ton-blockchain/ton-connect/blob/main/requests-responses.md
@JsonEnum()
enum TonConnectErrorCode {
  @JsonValue(0)
  unknownError,
  @JsonValue(1)
  badRequest,
  @JsonValue(2)
  appManifestNotFound,
  @JsonValue(3)
  appManifestContentError,
  @JsonValue(100)
  unknownApp,
  @JsonValue(300)
  userDeclined,
  @JsonValue(400)
  methodNotSupported,
}
