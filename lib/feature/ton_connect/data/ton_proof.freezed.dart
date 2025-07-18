// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_proof.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonProof {
  /// 64-bit unix epoch time of the signing operation (seconds)
  String get timestamp;
  String get signature;
  String get payload;
  TonProofDomain get domain;

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonProofCopyWith<TonProof> get copyWith =>
      _$TonProofCopyWithImpl<TonProof>(this as TonProof, _$identity);

  /// Serializes this TonProof to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonProof &&
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

  @override
  String toString() {
    return 'TonProof(timestamp: $timestamp, signature: $signature, payload: $payload, domain: $domain)';
  }
}

/// @nodoc
abstract mixin class $TonProofCopyWith<$Res> {
  factory $TonProofCopyWith(TonProof value, $Res Function(TonProof) _then) =
      _$TonProofCopyWithImpl;
  @useResult
  $Res call(
      {String timestamp,
      String signature,
      String payload,
      TonProofDomain domain});

  $TonProofDomainCopyWith<$Res> get domain;
}

/// @nodoc
class _$TonProofCopyWithImpl<$Res> implements $TonProofCopyWith<$Res> {
  _$TonProofCopyWithImpl(this._self, this._then);

  final TonProof _self;
  final $Res Function(TonProof) _then;

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
    return _then(_self.copyWith(
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _self.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _self.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as TonProofDomain,
    ));
  }

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonProofDomainCopyWith<$Res> get domain {
    return $TonProofDomainCopyWith<$Res>(_self.domain, (value) {
      return _then(_self.copyWith(domain: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TonProof implements TonProof {
  const _TonProof(
      {required this.timestamp,
      required this.signature,
      required this.payload,
      required this.domain});
  factory _TonProof.fromJson(Map<String, dynamic> json) =>
      _$TonProofFromJson(json);

  /// 64-bit unix epoch time of the signing operation (seconds)
  @override
  final String timestamp;
  @override
  final String signature;
  @override
  final String payload;
  @override
  final TonProofDomain domain;

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TonProofCopyWith<_TonProof> get copyWith =>
      __$TonProofCopyWithImpl<_TonProof>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonProofToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TonProof &&
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

  @override
  String toString() {
    return 'TonProof(timestamp: $timestamp, signature: $signature, payload: $payload, domain: $domain)';
  }
}

/// @nodoc
abstract mixin class _$TonProofCopyWith<$Res>
    implements $TonProofCopyWith<$Res> {
  factory _$TonProofCopyWith(_TonProof value, $Res Function(_TonProof) _then) =
      __$TonProofCopyWithImpl;
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
class __$TonProofCopyWithImpl<$Res> implements _$TonProofCopyWith<$Res> {
  __$TonProofCopyWithImpl(this._self, this._then);

  final _TonProof _self;
  final $Res Function(_TonProof) _then;

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? timestamp = null,
    Object? signature = null,
    Object? payload = null,
    Object? domain = null,
  }) {
    return _then(_TonProof(
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _self.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _self.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as TonProofDomain,
    ));
  }

  /// Create a copy of TonProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonProofDomainCopyWith<$Res> get domain {
    return $TonProofDomainCopyWith<$Res>(_self.domain, (value) {
      return _then(_self.copyWith(domain: value));
    });
  }
}

// dart format on
