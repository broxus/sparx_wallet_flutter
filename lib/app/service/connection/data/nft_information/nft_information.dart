import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'nft_information.freezed.dart';
part 'nft_information.g.dart';

@freezed
abstract class NftInformation with _$NftInformation {
  const factory NftInformation({
    String? marketplaceUrl,
    String? apiBaseUrl,
    List<Address>? defaultCollections,
  }) = _NftInformation;

  factory NftInformation.fromJson(Map<String, dynamic> json) =>
      _$NftInformationFromJson(json);
}
