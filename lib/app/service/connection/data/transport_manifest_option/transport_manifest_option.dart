import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_manifest_option.freezed.dart';

part 'transport_manifest_option.g.dart';

@Freezed(
  unionKey: 'type',
  unionValueCase: FreezedUnionCase.none,
  fallbackUnion: 'fromConnection',
)
sealed class TransportManifestOption with _$TransportManifestOption {
  const factory TransportManifestOption.fromConnection() =
      TransportManifestOptionFromConnection;

  factory TransportManifestOption.fromJson(Map<String, dynamic> json) =>
      _$TransportManifestOptionFromJson(json);
}
