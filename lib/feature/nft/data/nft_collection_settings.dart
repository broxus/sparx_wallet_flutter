import 'package:app/app/service/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'nft_collection_settings.freezed.dart';

part 'nft_collection_settings.g.dart';

@freezed
abstract class NftCollectionSettings with _$NftCollectionSettings {
  const factory NftCollectionSettings({
    required Address collection,
    required NetworkGroup networkGroup,
    @Default(true) bool isVisible,
  }) = _NftCollectionSettings;

  factory NftCollectionSettings.fromJson(Map<String, dynamic> json) =>
      _$NftCollectionSettingsFromJson(json);
}
