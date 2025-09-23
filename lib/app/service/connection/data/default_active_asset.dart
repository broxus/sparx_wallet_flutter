import 'package:app/app/service/connection/json_converters/address_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'default_active_asset.freezed.dart';

part 'default_active_asset.g.dart';

@freezed
abstract class DefaultActiveAsset with _$DefaultActiveAsset {
  factory DefaultActiveAsset({
    @AddressStringConverter()
    required Address address,
  }) = _DefaultActiveAsset;

  factory DefaultActiveAsset.fromJson(Map<String, dynamic> json) =>
      _$DefaultActiveAssetFromJson(json);
}
