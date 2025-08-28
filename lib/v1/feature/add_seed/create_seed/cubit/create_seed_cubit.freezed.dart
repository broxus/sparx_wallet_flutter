// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_seed_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateSeedCubitState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CreateSeedCubitState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CreateSeedCubitState()';
  }
}

/// @nodoc
class $CreateSeedCubitStateCopyWith<$Res> {
  $CreateSeedCubitStateCopyWith(
      CreateSeedCubitState _, $Res Function(CreateSeedCubitState) __);
}

/// Adds pattern-matching-related methods to [CreateSeedCubitState].
extension CreateSeedCubitStatePatterns on CreateSeedCubitState {
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
    TResult Function(CreateSeedCubitStateInitial value)? initial,
    TResult Function(CreateSeedCubitStateGenerated value)? generated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CreateSeedCubitStateInitial() when initial != null:
        return initial(_that);
      case CreateSeedCubitStateGenerated() when generated != null:
        return generated(_that);
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
    required TResult Function(CreateSeedCubitStateInitial value) initial,
    required TResult Function(CreateSeedCubitStateGenerated value) generated,
  }) {
    final _that = this;
    switch (_that) {
      case CreateSeedCubitStateInitial():
        return initial(_that);
      case CreateSeedCubitStateGenerated():
        return generated(_that);
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
    TResult? Function(CreateSeedCubitStateInitial value)? initial,
    TResult? Function(CreateSeedCubitStateGenerated value)? generated,
  }) {
    final _that = this;
    switch (_that) {
      case CreateSeedCubitStateInitial() when initial != null:
        return initial(_that);
      case CreateSeedCubitStateGenerated() when generated != null:
        return generated(_that);
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
    TResult Function(SeedPhraseModel seed, bool isCopied)? generated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CreateSeedCubitStateInitial() when initial != null:
        return initial();
      case CreateSeedCubitStateGenerated() when generated != null:
        return generated(_that.seed, _that.isCopied);
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
    required TResult Function(SeedPhraseModel seed, bool isCopied) generated,
  }) {
    final _that = this;
    switch (_that) {
      case CreateSeedCubitStateInitial():
        return initial();
      case CreateSeedCubitStateGenerated():
        return generated(_that.seed, _that.isCopied);
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
    TResult? Function(SeedPhraseModel seed, bool isCopied)? generated,
  }) {
    final _that = this;
    switch (_that) {
      case CreateSeedCubitStateInitial() when initial != null:
        return initial();
      case CreateSeedCubitStateGenerated() when generated != null:
        return generated(_that.seed, _that.isCopied);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CreateSeedCubitStateInitial implements CreateSeedCubitState {
  const CreateSeedCubitStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateSeedCubitStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CreateSeedCubitState.initial()';
  }
}

/// @nodoc

class CreateSeedCubitStateGenerated implements CreateSeedCubitState {
  const CreateSeedCubitStateGenerated(
      {required this.seed, required this.isCopied});

  final SeedPhraseModel seed;
  final bool isCopied;

  /// Create a copy of CreateSeedCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateSeedCubitStateGeneratedCopyWith<CreateSeedCubitStateGenerated>
      get copyWith => _$CreateSeedCubitStateGeneratedCopyWithImpl<
          CreateSeedCubitStateGenerated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateSeedCubitStateGenerated &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.isCopied, isCopied) ||
                other.isCopied == isCopied));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seed, isCopied);

  @override
  String toString() {
    return 'CreateSeedCubitState.generated(seed: $seed, isCopied: $isCopied)';
  }
}

/// @nodoc
abstract mixin class $CreateSeedCubitStateGeneratedCopyWith<$Res>
    implements $CreateSeedCubitStateCopyWith<$Res> {
  factory $CreateSeedCubitStateGeneratedCopyWith(
          CreateSeedCubitStateGenerated value,
          $Res Function(CreateSeedCubitStateGenerated) _then) =
      _$CreateSeedCubitStateGeneratedCopyWithImpl;
  @useResult
  $Res call({SeedPhraseModel seed, bool isCopied});
}

/// @nodoc
class _$CreateSeedCubitStateGeneratedCopyWithImpl<$Res>
    implements $CreateSeedCubitStateGeneratedCopyWith<$Res> {
  _$CreateSeedCubitStateGeneratedCopyWithImpl(this._self, this._then);

  final CreateSeedCubitStateGenerated _self;
  final $Res Function(CreateSeedCubitStateGenerated) _then;

  /// Create a copy of CreateSeedCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? seed = null,
    Object? isCopied = null,
  }) {
    return _then(CreateSeedCubitStateGenerated(
      seed: null == seed
          ? _self.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as SeedPhraseModel,
      isCopied: null == isCopied
          ? _self.isCopied
          : isCopied // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
