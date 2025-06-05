// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionMeta _$CollectionMetaFromJson(Map<String, dynamic> json) {
  return _CollectionMeta.fromJson(json);
}

/// @nodoc
mixin _$CollectionMeta {
  Address get collection => throw _privateConstructorUsedError;
  String get networkGroup => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;

  /// Serializes this CollectionMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionMetaCopyWith<CollectionMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionMetaCopyWith<$Res> {
  factory $CollectionMetaCopyWith(
          CollectionMeta value, $Res Function(CollectionMeta) then) =
      _$CollectionMetaCopyWithImpl<$Res, CollectionMeta>;
  @useResult
  $Res call({Address collection, String networkGroup, bool isVisible});

  $AddressCopyWith<$Res> get collection;
}

/// @nodoc
class _$CollectionMetaCopyWithImpl<$Res, $Val extends CollectionMeta>
    implements $CollectionMetaCopyWith<$Res> {
  _$CollectionMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
    Object? networkGroup = null,
    Object? isVisible = null,
  }) {
    return _then(_value.copyWith(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Address,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of CollectionMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get collection {
    return $AddressCopyWith<$Res>(_value.collection, (value) {
      return _then(_value.copyWith(collection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CollectionMetaImplCopyWith<$Res>
    implements $CollectionMetaCopyWith<$Res> {
  factory _$$CollectionMetaImplCopyWith(_$CollectionMetaImpl value,
          $Res Function(_$CollectionMetaImpl) then) =
      __$$CollectionMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address collection, String networkGroup, bool isVisible});

  @override
  $AddressCopyWith<$Res> get collection;
}

/// @nodoc
class __$$CollectionMetaImplCopyWithImpl<$Res>
    extends _$CollectionMetaCopyWithImpl<$Res, _$CollectionMetaImpl>
    implements _$$CollectionMetaImplCopyWith<$Res> {
  __$$CollectionMetaImplCopyWithImpl(
      _$CollectionMetaImpl _value, $Res Function(_$CollectionMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
    Object? networkGroup = null,
    Object? isVisible = null,
  }) {
    return _then(_$CollectionMetaImpl(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Address,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionMetaImpl implements _CollectionMeta {
  const _$CollectionMetaImpl(
      {required this.collection,
      required this.networkGroup,
      this.isVisible = true});

  factory _$CollectionMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionMetaImplFromJson(json);

  @override
  final Address collection;
  @override
  final String networkGroup;
  @override
  @JsonKey()
  final bool isVisible;

  @override
  String toString() {
    return 'CollectionMeta(collection: $collection, networkGroup: $networkGroup, isVisible: $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionMetaImpl &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, collection, networkGroup, isVisible);

  /// Create a copy of CollectionMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionMetaImplCopyWith<_$CollectionMetaImpl> get copyWith =>
      __$$CollectionMetaImplCopyWithImpl<_$CollectionMetaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionMetaImplToJson(
      this,
    );
  }
}

abstract class _CollectionMeta implements CollectionMeta {
  const factory _CollectionMeta(
      {required final Address collection,
      required final String networkGroup,
      final bool isVisible}) = _$CollectionMetaImpl;

  factory _CollectionMeta.fromJson(Map<String, dynamic> json) =
      _$CollectionMetaImpl.fromJson;

  @override
  Address get collection;
  @override
  String get networkGroup;
  @override
  bool get isVisible;

  /// Create a copy of CollectionMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionMetaImplCopyWith<_$CollectionMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
