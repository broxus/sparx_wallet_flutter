import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'nft_information.freezed.dart';
part 'nft_information.g.dart';

@freezed
class NftInformation with _$NftInformation {
  factory NftInformation({
    String? marketplaceUrl,
    List<Address>? defaultCollections,
  }) = _NftInformation;

  factory NftInformation.fromJson(Map<String, dynamic> json) =>
      _$NftInformationFromJson(json);
}
