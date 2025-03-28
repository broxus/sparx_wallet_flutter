// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionPayload _$TransactionPayloadFromJson(Map<String, dynamic> json) {
  return _TransactionPayload.fromJson(json);
}

/// @nodoc
mixin _$TransactionPayload {
  List<TransactionPayloadMessage> get messages =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_until')
  int? get validUntil => throw _privateConstructorUsedError;
  TonNetwork? get network => throw _privateConstructorUsedError;
  Address? get from => throw _privateConstructorUsedError;

  /// Serializes this TransactionPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionPayloadCopyWith<TransactionPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionPayloadCopyWith<$Res> {
  factory $TransactionPayloadCopyWith(
          TransactionPayload value, $Res Function(TransactionPayload) then) =
      _$TransactionPayloadCopyWithImpl<$Res, TransactionPayload>;
  @useResult
  $Res call(
      {List<TransactionPayloadMessage> messages,
      @JsonKey(name: 'valid_until') int? validUntil,
      TonNetwork? network,
      Address? from});

  $AddressCopyWith<$Res>? get from;
}

/// @nodoc
class _$TransactionPayloadCopyWithImpl<$Res, $Val extends TransactionPayload>
    implements $TransactionPayloadCopyWith<$Res> {
  _$TransactionPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? validUntil = freezed,
    Object? network = freezed,
    Object? from = freezed,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<TransactionPayloadMessage>,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as int?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as TonNetwork?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Address?,
    ) as $Val);
  }

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get from {
    if (_value.from == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.from!, (value) {
      return _then(_value.copyWith(from: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionPayloadImplCopyWith<$Res>
    implements $TransactionPayloadCopyWith<$Res> {
  factory _$$TransactionPayloadImplCopyWith(_$TransactionPayloadImpl value,
          $Res Function(_$TransactionPayloadImpl) then) =
      __$$TransactionPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TransactionPayloadMessage> messages,
      @JsonKey(name: 'valid_until') int? validUntil,
      TonNetwork? network,
      Address? from});

  @override
  $AddressCopyWith<$Res>? get from;
}

/// @nodoc
class __$$TransactionPayloadImplCopyWithImpl<$Res>
    extends _$TransactionPayloadCopyWithImpl<$Res, _$TransactionPayloadImpl>
    implements _$$TransactionPayloadImplCopyWith<$Res> {
  __$$TransactionPayloadImplCopyWithImpl(_$TransactionPayloadImpl _value,
      $Res Function(_$TransactionPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? validUntil = freezed,
    Object? network = freezed,
    Object? from = freezed,
  }) {
    return _then(_$TransactionPayloadImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<TransactionPayloadMessage>,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as int?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as TonNetwork?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionPayloadImpl implements _TransactionPayload {
  _$TransactionPayloadImpl(
      {required final List<TransactionPayloadMessage> messages,
      @JsonKey(name: 'valid_until') this.validUntil,
      this.network,
      this.from})
      : _messages = messages;

  factory _$TransactionPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionPayloadImplFromJson(json);

  final List<TransactionPayloadMessage> _messages;
  @override
  List<TransactionPayloadMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey(name: 'valid_until')
  final int? validUntil;
  @override
  final TonNetwork? network;
  @override
  final Address? from;

  @override
  String toString() {
    return 'TransactionPayload(messages: $messages, validUntil: $validUntil, network: $network, from: $from)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionPayloadImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.from, from) || other.from == from));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      validUntil,
      network,
      from);

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionPayloadImplCopyWith<_$TransactionPayloadImpl> get copyWith =>
      __$$TransactionPayloadImplCopyWithImpl<_$TransactionPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionPayloadImplToJson(
      this,
    );
  }
}

abstract class _TransactionPayload implements TransactionPayload {
  factory _TransactionPayload(
      {required final List<TransactionPayloadMessage> messages,
      @JsonKey(name: 'valid_until') final int? validUntil,
      final TonNetwork? network,
      final Address? from}) = _$TransactionPayloadImpl;

  factory _TransactionPayload.fromJson(Map<String, dynamic> json) =
      _$TransactionPayloadImpl.fromJson;

  @override
  List<TransactionPayloadMessage> get messages;
  @override
  @JsonKey(name: 'valid_until')
  int? get validUntil;
  @override
  TonNetwork? get network;
  @override
  Address? get from;

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionPayloadImplCopyWith<_$TransactionPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
