import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'nft_list_request_dto.g.dart';

@JsonSerializable()
class NftListRequestDto {
  const NftListRequestDto({
    required this.owners,
    required this.collections,
    required this.limit,
    required this.offset,
    required this.verified,
  });

  factory NftListRequestDto.fromJson(Map<String, dynamic> json) =>
      _$NftListRequestDtoFromJson(json);

  final List<Address> owners;
  final List<Address> collections;
  final int limit;
  final int offset;
  final bool verified;

  Map<String, dynamic> toJson() => _$NftListRequestDtoToJson(this);
}
