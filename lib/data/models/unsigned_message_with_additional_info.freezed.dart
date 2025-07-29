// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unsigned_message_with_additional_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnsignedMessageWithAdditionalInfo {
  UnsignedMessage get message;
  String? get dst;
  @amountJsonConverter
  BigInt? get amount;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnsignedMessageWithAdditionalInfoCopyWith<UnsignedMessageWithAdditionalInfo>
      get copyWith => _$UnsignedMessageWithAdditionalInfoCopyWithImpl<
              UnsignedMessageWithAdditionalInfo>(
          this as UnsignedMessageWithAdditionalInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnsignedMessageWithAdditionalInfo &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dst, dst) || other.dst == dst) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, dst, amount);

  @override
  String toString() {
    return 'UnsignedMessageWithAdditionalInfo(message: $message, dst: $dst, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory $UnsignedMessageWithAdditionalInfoCopyWith(
          UnsignedMessageWithAdditionalInfo value,
          $Res Function(UnsignedMessageWithAdditionalInfo) _then) =
      _$UnsignedMessageWithAdditionalInfoCopyWithImpl;
  @useResult
  $Res call(
      {UnsignedMessage message,
      String? dst,
      @amountJsonConverter BigInt? amount});
}

/// @nodoc
class _$UnsignedMessageWithAdditionalInfoCopyWithImpl<$Res>
    implements $UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  _$UnsignedMessageWithAdditionalInfoCopyWithImpl(this._self, this._then);

  final UnsignedMessageWithAdditionalInfo _self;
  final $Res Function(UnsignedMessageWithAdditionalInfo) _then;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? dst = freezed,
    Object? amount = freezed,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as UnsignedMessage,
      dst: freezed == dst
          ? _self.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ));
  }
}

/// @nodoc

class _UnsignedMessageWithAdditionalInfo
    implements UnsignedMessageWithAdditionalInfo {
  const _UnsignedMessageWithAdditionalInfo(
      {required this.message, this.dst, @amountJsonConverter this.amount});

  @override
  final UnsignedMessage message;
  @override
  final String? dst;
  @override
  @amountJsonConverter
  final BigInt? amount;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnsignedMessageWithAdditionalInfoCopyWith<
          _UnsignedMessageWithAdditionalInfo>
      get copyWith => __$UnsignedMessageWithAdditionalInfoCopyWithImpl<
          _UnsignedMessageWithAdditionalInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnsignedMessageWithAdditionalInfo &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dst, dst) || other.dst == dst) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, dst, amount);

  @override
  String toString() {
    return 'UnsignedMessageWithAdditionalInfo(message: $message, dst: $dst, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$UnsignedMessageWithAdditionalInfoCopyWith<$Res>
    implements $UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory _$UnsignedMessageWithAdditionalInfoCopyWith(
          _UnsignedMessageWithAdditionalInfo value,
          $Res Function(_UnsignedMessageWithAdditionalInfo) _then) =
      __$UnsignedMessageWithAdditionalInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {UnsignedMessage message,
      String? dst,
      @amountJsonConverter BigInt? amount});
}

/// @nodoc
class __$UnsignedMessageWithAdditionalInfoCopyWithImpl<$Res>
    implements _$UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  __$UnsignedMessageWithAdditionalInfoCopyWithImpl(this._self, this._then);

  final _UnsignedMessageWithAdditionalInfo _self;
  final $Res Function(_UnsignedMessageWithAdditionalInfo) _then;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? dst = freezed,
    Object? amount = freezed,
  }) {
    return _then(_UnsignedMessageWithAdditionalInfo(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as UnsignedMessage,
      dst: freezed == dst
          ? _self.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ));
  }
}

// dart format on
