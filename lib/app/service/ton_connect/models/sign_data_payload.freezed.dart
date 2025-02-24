// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignDataPayload _$SignDataPayloadFromJson(Map<String, dynamic> json) {
  return _SignDataPayload.fromJson(json);
}

/// @nodoc
mixin _$SignDataPayload {
  @JsonKey(name: 'schema_crc')
  int get schema => throw _privateConstructorUsedError;
  String get cell => throw _privateConstructorUsedError;
  PublicKey? get publicKey => throw _privateConstructorUsedError;

  /// Serializes this SignDataPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignDataPayloadCopyWith<SignDataPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignDataPayloadCopyWith<$Res> {
  factory $SignDataPayloadCopyWith(
          SignDataPayload value, $Res Function(SignDataPayload) then) =
      _$SignDataPayloadCopyWithImpl<$Res, SignDataPayload>;
  @useResult
  $Res call(
      {@JsonKey(name: 'schema_crc') int schema,
      String cell,
      PublicKey? publicKey});

  $PublicKeyCopyWith<$Res>? get publicKey;
}

/// @nodoc
class _$SignDataPayloadCopyWithImpl<$Res, $Val extends SignDataPayload>
    implements $SignDataPayloadCopyWith<$Res> {
  _$SignDataPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? cell = null,
    Object? publicKey = freezed,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as int,
      cell: null == cell
          ? _value.cell
          : cell // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: freezed == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey?,
    ) as $Val);
  }

  /// Create a copy of SignDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res>? get publicKey {
    if (_value.publicKey == null) {
      return null;
    }

    return $PublicKeyCopyWith<$Res>(_value.publicKey!, (value) {
      return _then(_value.copyWith(publicKey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignDataPayloadImplCopyWith<$Res>
    implements $SignDataPayloadCopyWith<$Res> {
  factory _$$SignDataPayloadImplCopyWith(_$SignDataPayloadImpl value,
          $Res Function(_$SignDataPayloadImpl) then) =
      __$$SignDataPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'schema_crc') int schema,
      String cell,
      PublicKey? publicKey});

  @override
  $PublicKeyCopyWith<$Res>? get publicKey;
}

/// @nodoc
class __$$SignDataPayloadImplCopyWithImpl<$Res>
    extends _$SignDataPayloadCopyWithImpl<$Res, _$SignDataPayloadImpl>
    implements _$$SignDataPayloadImplCopyWith<$Res> {
  __$$SignDataPayloadImplCopyWithImpl(
      _$SignDataPayloadImpl _value, $Res Function(_$SignDataPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? cell = null,
    Object? publicKey = freezed,
  }) {
    return _then(_$SignDataPayloadImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as int,
      cell: null == cell
          ? _value.cell
          : cell // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: freezed == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignDataPayloadImpl implements _SignDataPayload {
  _$SignDataPayloadImpl(
      {@JsonKey(name: 'schema_crc') required this.schema,
      required this.cell,
      this.publicKey});

  factory _$SignDataPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignDataPayloadImplFromJson(json);

  @override
  @JsonKey(name: 'schema_crc')
  final int schema;
  @override
  final String cell;
  @override
  final PublicKey? publicKey;

  @override
  String toString() {
    return 'SignDataPayload(schema: $schema, cell: $cell, publicKey: $publicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignDataPayloadImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.cell, cell) || other.cell == cell) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, schema, cell, publicKey);

  /// Create a copy of SignDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignDataPayloadImplCopyWith<_$SignDataPayloadImpl> get copyWith =>
      __$$SignDataPayloadImplCopyWithImpl<_$SignDataPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignDataPayloadImplToJson(
      this,
    );
  }
}

abstract class _SignDataPayload implements SignDataPayload {
  factory _SignDataPayload(
      {@JsonKey(name: 'schema_crc') required final int schema,
      required final String cell,
      final PublicKey? publicKey}) = _$SignDataPayloadImpl;

  factory _SignDataPayload.fromJson(Map<String, dynamic> json) =
      _$SignDataPayloadImpl.fromJson;

  @override
  @JsonKey(name: 'schema_crc')
  int get schema;
  @override
  String get cell;
  @override
  PublicKey? get publicKey;

  /// Create a copy of SignDataPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignDataPayloadImplCopyWith<_$SignDataPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
