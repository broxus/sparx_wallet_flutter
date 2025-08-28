// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenWalletSendState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenWalletSendState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletSendState()';
  }
}

/// @nodoc
class $TokenWalletSendStateCopyWith<$Res> {
  $TokenWalletSendStateCopyWith(
      TokenWalletSendState _, $Res Function(TokenWalletSendState) __);
}

/// Adds pattern-matching-related methods to [TokenWalletSendState].
extension TokenWalletSendStatePatterns on TokenWalletSendState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenWalletSendStateError value)? error,
    TResult Function(TokenWalletSendStateReady value)? ready,
    TResult Function(TokenWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletSendStateError() when error != null:
        return error(_that);
      case TokenWalletSendStateReady() when ready != null:
        return ready(_that);
      case TokenWalletSendStateSending() when sending != null:
        return sending(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(TokenWalletSendStateError value) error,
    required TResult Function(TokenWalletSendStateReady value) ready,
    required TResult Function(TokenWalletSendStateSending value) sending,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletSendStateError():
        return error(_that);
      case TokenWalletSendStateReady():
        return ready(_that);
      case TokenWalletSendStateSending():
        return sending(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokenWalletSendStateError value)? error,
    TResult? Function(TokenWalletSendStateReady value)? ready,
    TResult? Function(TokenWalletSendStateSending value)? sending,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletSendStateError() when error != null:
        return error(_that);
      case TokenWalletSendStateReady() when ready != null:
        return ready(_that);
      case TokenWalletSendStateSending() when sending != null:
        return sending(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? error,
    TResult Function()? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletSendStateError() when error != null:
        return error(_that.error);
      case TokenWalletSendStateReady() when ready != null:
        return ready();
      case TokenWalletSendStateSending() when sending != null:
        return sending(_that.canClose);
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
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) error,
    required TResult Function() ready,
    required TResult Function(bool canClose) sending,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletSendStateError():
        return error(_that.error);
      case TokenWalletSendStateReady():
        return ready();
      case TokenWalletSendStateSending():
        return sending(_that.canClose);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Object error)? error,
    TResult? Function()? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletSendStateError() when error != null:
        return error(_that.error);
      case TokenWalletSendStateReady() when ready != null:
        return ready();
      case TokenWalletSendStateSending() when sending != null:
        return sending(_that.canClose);
      case _:
        return null;
    }
  }
}

/// @nodoc

class TokenWalletSendStateError implements TokenWalletSendState {
  const TokenWalletSendStateError({required this.error});

  final Object error;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletSendStateErrorCopyWith<TokenWalletSendStateError> get copyWith =>
      _$TokenWalletSendStateErrorCopyWithImpl<TokenWalletSendStateError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletSendStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'TokenWalletSendState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletSendStateErrorCopyWith<$Res>
    implements $TokenWalletSendStateCopyWith<$Res> {
  factory $TokenWalletSendStateErrorCopyWith(TokenWalletSendStateError value,
          $Res Function(TokenWalletSendStateError) _then) =
      _$TokenWalletSendStateErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$TokenWalletSendStateErrorCopyWithImpl<$Res>
    implements $TokenWalletSendStateErrorCopyWith<$Res> {
  _$TokenWalletSendStateErrorCopyWithImpl(this._self, this._then);

  final TokenWalletSendStateError _self;
  final $Res Function(TokenWalletSendStateError) _then;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(TokenWalletSendStateError(
      error: null == error ? _self.error : error,
    ));
  }
}

/// @nodoc

class TokenWalletSendStateReady implements TokenWalletSendState {
  const TokenWalletSendStateReady();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletSendStateReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletSendState.ready()';
  }
}

/// @nodoc

class TokenWalletSendStateSending implements TokenWalletSendState {
  const TokenWalletSendStateSending({required this.canClose});

  final bool canClose;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletSendStateSendingCopyWith<TokenWalletSendStateSending>
      get copyWith => _$TokenWalletSendStateSendingCopyWithImpl<
          TokenWalletSendStateSending>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletSendStateSending &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  @override
  String toString() {
    return 'TokenWalletSendState.sending(canClose: $canClose)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletSendStateSendingCopyWith<$Res>
    implements $TokenWalletSendStateCopyWith<$Res> {
  factory $TokenWalletSendStateSendingCopyWith(
          TokenWalletSendStateSending value,
          $Res Function(TokenWalletSendStateSending) _then) =
      _$TokenWalletSendStateSendingCopyWithImpl;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class _$TokenWalletSendStateSendingCopyWithImpl<$Res>
    implements $TokenWalletSendStateSendingCopyWith<$Res> {
  _$TokenWalletSendStateSendingCopyWithImpl(this._self, this._then);

  final TokenWalletSendStateSending _self;
  final $Res Function(TokenWalletSendStateSending) _then;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canClose = null,
  }) {
    return _then(TokenWalletSendStateSending(
      canClose: null == canClose
          ? _self.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
