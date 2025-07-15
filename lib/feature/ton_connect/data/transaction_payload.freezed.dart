// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionPayload {
  List<TransactionPayloadMessage> get messages;
  @JsonKey(name: 'valid_until')
  int? get validUntil;
  TonNetwork? get network;
  Address? get from;

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionPayloadCopyWith<TransactionPayload> get copyWith =>
      _$TransactionPayloadCopyWithImpl<TransactionPayload>(
          this as TransactionPayload, _$identity);

  /// Serializes this TransactionPayload to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionPayload &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.from, from) || other.from == from));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(messages), validUntil, network, from);

  @override
  String toString() {
    return 'TransactionPayload(messages: $messages, validUntil: $validUntil, network: $network, from: $from)';
  }
}

/// @nodoc
abstract mixin class $TransactionPayloadCopyWith<$Res> {
  factory $TransactionPayloadCopyWith(
          TransactionPayload value, $Res Function(TransactionPayload) _then) =
      _$TransactionPayloadCopyWithImpl;
  @useResult
  $Res call(
      {List<TransactionPayloadMessage> messages,
      @JsonKey(name: 'valid_until') int? validUntil,
      TonNetwork? network,
      Address? from});

  $AddressCopyWith<$Res>? get from;
}

/// @nodoc
class _$TransactionPayloadCopyWithImpl<$Res>
    implements $TransactionPayloadCopyWith<$Res> {
  _$TransactionPayloadCopyWithImpl(this._self, this._then);

  final TransactionPayload _self;
  final $Res Function(TransactionPayload) _then;

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
    return _then(_self.copyWith(
      messages: null == messages
          ? _self.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<TransactionPayloadMessage>,
      validUntil: freezed == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as int?,
      network: freezed == network
          ? _self.network
          : network // ignore: cast_nullable_to_non_nullable
              as TonNetwork?,
      from: freezed == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get from {
    if (_self.from == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.from!, (value) {
      return _then(_self.copyWith(from: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionPayload implements TransactionPayload {
  _TransactionPayload(
      {required final List<TransactionPayloadMessage> messages,
      @JsonKey(name: 'valid_until') this.validUntil,
      this.network,
      this.from})
      : _messages = messages;
  factory _TransactionPayload.fromJson(Map<String, dynamic> json) =>
      _$TransactionPayloadFromJson(json);

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

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionPayloadCopyWith<_TransactionPayload> get copyWith =>
      __$TransactionPayloadCopyWithImpl<_TransactionPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionPayloadToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionPayload &&
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

  @override
  String toString() {
    return 'TransactionPayload(messages: $messages, validUntil: $validUntil, network: $network, from: $from)';
  }
}

/// @nodoc
abstract mixin class _$TransactionPayloadCopyWith<$Res>
    implements $TransactionPayloadCopyWith<$Res> {
  factory _$TransactionPayloadCopyWith(
          _TransactionPayload value, $Res Function(_TransactionPayload) _then) =
      __$TransactionPayloadCopyWithImpl;
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
class __$TransactionPayloadCopyWithImpl<$Res>
    implements _$TransactionPayloadCopyWith<$Res> {
  __$TransactionPayloadCopyWithImpl(this._self, this._then);

  final _TransactionPayload _self;
  final $Res Function(_TransactionPayload) _then;

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? validUntil = freezed,
    Object? network = freezed,
    Object? from = freezed,
  }) {
    return _then(_TransactionPayload(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<TransactionPayloadMessage>,
      validUntil: freezed == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as int?,
      network: freezed == network
          ? _self.network
          : network // ignore: cast_nullable_to_non_nullable
              as TonNetwork?,
      from: freezed == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  /// Create a copy of TransactionPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get from {
    if (_self.from == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.from!, (value) {
      return _then(_self.copyWith(from: value));
    });
  }
}

// dart format on
