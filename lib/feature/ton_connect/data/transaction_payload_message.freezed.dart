// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_payload_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionPayloadMessage _$TransactionPayloadMessageFromJson(
    Map<String, dynamic> json) {
  return _TransactionPayloadMessage.fromJson(json);
}

/// @nodoc
mixin _$TransactionPayloadMessage {
  Address get address => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String? get payload => throw _privateConstructorUsedError;
  String? get stateInit => throw _privateConstructorUsedError;

  /// Serializes this TransactionPayloadMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionPayloadMessageCopyWith<TransactionPayloadMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionPayloadMessageCopyWith<$Res> {
  factory $TransactionPayloadMessageCopyWith(TransactionPayloadMessage value,
          $Res Function(TransactionPayloadMessage) then) =
      _$TransactionPayloadMessageCopyWithImpl<$Res, TransactionPayloadMessage>;
  @useResult
  $Res call(
      {Address address, String amount, String? payload, String? stateInit});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$TransactionPayloadMessageCopyWithImpl<$Res,
        $Val extends TransactionPayloadMessage>
    implements $TransactionPayloadMessageCopyWith<$Res> {
  _$TransactionPayloadMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? amount = null,
    Object? payload = freezed,
    Object? stateInit = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
      stateInit: freezed == stateInit
          ? _value.stateInit
          : stateInit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionPayloadMessageImplCopyWith<$Res>
    implements $TransactionPayloadMessageCopyWith<$Res> {
  factory _$$TransactionPayloadMessageImplCopyWith(
          _$TransactionPayloadMessageImpl value,
          $Res Function(_$TransactionPayloadMessageImpl) then) =
      __$$TransactionPayloadMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Address address, String amount, String? payload, String? stateInit});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$TransactionPayloadMessageImplCopyWithImpl<$Res>
    extends _$TransactionPayloadMessageCopyWithImpl<$Res,
        _$TransactionPayloadMessageImpl>
    implements _$$TransactionPayloadMessageImplCopyWith<$Res> {
  __$$TransactionPayloadMessageImplCopyWithImpl(
      _$TransactionPayloadMessageImpl _value,
      $Res Function(_$TransactionPayloadMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? amount = null,
    Object? payload = freezed,
    Object? stateInit = freezed,
  }) {
    return _then(_$TransactionPayloadMessageImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
      stateInit: freezed == stateInit
          ? _value.stateInit
          : stateInit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionPayloadMessageImpl implements _TransactionPayloadMessage {
  _$TransactionPayloadMessageImpl(
      {required this.address,
      required this.amount,
      this.payload,
      this.stateInit});

  factory _$TransactionPayloadMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionPayloadMessageImplFromJson(json);

  @override
  final Address address;
  @override
  final String amount;
  @override
  final String? payload;
  @override
  final String? stateInit;

  @override
  String toString() {
    return 'TransactionPayloadMessage(address: $address, amount: $amount, payload: $payload, stateInit: $stateInit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionPayloadMessageImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.stateInit, stateInit) ||
                other.stateInit == stateInit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, amount, payload, stateInit);

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionPayloadMessageImplCopyWith<_$TransactionPayloadMessageImpl>
      get copyWith => __$$TransactionPayloadMessageImplCopyWithImpl<
          _$TransactionPayloadMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionPayloadMessageImplToJson(
      this,
    );
  }
}

abstract class _TransactionPayloadMessage implements TransactionPayloadMessage {
  factory _TransactionPayloadMessage(
      {required final Address address,
      required final String amount,
      final String? payload,
      final String? stateInit}) = _$TransactionPayloadMessageImpl;

  factory _TransactionPayloadMessage.fromJson(Map<String, dynamic> json) =
      _$TransactionPayloadMessageImpl.fromJson;

  @override
  Address get address;
  @override
  String get amount;
  @override
  String? get payload;
  @override
  String? get stateInit;

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionPayloadMessageImplCopyWith<_$TransactionPayloadMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
