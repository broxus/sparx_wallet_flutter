// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_nft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PendingNft _$PendingNftFromJson(Map<String, dynamic> json) {
  return _PendingNft.fromJson(json);
}

/// @nodoc
mixin _$PendingNft {
  String get id => throw _privateConstructorUsedError;
  Address get collection => throw _privateConstructorUsedError;
  String get networkGroup => throw _privateConstructorUsedError;
  Address get owner => throw _privateConstructorUsedError;

  /// Serializes this PendingNft to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingNftCopyWith<PendingNft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingNftCopyWith<$Res> {
  factory $PendingNftCopyWith(
          PendingNft value, $Res Function(PendingNft) then) =
      _$PendingNftCopyWithImpl<$Res, PendingNft>;
  @useResult
  $Res call(
      {String id, Address collection, String networkGroup, Address owner});

  $AddressCopyWith<$Res> get collection;
  $AddressCopyWith<$Res> get owner;
}

/// @nodoc
class _$PendingNftCopyWithImpl<$Res, $Val extends PendingNft>
    implements $PendingNftCopyWith<$Res> {
  _$PendingNftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Address,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get collection {
    return $AddressCopyWith<$Res>(_value.collection, (value) {
      return _then(_value.copyWith(collection: value) as $Val);
    });
  }

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PendingNftImplCopyWith<$Res>
    implements $PendingNftCopyWith<$Res> {
  factory _$$PendingNftImplCopyWith(
          _$PendingNftImpl value, $Res Function(_$PendingNftImpl) then) =
      __$$PendingNftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, Address collection, String networkGroup, Address owner});

  @override
  $AddressCopyWith<$Res> get collection;
  @override
  $AddressCopyWith<$Res> get owner;
}

/// @nodoc
class __$$PendingNftImplCopyWithImpl<$Res>
    extends _$PendingNftCopyWithImpl<$Res, _$PendingNftImpl>
    implements _$$PendingNftImplCopyWith<$Res> {
  __$$PendingNftImplCopyWithImpl(
      _$PendingNftImpl _value, $Res Function(_$PendingNftImpl) _then)
      : super(_value, _then);

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
    return _then(_$PendingNftImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Address,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingNftImpl implements _PendingNft {
  _$PendingNftImpl(
      {required this.id,
      required this.collection,
      required this.networkGroup,
      required this.owner});

  factory _$PendingNftImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingNftImplFromJson(json);

  @override
  final String id;
  @override
  final Address collection;
  @override
  final String networkGroup;
  @override
  final Address owner;

  @override
  String toString() {
    return 'PendingNft(id: $id, collection: $collection, networkGroup: $networkGroup, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingNftImpl &&
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

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingNftImplCopyWith<_$PendingNftImpl> get copyWith =>
      __$$PendingNftImplCopyWithImpl<_$PendingNftImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingNftImplToJson(
      this,
    );
  }
}

abstract class _PendingNft implements PendingNft {
  factory _PendingNft(
      {required final String id,
      required final Address collection,
      required final String networkGroup,
      required final Address owner}) = _$PendingNftImpl;

  factory _PendingNft.fromJson(Map<String, dynamic> json) =
      _$PendingNftImpl.fromJson;

  @override
  String get id;
  @override
  Address get collection;
  @override
  String get networkGroup;
  @override
  Address get owner;

  /// Create a copy of PendingNft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingNftImplCopyWith<_$PendingNftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
