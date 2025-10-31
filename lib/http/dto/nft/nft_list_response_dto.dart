import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'nft_list_response_dto.g.dart';

@JsonSerializable()
class NftListResponseDto {
  const NftListResponseDto({required this.totalCount, required this.items});

  factory NftListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NftListResponseDtoFromJson(json);

  final int totalCount;
  final List<NftItemDto> items;

  Map<String, dynamic> toJson() => _$NftListResponseDtoToJson(this);
}

@JsonSerializable()
class NftItemDto {
  const NftItemDto({
    required this.address,
    required this.collection,
    required this.owner,
    this.manager,
    this.name,
    this.description,
    this.nftId,
    this.image,
    this.mimetype,
    this.fullImage,
    this.fullImageMimetype,
  });

  factory NftItemDto.fromJson(Map<String, dynamic> json) =>
      _$NftItemDtoFromJson(json);

  final Address address;
  final Address collection;
  final Address owner;
  final Address? manager;
  final String? name;
  final String? description;
  final String? nftId;
  final String? image;
  final String? mimetype;
  final String? fullImage;
  final String? fullImageMimetype;

  Map<String, dynamic> toJson() => _$NftItemDtoToJson(this);
}
