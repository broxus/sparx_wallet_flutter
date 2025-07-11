// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_nft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendingNft {
  String get id;
  Address get collection;
  NetworkGroup get networkGroup;
  Address get owner;

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PendingNftCopyWith<PendingNft> get copyWith =>
      _$PendingNftCopyWithImpl<PendingNft>(this as PendingNft, _$identity);

  /// Serializes this PendingNft to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PendingNft &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, collection, networkGroup, owner);

  @override
  String toString() {
    return 'PendingNft(id: $id, collection: $collection, networkGroup: $networkGroup, owner: $owner)';
  }
}

/// @nodoc
abstract mixin class $PendingNftCopyWith<$Res> {
  factory $PendingNftCopyWith(
          PendingNft value, $Res Function(PendingNft) _then) =
      _$PendingNftCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      Address collection,
      NetworkGroup networkGroup,
      Address owner});

  $AddressCopyWith<$Res> get collection;
  $AddressCopyWith<$Res> get owner;
}

/// @nodoc
class _$PendingNftCopyWithImpl<$Res> implements $PendingNftCopyWith<$Res> {
  _$PendingNftCopyWithImpl(this._self, this._then);

  final PendingNft _self;
  final $Res Function(PendingNft) _then;

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? collection = null,
    Object? networkGroup = null,
    Object? owner = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      collection: null == collection
          ? _self.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Address,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as NetworkGroup,
      owner: null == owner
          ? _self.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get collection {
    return $AddressCopyWith<$Res>(_self.collection, (value) {
      return _then(_self.copyWith(collection: value));
    });
  }

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_self.owner, (value) {
      return _then(_self.copyWith(owner: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PendingNft implements PendingNft {
  _PendingNft(
      {required this.id,
      required this.collection,
      required this.networkGroup,
      required this.owner});
  factory _PendingNft.fromJson(Map<String, dynamic> json) =>
      _$PendingNftFromJson(json);

  @override
  final String id;
  @override
  final Address collection;
  @override
  final NetworkGroup networkGroup;
  @override
  final Address owner;

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PendingNftCopyWith<_PendingNft> get copyWith =>
      __$PendingNftCopyWithImpl<_PendingNft>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PendingNftToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PendingNft &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, collection, networkGroup, owner);

  @override
  String toString() {
    return 'PendingNft(id: $id, collection: $collection, networkGroup: $networkGroup, owner: $owner)';
  }
}

/// @nodoc
abstract mixin class _$PendingNftCopyWith<$Res>
    implements $PendingNftCopyWith<$Res> {
  factory _$PendingNftCopyWith(
          _PendingNft value, $Res Function(_PendingNft) _then) =
      __$PendingNftCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      Address collection,
      NetworkGroup networkGroup,
      Address owner});

  @override
  $AddressCopyWith<$Res> get collection;
  @override
  $AddressCopyWith<$Res> get owner;
}

/// @nodoc
class __$PendingNftCopyWithImpl<$Res> implements _$PendingNftCopyWith<$Res> {
  __$PendingNftCopyWithImpl(this._self, this._then);

  final _PendingNft _self;
  final $Res Function(_PendingNft) _then;

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? collection = null,
    Object? networkGroup = null,
    Object? owner = null,
  }) {
    return _then(_PendingNft(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      collection: null == collection
          ? _self.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Address,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as NetworkGroup,
      owner: null == owner
          ? _self.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get collection {
    return $AddressCopyWith<$Res>(_self.collection, (value) {
      return _then(_self.copyWith(collection: value));
    });
  }

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_self.owner, (value) {
      return _then(_self.copyWith(owner: value));
    });
  }
}

// dart format on
