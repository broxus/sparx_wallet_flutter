// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enter_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EnterPasswordState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnterPasswordState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState()';
  }
}

/// @nodoc
class $EnterPasswordStateCopyWith<$Res> {
  $EnterPasswordStateCopyWith(
      EnterPasswordState _, $Res Function(EnterPasswordState) __);
}

/// Adds pattern-matching-related methods to [EnterPasswordState].
extension EnterPasswordStatePatterns on EnterPasswordState {
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
    TResult Function(EnterPasswordStateBiometry value)? biometry,
    TResult Function(EnterPasswordStatePassword value)? password,
    TResult Function(EnterPasswordStateLedger value)? ledger,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EnterPasswordStateBiometry() when biometry != null:
        return biometry(_that);
      case EnterPasswordStatePassword() when password != null:
        return password(_that);
      case EnterPasswordStateLedger() when ledger != null:
        return ledger(_that);
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
    required TResult Function(EnterPasswordStateBiometry value) biometry,
    required TResult Function(EnterPasswordStatePassword value) password,
    required TResult Function(EnterPasswordStateLedger value) ledger,
  }) {
    final _that = this;
    switch (_that) {
      case EnterPasswordStateBiometry():
        return biometry(_that);
      case EnterPasswordStatePassword():
        return password(_that);
      case EnterPasswordStateLedger():
        return ledger(_that);
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
    TResult? Function(EnterPasswordStateBiometry value)? biometry,
    TResult? Function(EnterPasswordStatePassword value)? password,
    TResult? Function(EnterPasswordStateLedger value)? ledger,
  }) {
    final _that = this;
    switch (_that) {
      case EnterPasswordStateBiometry() when biometry != null:
        return biometry(_that);
      case EnterPasswordStatePassword() when password != null:
        return password(_that);
      case EnterPasswordStateLedger() when ledger != null:
        return ledger(_that);
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
    TResult Function(bool isFace)? biometry,
    TResult Function()? password,
    TResult Function()? ledger,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EnterPasswordStateBiometry() when biometry != null:
        return biometry(_that.isFace);
      case EnterPasswordStatePassword() when password != null:
        return password();
      case EnterPasswordStateLedger() when ledger != null:
        return ledger();
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
    required TResult Function(bool isFace) biometry,
    required TResult Function() password,
    required TResult Function() ledger,
  }) {
    final _that = this;
    switch (_that) {
      case EnterPasswordStateBiometry():
        return biometry(_that.isFace);
      case EnterPasswordStatePassword():
        return password();
      case EnterPasswordStateLedger():
        return ledger();
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
    TResult? Function(bool isFace)? biometry,
    TResult? Function()? password,
    TResult? Function()? ledger,
  }) {
    final _that = this;
    switch (_that) {
      case EnterPasswordStateBiometry() when biometry != null:
        return biometry(_that.isFace);
      case EnterPasswordStatePassword() when password != null:
        return password();
      case EnterPasswordStateLedger() when ledger != null:
        return ledger();
      case _:
        return null;
    }
  }
}

/// @nodoc

class EnterPasswordStateBiometry implements EnterPasswordState {
  const EnterPasswordStateBiometry({required this.isFace});

  final bool isFace;

  /// Create a copy of EnterPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnterPasswordStateBiometryCopyWith<EnterPasswordStateBiometry>
      get copyWith =>
          _$EnterPasswordStateBiometryCopyWithImpl<EnterPasswordStateBiometry>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnterPasswordStateBiometry &&
            (identical(other.isFace, isFace) || other.isFace == isFace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFace);

  @override
  String toString() {
    return 'EnterPasswordState.biometry(isFace: $isFace)';
  }
}

/// @nodoc
abstract mixin class $EnterPasswordStateBiometryCopyWith<$Res>
    implements $EnterPasswordStateCopyWith<$Res> {
  factory $EnterPasswordStateBiometryCopyWith(EnterPasswordStateBiometry value,
          $Res Function(EnterPasswordStateBiometry) _then) =
      _$EnterPasswordStateBiometryCopyWithImpl;
  @useResult
  $Res call({bool isFace});
}

/// @nodoc
class _$EnterPasswordStateBiometryCopyWithImpl<$Res>
    implements $EnterPasswordStateBiometryCopyWith<$Res> {
  _$EnterPasswordStateBiometryCopyWithImpl(this._self, this._then);

  final EnterPasswordStateBiometry _self;
  final $Res Function(EnterPasswordStateBiometry) _then;

  /// Create a copy of EnterPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFace = null,
  }) {
    return _then(EnterPasswordStateBiometry(
      isFace: null == isFace
          ? _self.isFace
          : isFace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class EnterPasswordStatePassword implements EnterPasswordState {
  const EnterPasswordStatePassword();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnterPasswordStatePassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState.password()';
  }
}

/// @nodoc

class EnterPasswordStateLedger implements EnterPasswordState {
  const EnterPasswordStateLedger();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnterPasswordStateLedger);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState.ledger()';
  }
}

// dart format on
