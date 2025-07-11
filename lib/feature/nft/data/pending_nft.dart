import 'package:app/app/service/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'pending_nft.freezed.dart';
part 'pending_nft.g.dart';

@freezed
abstract class PendingNft with _$PendingNft {
  factory PendingNft({
    required String id,
    required Address collection,
    required NetworkGroup networkGroup,
    required Address owner,
  }) = _PendingNft;

  factory PendingNft.fromJson(Map<String, dynamic> json) =>
      _$PendingNftFromJson(json);
}
