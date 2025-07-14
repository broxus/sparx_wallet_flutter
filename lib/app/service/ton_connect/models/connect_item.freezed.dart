// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectItem _$ConnectItemFromJson(Map<String, dynamic> json) {
  switch (json['name']) {
    case 'ton_addr':
      return TonAddressItem.fromJson(json);
    case 'ton_proof':
      return TonProofItem.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'name', 'ConnectItem', 'Invalid union type "${json['name']}"!');
  }
}

/// @nodoc
mixin _$ConnectItem {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() tonAddress,
    required TResult Function(String payload) tonProof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? tonAddress,
    TResult? Function(String payload)? tonProof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? tonAddress,
    TResult Function(String payload)? tonProof,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItem value) tonAddress,
    required TResult Function(TonProofItem value) tonProof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItem value)? tonAddress,
    TResult? Function(TonProofItem value)? tonProof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItem value)? tonAddress,
    TResult Function(TonProofItem value)? tonProof,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectItemCopyWith<$Res> {
  factory $ConnectItemCopyWith(
          ConnectItem value, $Res Function(ConnectItem) then) =
      _$ConnectItemCopyWithImpl<$Res, ConnectItem>;
}

/// @nodoc
class _$ConnectItemCopyWithImpl<$Res, $Val extends ConnectItem>
    implements $ConnectItemCopyWith<$Res> {
  _$ConnectItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TonAddressItemImplCopyWith<$Res> {
  factory _$$TonAddressItemImplCopyWith(_$TonAddressItemImpl value,
          $Res Function(_$TonAddressItemImpl) then) =
      __$$TonAddressItemImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TonAddressItemImplCopyWithImpl<$Res>
    extends _$ConnectItemCopyWithImpl<$Res, _$TonAddressItemImpl>
    implements _$$TonAddressItemImplCopyWith<$Res> {
  __$$TonAddressItemImplCopyWithImpl(
      _$TonAddressItemImpl _value, $Res Function(_$TonAddressItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$TonAddressItemImpl implements TonAddressItem {
  const _$TonAddressItemImpl({final String? $type})
      : $type = $type ?? 'ton_addr';

  factory _$TonAddressItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAddressItemImplFromJson(json);

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'ConnectItem.tonAddress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TonAddressItemImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() tonAddress,
    required TResult Function(String payload) tonProof,
  }) {
    return tonAddress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? tonAddress,
    TResult? Function(String payload)? tonProof,
  }) {
    return tonAddress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? tonAddress,
    TResult Function(String payload)? tonProof,
    required TResult orElse(),
  }) {
    if (tonAddress != null) {
      return tonAddress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItem value) tonAddress,
    required TResult Function(TonProofItem value) tonProof,
  }) {
    return tonAddress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItem value)? tonAddress,
    TResult? Function(TonProofItem value)? tonProof,
  }) {
    return tonAddress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItem value)? tonAddress,
    TResult Function(TonProofItem value)? tonProof,
    required TResult orElse(),
  }) {
    if (tonAddress != null) {
      return tonAddress(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAddressItemImplToJson(
      this,
    );
  }
}

abstract class TonAddressItem implements ConnectItem {
  const factory TonAddressItem() = _$TonAddressItemImpl;

  factory TonAddressItem.fromJson(Map<String, dynamic> json) =
      _$TonAddressItemImpl.fromJson;
}

/// @nodoc
abstract class _$$TonProofItemImplCopyWith<$Res> {
  factory _$$TonProofItemImplCopyWith(
          _$TonProofItemImpl value, $Res Function(_$TonProofItemImpl) then) =
      __$$TonProofItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String payload});
}

/// @nodoc
class __$$TonProofItemImplCopyWithImpl<$Res>
    extends _$ConnectItemCopyWithImpl<$Res, _$TonProofItemImpl>
    implements _$$TonProofItemImplCopyWith<$Res> {
  __$$TonProofItemImplCopyWithImpl(
      _$TonProofItemImpl _value, $Res Function(_$TonProofItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
  }) {
    return _then(_$TonProofItemImpl(
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonProofItemImpl implements TonProofItem {
  const _$TonProofItemImpl({required this.payload, final String? $type})
      : $type = $type ?? 'ton_proof';

  factory _$TonProofItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonProofItemImplFromJson(json);

  @override
  final String payload;

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'ConnectItem.tonProof(payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonProofItemImpl &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, payload);

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonProofItemImplCopyWith<_$TonProofItemImpl> get copyWith =>
      __$$TonProofItemImplCopyWithImpl<_$TonProofItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() tonAddress,
    required TResult Function(String payload) tonProof,
  }) {
    return tonProof(payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? tonAddress,
    TResult? Function(String payload)? tonProof,
  }) {
    return tonProof?.call(payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? tonAddress,
    TResult Function(String payload)? tonProof,
    required TResult orElse(),
  }) {
    if (tonProof != null) {
      return tonProof(payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItem value) tonAddress,
    required TResult Function(TonProofItem value) tonProof,
  }) {
    return tonProof(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItem value)? tonAddress,
    TResult? Function(TonProofItem value)? tonProof,
  }) {
    return tonProof?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItem value)? tonAddress,
    TResult Function(TonProofItem value)? tonProof,
    required TResult orElse(),
  }) {
    if (tonProof != null) {
      return tonProof(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonProofItemImplToJson(
      this,
    );
  }
}

abstract class TonProofItem implements ConnectItem {
  const factory TonProofItem({required final String payload}) =
      _$TonProofItemImpl;

  factory TonProofItem.fromJson(Map<String, dynamic> json) =
      _$TonProofItemImpl.fromJson;

  String get payload;

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonProofItemImplCopyWith<_$TonProofItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
