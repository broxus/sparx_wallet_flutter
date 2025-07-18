// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_proof_domain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonProofDomain {
  num get lengthBytes;
  String get value;

  /// Create a copy of TonProofDomain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonProofDomainCopyWith<TonProofDomain> get copyWith =>
      _$TonProofDomainCopyWithImpl<TonProofDomain>(
          this as TonProofDomain, _$identity);

  /// Serializes this TonProofDomain to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonProofDomain &&
            (identical(other.lengthBytes, lengthBytes) ||
                other.lengthBytes == lengthBytes) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lengthBytes, value);

  @override
  String toString() {
    return 'TonProofDomain(lengthBytes: $lengthBytes, value: $value)';
  }
}

/// @nodoc
abstract mixin class $TonProofDomainCopyWith<$Res> {
  factory $TonProofDomainCopyWith(
          TonProofDomain value, $Res Function(TonProofDomain) _then) =
      _$TonProofDomainCopyWithImpl;
  @useResult
  $Res call({num lengthBytes, String value});
}

/// @nodoc
class _$TonProofDomainCopyWithImpl<$Res>
    implements $TonProofDomainCopyWith<$Res> {
  _$TonProofDomainCopyWithImpl(this._self, this._then);

  final TonProofDomain _self;
  final $Res Function(TonProofDomain) _then;

  /// Create a copy of TonProofDomain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lengthBytes = null,
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      lengthBytes: null == lengthBytes
          ? _self.lengthBytes
          : lengthBytes // ignore: cast_nullable_to_non_nullable
              as num,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TonProofDomain implements TonProofDomain {
  _TonProofDomain({required this.lengthBytes, required this.value});
  factory _TonProofDomain.fromJson(Map<String, dynamic> json) =>
      _$TonProofDomainFromJson(json);

  @override
  final num lengthBytes;
  @override
  final String value;

  /// Create a copy of TonProofDomain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TonProofDomainCopyWith<_TonProofDomain> get copyWith =>
      __$TonProofDomainCopyWithImpl<_TonProofDomain>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonProofDomainToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TonProofDomain &&
            (identical(other.lengthBytes, lengthBytes) ||
                other.lengthBytes == lengthBytes) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lengthBytes, value);

  @override
  String toString() {
    return 'TonProofDomain(lengthBytes: $lengthBytes, value: $value)';
  }
}

/// @nodoc
abstract mixin class _$TonProofDomainCopyWith<$Res>
    implements $TonProofDomainCopyWith<$Res> {
  factory _$TonProofDomainCopyWith(
          _TonProofDomain value, $Res Function(_TonProofDomain) _then) =
      __$TonProofDomainCopyWithImpl;
  @override
  @useResult
  $Res call({num lengthBytes, String value});
}

/// @nodoc
class __$TonProofDomainCopyWithImpl<$Res>
    implements _$TonProofDomainCopyWith<$Res> {
  __$TonProofDomainCopyWithImpl(this._self, this._then);

  final _TonProofDomain _self;
  final $Res Function(_TonProofDomain) _then;

  /// Create a copy of TonProofDomain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lengthBytes = null,
    Object? value = null,
  }) {
    return _then(_TonProofDomain(
      lengthBytes: null == lengthBytes
          ? _self.lengthBytes
          : lengthBytes // ignore: cast_nullable_to_non_nullable
              as num,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
