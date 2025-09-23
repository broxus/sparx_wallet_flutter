import 'package:app/app/service/connection/group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'collection_meta.freezed.dart';

part 'collection_meta.g.dart';

@freezed
abstract class CollectionMeta with _$CollectionMeta {
  const factory CollectionMeta({
    required Address collection,
    required NetworkGroup networkGroup,
    @Default(true) bool isVisible,
  }) = _CollectionMeta;

  factory CollectionMeta.fromJson(Map<String, dynamic> json) =>
      _$CollectionMetaFromJson(json);
}
