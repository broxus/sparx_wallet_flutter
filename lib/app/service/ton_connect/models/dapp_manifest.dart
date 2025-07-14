import 'package:freezed_annotation/freezed_annotation.dart';

part 'dapp_manifest.freezed.dart';
part 'dapp_manifest.g.dart';

@freezed
class DappManifest with _$DappManifest {
  const factory DappManifest({
    required String url,
    required String name,
    required String iconUrl,
    String? termsOfUseUrl,
    String? privacyPolicyUrl,
  }) = _DappManifest;

  factory DappManifest.fromJson(Map<String, dynamic> json) =>
      _$DappManifestFromJson(json);
}
