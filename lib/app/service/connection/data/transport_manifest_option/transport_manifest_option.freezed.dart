// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_manifest_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransportManifestOption {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TransportManifestOption);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportManifestOption()';
  }
}

/// @nodoc
class $TransportManifestOptionCopyWith<$Res> {
  $TransportManifestOptionCopyWith(
      TransportManifestOption _, $Res Function(TransportManifestOption) __);
}

/// Adds pattern-matching-related methods to [TransportManifestOption].
extension TransportManifestOptionPatterns on TransportManifestOption {
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
    TResult Function(TransportManifestOptionFromConnection value)?
        fromConnection,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TransportManifestOptionFromConnection() when fromConnection != null:
        return fromConnection(_that);
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
    required TResult Function(TransportManifestOptionFromConnection value)
        fromConnection,
  }) {
    final _that = this;
    switch (_that) {
      case TransportManifestOptionFromConnection():
        return fromConnection(_that);
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
    TResult? Function(TransportManifestOptionFromConnection value)?
        fromConnection,
  }) {
    final _that = this;
    switch (_that) {
      case TransportManifestOptionFromConnection() when fromConnection != null:
        return fromConnection(_that);
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
    TResult Function()? fromConnection,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TransportManifestOptionFromConnection() when fromConnection != null:
        return fromConnection();
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
    required TResult Function() fromConnection,
  }) {
    final _that = this;
    switch (_that) {
      case TransportManifestOptionFromConnection():
        return fromConnection();
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
    TResult? Function()? fromConnection,
  }) {
    final _that = this;
    switch (_that) {
      case TransportManifestOptionFromConnection() when fromConnection != null:
        return fromConnection();
      case _:
        return null;
    }
  }
}

/// @nodoc

class TransportManifestOptionFromConnection implements TransportManifestOption {
  const TransportManifestOptionFromConnection();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportManifestOptionFromConnection);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportManifestOption.fromConnection()';
  }
}

// dart format on
