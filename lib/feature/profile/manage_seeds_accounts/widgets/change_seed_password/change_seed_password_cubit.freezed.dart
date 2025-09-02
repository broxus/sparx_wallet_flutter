// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_seed_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangeSeedPasswordState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChangeSeedPasswordState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChangeSeedPasswordState()';
  }
}

/// @nodoc
class $ChangeSeedPasswordStateCopyWith<$Res> {
  $ChangeSeedPasswordStateCopyWith(
      ChangeSeedPasswordState _, $Res Function(ChangeSeedPasswordState) __);
}

/// Adds pattern-matching-related methods to [ChangeSeedPasswordState].
extension ChangeSeedPasswordStatePatterns on ChangeSeedPasswordState {
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
    TResult Function(ChangeSeedPasswordStateInitial value)? initial,
    TResult Function(ChangeSeedPasswordStateError value)? error,
    TResult Function(ChangeSeedPasswordStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ChangeSeedPasswordStateInitial() when initial != null:
        return initial(_that);
      case ChangeSeedPasswordStateError() when error != null:
        return error(_that);
      case ChangeSeedPasswordStateCompleted() when completed != null:
        return completed(_that);
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
    required TResult Function(ChangeSeedPasswordStateInitial value) initial,
    required TResult Function(ChangeSeedPasswordStateError value) error,
    required TResult Function(ChangeSeedPasswordStateCompleted value) completed,
  }) {
    final _that = this;
    switch (_that) {
      case ChangeSeedPasswordStateInitial():
        return initial(_that);
      case ChangeSeedPasswordStateError():
        return error(_that);
      case ChangeSeedPasswordStateCompleted():
        return completed(_that);
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
    TResult? Function(ChangeSeedPasswordStateInitial value)? initial,
    TResult? Function(ChangeSeedPasswordStateError value)? error,
    TResult? Function(ChangeSeedPasswordStateCompleted value)? completed,
  }) {
    final _that = this;
    switch (_that) {
      case ChangeSeedPasswordStateInitial() when initial != null:
        return initial(_that);
      case ChangeSeedPasswordStateError() when error != null:
        return error(_that);
      case ChangeSeedPasswordStateCompleted() when completed != null:
        return completed(_that);
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
    TResult Function()? initial,
    TResult Function(String errorCode)? error,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ChangeSeedPasswordStateInitial() when initial != null:
        return initial();
      case ChangeSeedPasswordStateError() when error != null:
        return error(_that.errorCode);
      case ChangeSeedPasswordStateCompleted() when completed != null:
        return completed();
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
    required TResult Function() initial,
    required TResult Function(String errorCode) error,
    required TResult Function() completed,
  }) {
    final _that = this;
    switch (_that) {
      case ChangeSeedPasswordStateInitial():
        return initial();
      case ChangeSeedPasswordStateError():
        return error(_that.errorCode);
      case ChangeSeedPasswordStateCompleted():
        return completed();
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
    TResult? Function()? initial,
    TResult? Function(String errorCode)? error,
    TResult? Function()? completed,
  }) {
    final _that = this;
    switch (_that) {
      case ChangeSeedPasswordStateInitial() when initial != null:
        return initial();
      case ChangeSeedPasswordStateError() when error != null:
        return error(_that.errorCode);
      case ChangeSeedPasswordStateCompleted() when completed != null:
        return completed();
      case _:
        return null;
    }
  }
}

/// @nodoc

class ChangeSeedPasswordStateInitial implements ChangeSeedPasswordState {
  const ChangeSeedPasswordStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangeSeedPasswordStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChangeSeedPasswordState.initial()';
  }
}

/// @nodoc

class ChangeSeedPasswordStateError implements ChangeSeedPasswordState {
  const ChangeSeedPasswordStateError(this.errorCode);

  final String errorCode;

  /// Create a copy of ChangeSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChangeSeedPasswordStateErrorCopyWith<ChangeSeedPasswordStateError>
      get copyWith => _$ChangeSeedPasswordStateErrorCopyWithImpl<
          ChangeSeedPasswordStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangeSeedPasswordStateError &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorCode);

  @override
  String toString() {
    return 'ChangeSeedPasswordState.error(errorCode: $errorCode)';
  }
}

/// @nodoc
abstract mixin class $ChangeSeedPasswordStateErrorCopyWith<$Res>
    implements $ChangeSeedPasswordStateCopyWith<$Res> {
  factory $ChangeSeedPasswordStateErrorCopyWith(
          ChangeSeedPasswordStateError value,
          $Res Function(ChangeSeedPasswordStateError) _then) =
      _$ChangeSeedPasswordStateErrorCopyWithImpl;
  @useResult
  $Res call({String errorCode});
}

/// @nodoc
class _$ChangeSeedPasswordStateErrorCopyWithImpl<$Res>
    implements $ChangeSeedPasswordStateErrorCopyWith<$Res> {
  _$ChangeSeedPasswordStateErrorCopyWithImpl(this._self, this._then);

  final ChangeSeedPasswordStateError _self;
  final $Res Function(ChangeSeedPasswordStateError) _then;

  /// Create a copy of ChangeSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorCode = null,
  }) {
    return _then(ChangeSeedPasswordStateError(
      null == errorCode
          ? _self.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ChangeSeedPasswordStateCompleted implements ChangeSeedPasswordState {
  const ChangeSeedPasswordStateCompleted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangeSeedPasswordStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChangeSeedPasswordState.completed()';
  }
}

// dart format on
