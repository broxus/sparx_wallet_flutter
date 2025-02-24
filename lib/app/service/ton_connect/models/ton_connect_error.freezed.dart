// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_connect_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TonConnectError _$TonConnectErrorFromJson(Map<String, dynamic> json) {
  return _TonConnectError.fromJson(json);
}

/// @nodoc
mixin _$TonConnectError {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this TonConnectError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonConnectErrorCopyWith<TonConnectError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonConnectErrorCopyWith<$Res> {
  factory $TonConnectErrorCopyWith(
          TonConnectError value, $Res Function(TonConnectError) then) =
      _$TonConnectErrorCopyWithImpl<$Res, TonConnectError>;
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class _$TonConnectErrorCopyWithImpl<$Res, $Val extends TonConnectError>
    implements $TonConnectErrorCopyWith<$Res> {
  _$TonConnectErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TonConnectErrorImplCopyWith<$Res>
    implements $TonConnectErrorCopyWith<$Res> {
  factory _$$TonConnectErrorImplCopyWith(_$TonConnectErrorImpl value,
          $Res Function(_$TonConnectErrorImpl) then) =
      __$$TonConnectErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$TonConnectErrorImplCopyWithImpl<$Res>
    extends _$TonConnectErrorCopyWithImpl<$Res, _$TonConnectErrorImpl>
    implements _$$TonConnectErrorImplCopyWith<$Res> {
  __$$TonConnectErrorImplCopyWithImpl(
      _$TonConnectErrorImpl _value, $Res Function(_$TonConnectErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$TonConnectErrorImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonConnectErrorImpl implements _TonConnectError {
  _$TonConnectErrorImpl({required this.code, required this.message});

  factory _$TonConnectErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonConnectErrorImplFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @override
  String toString() {
    return 'TonConnectError(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonConnectErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonConnectErrorImplCopyWith<_$TonConnectErrorImpl> get copyWith =>
      __$$TonConnectErrorImplCopyWithImpl<_$TonConnectErrorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TonConnectErrorImplToJson(
      this,
    );
  }
}

abstract class _TonConnectError implements TonConnectError {
  factory _TonConnectError(
      {required final int code,
      required final String message}) = _$TonConnectErrorImpl;

  factory _TonConnectError.fromJson(Map<String, dynamic> json) =
      _$TonConnectErrorImpl.fromJson;

  @override
  int get code;
  @override
  String get message;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonConnectErrorImplCopyWith<_$TonConnectErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
