// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NftSendState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NftSendState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NftSendState()';
  }
}

/// @nodoc
class $NftSendStateCopyWith<$Res> {
  $NftSendStateCopyWith(NftSendState _, $Res Function(NftSendState) __);
}

/// Adds pattern-matching-related methods to [NftSendState].
extension NftSendStatePatterns on NftSendState {
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
    TResult Function(NftSendStateError value)? error,
    TResult Function(NftSendStateReady value)? ready,
    TResult Function(NftSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NftSendStateError() when error != null:
        return error(_that);
      case NftSendStateReady() when ready != null:
        return ready(_that);
      case NftSendStateSending() when sending != null:
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
    required TResult Function(NftSendStateError value) error,
    required TResult Function(NftSendStateReady value) ready,
    required TResult Function(NftSendStateSending value) sending,
  }) {
    final _that = this;
    switch (_that) {
      case NftSendStateError():
        return error(_that);
      case NftSendStateReady():
        return ready(_that);
      case NftSendStateSending():
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
    TResult? Function(NftSendStateError value)? error,
    TResult? Function(NftSendStateReady value)? ready,
    TResult? Function(NftSendStateSending value)? sending,
  }) {
    final _that = this;
    switch (_that) {
      case NftSendStateError() when error != null:
        return error(_that);
      case NftSendStateReady() when ready != null:
        return ready(_that);
      case NftSendStateSending() when sending != null:
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
      case NftSendStateError() when error != null:
        return error(_that.error);
      case NftSendStateReady() when ready != null:
        return ready();
      case NftSendStateSending() when sending != null:
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
      case NftSendStateError():
        return error(_that.error);
      case NftSendStateReady():
        return ready();
      case NftSendStateSending():
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
      case NftSendStateError() when error != null:
        return error(_that.error);
      case NftSendStateReady() when ready != null:
        return ready();
      case NftSendStateSending() when sending != null:
        return sending(_that.canClose);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NftSendStateError implements NftSendState {
  const NftSendStateError({required this.error});

  final Object error;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NftSendStateErrorCopyWith<NftSendStateError> get copyWith =>
      _$NftSendStateErrorCopyWithImpl<NftSendStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NftSendStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'NftSendState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $NftSendStateErrorCopyWith<$Res>
    implements $NftSendStateCopyWith<$Res> {
  factory $NftSendStateErrorCopyWith(
          NftSendStateError value, $Res Function(NftSendStateError) _then) =
      _$NftSendStateErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$NftSendStateErrorCopyWithImpl<$Res>
    implements $NftSendStateErrorCopyWith<$Res> {
  _$NftSendStateErrorCopyWithImpl(this._self, this._then);

  final NftSendStateError _self;
  final $Res Function(NftSendStateError) _then;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(NftSendStateError(
      error: null == error ? _self.error : error,
    ));
  }
}

/// @nodoc

class NftSendStateReady implements NftSendState {
  const NftSendStateReady();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NftSendStateReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NftSendState.ready()';
  }
}

/// @nodoc

class NftSendStateSending implements NftSendState {
  const NftSendStateSending({required this.canClose});

  final bool canClose;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NftSendStateSendingCopyWith<NftSendStateSending> get copyWith =>
      _$NftSendStateSendingCopyWithImpl<NftSendStateSending>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NftSendStateSending &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  @override
  String toString() {
    return 'NftSendState.sending(canClose: $canClose)';
  }
}

/// @nodoc
abstract mixin class $NftSendStateSendingCopyWith<$Res>
    implements $NftSendStateCopyWith<$Res> {
  factory $NftSendStateSendingCopyWith(
          NftSendStateSending value, $Res Function(NftSendStateSending) _then) =
      _$NftSendStateSendingCopyWithImpl;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class _$NftSendStateSendingCopyWithImpl<$Res>
    implements $NftSendStateSendingCopyWith<$Res> {
  _$NftSendStateSendingCopyWithImpl(this._self, this._then);

  final NftSendStateSending _self;
  final $Res Function(NftSendStateSending) _then;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canClose = null,
  }) {
    return _then(NftSendStateSending(
      canClose: null == canClose
          ? _self.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
