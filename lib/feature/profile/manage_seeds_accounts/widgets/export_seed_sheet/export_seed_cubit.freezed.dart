// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_seed_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExportSeedState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExportSeedState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExportSeedState()';
  }
}

/// @nodoc
class $ExportSeedStateCopyWith<$Res> {
  $ExportSeedStateCopyWith(
      ExportSeedState _, $Res Function(ExportSeedState) __);
}

/// Adds pattern-matching-related methods to [ExportSeedState].
extension ExportSeedStatePatterns on ExportSeedState {
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
    TResult Function(ExportSeedStateInitial value)? initial,
    TResult Function(ExportSeedStateError value)? error,
    TResult Function(ExportSeedStateSuccess value)? success,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ExportSeedStateInitial() when initial != null:
        return initial(_that);
      case ExportSeedStateError() when error != null:
        return error(_that);
      case ExportSeedStateSuccess() when success != null:
        return success(_that);
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
    required TResult Function(ExportSeedStateInitial value) initial,
    required TResult Function(ExportSeedStateError value) error,
    required TResult Function(ExportSeedStateSuccess value) success,
  }) {
    final _that = this;
    switch (_that) {
      case ExportSeedStateInitial():
        return initial(_that);
      case ExportSeedStateError():
        return error(_that);
      case ExportSeedStateSuccess():
        return success(_that);
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
    TResult? Function(ExportSeedStateInitial value)? initial,
    TResult? Function(ExportSeedStateError value)? error,
    TResult? Function(ExportSeedStateSuccess value)? success,
  }) {
    final _that = this;
    switch (_that) {
      case ExportSeedStateInitial() when initial != null:
        return initial(_that);
      case ExportSeedStateError() when error != null:
        return error(_that);
      case ExportSeedStateSuccess() when success != null:
        return success(_that);
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
    TResult Function(String error)? error,
    TResult Function(List<String> phrase)? success,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ExportSeedStateInitial() when initial != null:
        return initial();
      case ExportSeedStateError() when error != null:
        return error(_that.error);
      case ExportSeedStateSuccess() when success != null:
        return success(_that.phrase);
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
    required TResult Function(String error) error,
    required TResult Function(List<String> phrase) success,
  }) {
    final _that = this;
    switch (_that) {
      case ExportSeedStateInitial():
        return initial();
      case ExportSeedStateError():
        return error(_that.error);
      case ExportSeedStateSuccess():
        return success(_that.phrase);
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
    TResult? Function(String error)? error,
    TResult? Function(List<String> phrase)? success,
  }) {
    final _that = this;
    switch (_that) {
      case ExportSeedStateInitial() when initial != null:
        return initial();
      case ExportSeedStateError() when error != null:
        return error(_that.error);
      case ExportSeedStateSuccess() when success != null:
        return success(_that.phrase);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ExportSeedStateInitial implements ExportSeedState {
  const ExportSeedStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExportSeedStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExportSeedState.initial()';
  }
}

/// @nodoc

class ExportSeedStateError implements ExportSeedState {
  const ExportSeedStateError(this.error);

  final String error;

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportSeedStateErrorCopyWith<ExportSeedStateError> get copyWith =>
      _$ExportSeedStateErrorCopyWithImpl<ExportSeedStateError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExportSeedStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'ExportSeedState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ExportSeedStateErrorCopyWith<$Res>
    implements $ExportSeedStateCopyWith<$Res> {
  factory $ExportSeedStateErrorCopyWith(ExportSeedStateError value,
          $Res Function(ExportSeedStateError) _then) =
      _$ExportSeedStateErrorCopyWithImpl;
  @useResult
  $Res call({String error});
}

/// @nodoc
class _$ExportSeedStateErrorCopyWithImpl<$Res>
    implements $ExportSeedStateErrorCopyWith<$Res> {
  _$ExportSeedStateErrorCopyWithImpl(this._self, this._then);

  final ExportSeedStateError _self;
  final $Res Function(ExportSeedStateError) _then;

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(ExportSeedStateError(
      null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ExportSeedStateSuccess implements ExportSeedState {
  const ExportSeedStateSuccess(final List<String> phrase) : _phrase = phrase;

  final List<String> _phrase;
  List<String> get phrase {
    if (_phrase is EqualUnmodifiableListView) return _phrase;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phrase);
  }

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportSeedStateSuccessCopyWith<ExportSeedStateSuccess> get copyWith =>
      _$ExportSeedStateSuccessCopyWithImpl<ExportSeedStateSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExportSeedStateSuccess &&
            const DeepCollectionEquality().equals(other._phrase, _phrase));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_phrase));

  @override
  String toString() {
    return 'ExportSeedState.success(phrase: $phrase)';
  }
}

/// @nodoc
abstract mixin class $ExportSeedStateSuccessCopyWith<$Res>
    implements $ExportSeedStateCopyWith<$Res> {
  factory $ExportSeedStateSuccessCopyWith(ExportSeedStateSuccess value,
          $Res Function(ExportSeedStateSuccess) _then) =
      _$ExportSeedStateSuccessCopyWithImpl;
  @useResult
  $Res call({List<String> phrase});
}

/// @nodoc
class _$ExportSeedStateSuccessCopyWithImpl<$Res>
    implements $ExportSeedStateSuccessCopyWith<$Res> {
  _$ExportSeedStateSuccessCopyWithImpl(this._self, this._then);

  final ExportSeedStateSuccess _self;
  final $Res Function(ExportSeedStateSuccess) _then;

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phrase = null,
  }) {
    return _then(ExportSeedStateSuccess(
      null == phrase
          ? _self._phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
