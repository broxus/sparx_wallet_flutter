// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_connect_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonConnectError {
  TonConnectErrorCode get code;
  String get message;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<TonConnectError> get copyWith =>
      _$TonConnectErrorCopyWithImpl<TonConnectError>(
          this as TonConnectError, _$identity);

  /// Serializes this TonConnectError to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonConnectError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @override
  String toString() {
    return 'TonConnectError(code: $code, message: $message)';
  }
}

/// @nodoc
abstract mixin class $TonConnectErrorCopyWith<$Res> {
  factory $TonConnectErrorCopyWith(
          TonConnectError value, $Res Function(TonConnectError) _then) =
      _$TonConnectErrorCopyWithImpl;
  @useResult
  $Res call({TonConnectErrorCode code, String message});
}

/// @nodoc
class _$TonConnectErrorCopyWithImpl<$Res>
    implements $TonConnectErrorCopyWith<$Res> {
  _$TonConnectErrorCopyWithImpl(this._self, this._then);

  final TonConnectError _self;
  final $Res Function(TonConnectError) _then;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as TonConnectErrorCode,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TonConnectError].
extension TonConnectErrorPatterns on TonConnectError {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TonConnectError value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TonConnectError() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TonConnectError value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonConnectError():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TonConnectError value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonConnectError() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(TonConnectErrorCode code, String message)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TonConnectError() when $default != null:
        return $default(_that.code, _that.message);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(TonConnectErrorCode code, String message) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonConnectError():
        return $default(_that.code, _that.message);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(TonConnectErrorCode code, String message)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonConnectError() when $default != null:
        return $default(_that.code, _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TonConnectError implements TonConnectError {
  _TonConnectError({required this.code, required this.message});
  factory _TonConnectError.fromJson(Map<String, dynamic> json) =>
      _$TonConnectErrorFromJson(json);

  @override
  final TonConnectErrorCode code;
  @override
  final String message;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TonConnectErrorCopyWith<_TonConnectError> get copyWith =>
      __$TonConnectErrorCopyWithImpl<_TonConnectError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonConnectErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TonConnectError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @override
  String toString() {
    return 'TonConnectError(code: $code, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$TonConnectErrorCopyWith<$Res>
    implements $TonConnectErrorCopyWith<$Res> {
  factory _$TonConnectErrorCopyWith(
          _TonConnectError value, $Res Function(_TonConnectError) _then) =
      __$TonConnectErrorCopyWithImpl;
  @override
  @useResult
  $Res call({TonConnectErrorCode code, String message});
}

/// @nodoc
class __$TonConnectErrorCopyWithImpl<$Res>
    implements _$TonConnectErrorCopyWith<$Res> {
  __$TonConnectErrorCopyWithImpl(this._self, this._then);

  final _TonConnectError _self;
  final $Res Function(_TonConnectError) _then;

  /// Create a copy of TonConnectError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_TonConnectError(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as TonConnectErrorCode,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
