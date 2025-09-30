// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_message_with_additional_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignedMessageWithAdditionalInfo {
  SignedMessage get message;
  String? get dst;
  BigInt? get amount;

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedMessageWithAdditionalInfoCopyWith<SignedMessageWithAdditionalInfo>
      get copyWith => _$SignedMessageWithAdditionalInfoCopyWithImpl<
              SignedMessageWithAdditionalInfo>(
          this as SignedMessageWithAdditionalInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedMessageWithAdditionalInfo &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dst, dst) || other.dst == dst) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, dst, amount);

  @override
  String toString() {
    return 'SignedMessageWithAdditionalInfo(message: $message, dst: $dst, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $SignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory $SignedMessageWithAdditionalInfoCopyWith(
          SignedMessageWithAdditionalInfo value,
          $Res Function(SignedMessageWithAdditionalInfo) _then) =
      _$SignedMessageWithAdditionalInfoCopyWithImpl;
  @useResult
  $Res call({SignedMessage message, String? dst, BigInt? amount});

  $SignedMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$SignedMessageWithAdditionalInfoCopyWithImpl<$Res>
    implements $SignedMessageWithAdditionalInfoCopyWith<$Res> {
  _$SignedMessageWithAdditionalInfoCopyWithImpl(this._self, this._then);

  final SignedMessageWithAdditionalInfo _self;
  final $Res Function(SignedMessageWithAdditionalInfo) _then;

  /// Create a copy of SignedMessageWithAdditionalInfo
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
              as SignedMessage,
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

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignedMessageCopyWith<$Res> get message {
    return $SignedMessageCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// @nodoc

class _SignedMessageWithAdditionalInfo
    implements SignedMessageWithAdditionalInfo {
  const _SignedMessageWithAdditionalInfo(
      {required this.message, this.dst, this.amount});

  @override
  final SignedMessage message;
  @override
  final String? dst;
  @override
  final BigInt? amount;

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignedMessageWithAdditionalInfoCopyWith<_SignedMessageWithAdditionalInfo>
      get copyWith => __$SignedMessageWithAdditionalInfoCopyWithImpl<
          _SignedMessageWithAdditionalInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignedMessageWithAdditionalInfo &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dst, dst) || other.dst == dst) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, dst, amount);

  @override
  String toString() {
    return 'SignedMessageWithAdditionalInfo(message: $message, dst: $dst, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$SignedMessageWithAdditionalInfoCopyWith<$Res>
    implements $SignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory _$SignedMessageWithAdditionalInfoCopyWith(
          _SignedMessageWithAdditionalInfo value,
          $Res Function(_SignedMessageWithAdditionalInfo) _then) =
      __$SignedMessageWithAdditionalInfoCopyWithImpl;
  @override
  @useResult
  $Res call({SignedMessage message, String? dst, BigInt? amount});

  @override
  $SignedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$SignedMessageWithAdditionalInfoCopyWithImpl<$Res>
    implements _$SignedMessageWithAdditionalInfoCopyWith<$Res> {
  __$SignedMessageWithAdditionalInfoCopyWithImpl(this._self, this._then);

  final _SignedMessageWithAdditionalInfo _self;
  final $Res Function(_SignedMessageWithAdditionalInfo) _then;

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? dst = freezed,
    Object? amount = freezed,
  }) {
    return _then(_SignedMessageWithAdditionalInfo(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as SignedMessage,
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

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignedMessageCopyWith<$Res> get message {
    return $SignedMessageCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

// dart format on
