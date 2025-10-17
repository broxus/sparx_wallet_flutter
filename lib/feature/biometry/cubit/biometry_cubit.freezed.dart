// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometry_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiometryState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BiometryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BiometryState()';
  }
}

/// @nodoc
class $BiometryStateCopyWith<$Res> {
  $BiometryStateCopyWith(BiometryState _, $Res Function(BiometryState) __);
}

/// Adds pattern-matching-related methods to [BiometryState].
extension BiometryStatePatterns on BiometryState {
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
    TResult Function(BiometryStateInit value)? init,
    TResult Function(BiometryStateAsk value)? ask,
    TResult Function(BiometryStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case BiometryStateInit() when init != null:
        return init(_that);
      case BiometryStateAsk() when ask != null:
        return ask(_that);
      case BiometryStateCompleted() when completed != null:
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
    required TResult Function(BiometryStateInit value) init,
    required TResult Function(BiometryStateAsk value) ask,
    required TResult Function(BiometryStateCompleted value) completed,
  }) {
    final _that = this;
    switch (_that) {
      case BiometryStateInit():
        return init(_that);
      case BiometryStateAsk():
        return ask(_that);
      case BiometryStateCompleted():
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
    TResult? Function(BiometryStateInit value)? init,
    TResult? Function(BiometryStateAsk value)? ask,
    TResult? Function(BiometryStateCompleted value)? completed,
  }) {
    final _that = this;
    switch (_that) {
      case BiometryStateInit() when init != null:
        return init(_that);
      case BiometryStateAsk() when ask != null:
        return ask(_that);
      case BiometryStateCompleted() when completed != null:
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
    TResult Function()? init,
    TResult Function(bool isFaceBiometry)? ask,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case BiometryStateInit() when init != null:
        return init();
      case BiometryStateAsk() when ask != null:
        return ask(_that.isFaceBiometry);
      case BiometryStateCompleted() when completed != null:
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
    required TResult Function() init,
    required TResult Function(bool isFaceBiometry) ask,
    required TResult Function() completed,
  }) {
    final _that = this;
    switch (_that) {
      case BiometryStateInit():
        return init();
      case BiometryStateAsk():
        return ask(_that.isFaceBiometry);
      case BiometryStateCompleted():
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
    TResult? Function()? init,
    TResult? Function(bool isFaceBiometry)? ask,
    TResult? Function()? completed,
  }) {
    final _that = this;
    switch (_that) {
      case BiometryStateInit() when init != null:
        return init();
      case BiometryStateAsk() when ask != null:
        return ask(_that.isFaceBiometry);
      case BiometryStateCompleted() when completed != null:
        return completed();
      case _:
        return null;
    }
  }
}

/// @nodoc

class BiometryStateInit implements BiometryState {
  const BiometryStateInit();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BiometryStateInit);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BiometryState.init()';
  }
}

/// @nodoc

class BiometryStateAsk implements BiometryState {
  const BiometryStateAsk({required this.isFaceBiometry});

  final bool isFaceBiometry;

  /// Create a copy of BiometryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BiometryStateAskCopyWith<BiometryStateAsk> get copyWith =>
      _$BiometryStateAskCopyWithImpl<BiometryStateAsk>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BiometryStateAsk &&
            (identical(other.isFaceBiometry, isFaceBiometry) ||
                other.isFaceBiometry == isFaceBiometry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFaceBiometry);

  @override
  String toString() {
    return 'BiometryState.ask(isFaceBiometry: $isFaceBiometry)';
  }
}

/// @nodoc
abstract mixin class $BiometryStateAskCopyWith<$Res>
    implements $BiometryStateCopyWith<$Res> {
  factory $BiometryStateAskCopyWith(
          BiometryStateAsk value, $Res Function(BiometryStateAsk) _then) =
      _$BiometryStateAskCopyWithImpl;
  @useResult
  $Res call({bool isFaceBiometry});
}

/// @nodoc
class _$BiometryStateAskCopyWithImpl<$Res>
    implements $BiometryStateAskCopyWith<$Res> {
  _$BiometryStateAskCopyWithImpl(this._self, this._then);

  final BiometryStateAsk _self;
  final $Res Function(BiometryStateAsk) _then;

  /// Create a copy of BiometryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFaceBiometry = null,
  }) {
    return _then(BiometryStateAsk(
      isFaceBiometry: null == isFaceBiometry
          ? _self.isFaceBiometry
          : isFaceBiometry // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class BiometryStateCompleted implements BiometryState {
  const BiometryStateCompleted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BiometryStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BiometryState.completed()';
  }
}

// dart format on
