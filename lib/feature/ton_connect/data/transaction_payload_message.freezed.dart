// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_payload_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionPayloadMessage {
  Address get address;
  String get amount;
  String? get payload;
  String? get stateInit;

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionPayloadMessageCopyWith<TransactionPayloadMessage> get copyWith =>
      _$TransactionPayloadMessageCopyWithImpl<TransactionPayloadMessage>(
          this as TransactionPayloadMessage, _$identity);

  /// Serializes this TransactionPayloadMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionPayloadMessage &&
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

  @override
  String toString() {
    return 'TransactionPayloadMessage(address: $address, amount: $amount, payload: $payload, stateInit: $stateInit)';
  }
}

/// @nodoc
abstract mixin class $TransactionPayloadMessageCopyWith<$Res> {
  factory $TransactionPayloadMessageCopyWith(TransactionPayloadMessage value,
          $Res Function(TransactionPayloadMessage) _then) =
      _$TransactionPayloadMessageCopyWithImpl;
  @useResult
  $Res call(
      {Address address, String amount, String? payload, String? stateInit});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$TransactionPayloadMessageCopyWithImpl<$Res>
    implements $TransactionPayloadMessageCopyWith<$Res> {
  _$TransactionPayloadMessageCopyWithImpl(this._self, this._then);

  final TransactionPayloadMessage _self;
  final $Res Function(TransactionPayloadMessage) _then;

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
    return _then(_self.copyWith(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
      stateInit: freezed == stateInit
          ? _self.stateInit
          : stateInit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionPayloadMessage implements TransactionPayloadMessage {
  _TransactionPayloadMessage(
      {required this.address,
      required this.amount,
      this.payload,
      this.stateInit});
  factory _TransactionPayloadMessage.fromJson(Map<String, dynamic> json) =>
      _$TransactionPayloadMessageFromJson(json);

  @override
  final Address address;
  @override
  final String amount;
  @override
  final String? payload;
  @override
  final String? stateInit;

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionPayloadMessageCopyWith<_TransactionPayloadMessage>
      get copyWith =>
          __$TransactionPayloadMessageCopyWithImpl<_TransactionPayloadMessage>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionPayloadMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionPayloadMessage &&
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

  @override
  String toString() {
    return 'TransactionPayloadMessage(address: $address, amount: $amount, payload: $payload, stateInit: $stateInit)';
  }
}

/// @nodoc
abstract mixin class _$TransactionPayloadMessageCopyWith<$Res>
    implements $TransactionPayloadMessageCopyWith<$Res> {
  factory _$TransactionPayloadMessageCopyWith(_TransactionPayloadMessage value,
          $Res Function(_TransactionPayloadMessage) _then) =
      __$TransactionPayloadMessageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Address address, String amount, String? payload, String? stateInit});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$TransactionPayloadMessageCopyWithImpl<$Res>
    implements _$TransactionPayloadMessageCopyWith<$Res> {
  __$TransactionPayloadMessageCopyWithImpl(this._self, this._then);

  final _TransactionPayloadMessage _self;
  final $Res Function(_TransactionPayloadMessage) _then;

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
    Object? amount = null,
    Object? payload = freezed,
    Object? stateInit = freezed,
  }) {
    return _then(_TransactionPayloadMessage(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
      stateInit: freezed == stateInit
          ? _self.stateInit
          : stateInit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TransactionPayloadMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

// dart format on
