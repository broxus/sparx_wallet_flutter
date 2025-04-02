// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_proof.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TonProof _$TonProofFromJson(Map<String, dynamic> json) {
  return _TonProof.fromJson(json);
}

/// @nodoc
mixin _$TonProof {
  /// 64-bit unix epoch time of the signing operation (seconds)
  String get timestamp => throw _privateConstructorUsedError;
  String get signature => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  TonProofDomain get domain => throw _privateConstructorUsedError;

  /// Serializes this TonProof to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonProofCopyWith<TonProof> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonProofCopyWith<$Res> {
  factory $TonProofCopyWith(TonProof value, $Res Function(TonProof) then) =
      _$TonProofCopyWithImpl<$Res, TonProof>;
  @useResult
  $Res call(
      {String timestamp,
      String signature,
      String payload,
      TonProofDomain domain});

  $TonProofDomainCopyWith<$Res> get domain;
}

/// @nodoc
class _$TonProofCopyWithImpl<$Res, $Val extends TonProof>
    implements $TonProofCopyWith<$Res> {
  _$TonProofCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? signature = null,
    Object? payload = null,
    Object? domain = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as TonProofDomain,
    ) as $Val);
  }

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonProofDomainCopyWith<$Res> get domain {
    return $TonProofDomainCopyWith<$Res>(_value.domain, (value) {
      return _then(_value.copyWith(domain: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TonProofImplCopyWith<$Res>
    implements $TonProofCopyWith<$Res> {
  factory _$$TonProofImplCopyWith(
          _$TonProofImpl value, $Res Function(_$TonProofImpl) then) =
      __$$TonProofImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String timestamp,
      String signature,
      String payload,
      TonProofDomain domain});

  @override
  $TonProofDomainCopyWith<$Res> get domain;
}

/// @nodoc
class __$$TonProofImplCopyWithImpl<$Res>
    extends _$TonProofCopyWithImpl<$Res, _$TonProofImpl>
    implements _$$TonProofImplCopyWith<$Res> {
  __$$TonProofImplCopyWithImpl(
      _$TonProofImpl _value, $Res Function(_$TonProofImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? signature = null,
    Object? payload = null,
    Object? domain = null,
  }) {
    return _then(_$TonProofImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as TonProofDomain,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonProofImpl implements _TonProof {
  const _$TonProofImpl(
      {required this.timestamp,
      required this.signature,
      required this.payload,
      required this.domain});

  factory _$TonProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonProofImplFromJson(json);

  /// 64-bit unix epoch time of the signing operation (seconds)
  @override
  final String timestamp;
  @override
  final String signature;
  @override
  final String payload;
  @override
  final TonProofDomain domain;

  @override
  String toString() {
    return 'TonProof(timestamp: $timestamp, signature: $signature, payload: $payload, domain: $domain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonProofImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.domain, domain) || other.domain == domain));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, timestamp, signature, payload, domain);

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonProofImplCopyWith<_$TonProofImpl> get copyWith =>
      __$$TonProofImplCopyWithImpl<_$TonProofImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TonProofImplToJson(
      this,
    );
  }
}

abstract class _TonProof implements TonProof {
  const factory _TonProof(
      {required final String timestamp,
      required final String signature,
      required final String payload,
      required final TonProofDomain domain}) = _$TonProofImpl;

  factory _TonProof.fromJson(Map<String, dynamic> json) =
      _$TonProofImpl.fromJson;

  /// 64-bit unix epoch time of the signing operation (seconds)
  @override
  String get timestamp;
  @override
  String get signature;
  @override
  String get payload;
  @override
  TonProofDomain get domain;

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonProofImplCopyWith<_$TonProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
