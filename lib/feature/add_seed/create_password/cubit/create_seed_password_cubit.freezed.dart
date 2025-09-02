// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_seed_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateSeedPasswordState {
  bool get isLoading;
  PasswordStatus get status;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateSeedPasswordStateCopyWith<CreateSeedPasswordState> get copyWith =>
      _$CreateSeedPasswordStateCopyWithImpl<CreateSeedPasswordState>(
          this as CreateSeedPasswordState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateSeedPasswordState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, status);

  @override
  String toString() {
    return 'CreateSeedPasswordState(isLoading: $isLoading, status: $status)';
  }
}

/// @nodoc
abstract mixin class $CreateSeedPasswordStateCopyWith<$Res> {
  factory $CreateSeedPasswordStateCopyWith(CreateSeedPasswordState value,
          $Res Function(CreateSeedPasswordState) _then) =
      _$CreateSeedPasswordStateCopyWithImpl;
  @useResult
  $Res call({bool isLoading, PasswordStatus status});
}

/// @nodoc
class _$CreateSeedPasswordStateCopyWithImpl<$Res>
    implements $CreateSeedPasswordStateCopyWith<$Res> {
  _$CreateSeedPasswordStateCopyWithImpl(this._self, this._then);

  final CreateSeedPasswordState _self;
  final $Res Function(CreateSeedPasswordState) _then;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PasswordStatus,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateSeedPasswordState].
extension CreateSeedPasswordStatePatterns on CreateSeedPasswordState {
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
    TResult Function(_CreateSeedPasswordState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateSeedPasswordState() when $default != null:
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
    TResult Function(_CreateSeedPasswordState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSeedPasswordState():
        return $default(_that);
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
    TResult? Function(_CreateSeedPasswordState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSeedPasswordState() when $default != null:
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
    TResult Function(bool isLoading, PasswordStatus status)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateSeedPasswordState() when $default != null:
        return $default(_that.isLoading, _that.status);
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
    TResult Function(bool isLoading, PasswordStatus status) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSeedPasswordState():
        return $default(_that.isLoading, _that.status);
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
    TResult? Function(bool isLoading, PasswordStatus status)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSeedPasswordState() when $default != null:
        return $default(_that.isLoading, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CreateSeedPasswordState implements CreateSeedPasswordState {
  const _CreateSeedPasswordState(
      {required this.isLoading, required this.status});

  @override
  final bool isLoading;
  @override
  final PasswordStatus status;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateSeedPasswordStateCopyWith<_CreateSeedPasswordState> get copyWith =>
      __$CreateSeedPasswordStateCopyWithImpl<_CreateSeedPasswordState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateSeedPasswordState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, status);

  @override
  String toString() {
    return 'CreateSeedPasswordState(isLoading: $isLoading, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$CreateSeedPasswordStateCopyWith<$Res>
    implements $CreateSeedPasswordStateCopyWith<$Res> {
  factory _$CreateSeedPasswordStateCopyWith(_CreateSeedPasswordState value,
          $Res Function(_CreateSeedPasswordState) _then) =
      __$CreateSeedPasswordStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoading, PasswordStatus status});
}

/// @nodoc
class __$CreateSeedPasswordStateCopyWithImpl<$Res>
    implements _$CreateSeedPasswordStateCopyWith<$Res> {
  __$CreateSeedPasswordStateCopyWithImpl(this._self, this._then);

  final _CreateSeedPasswordState _self;
  final $Res Function(_CreateSeedPasswordState) _then;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? status = null,
  }) {
    return _then(_CreateSeedPasswordState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PasswordStatus,
    ));
  }
}

// dart format on
