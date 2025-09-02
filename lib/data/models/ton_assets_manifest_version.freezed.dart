// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_assets_manifest_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonAssetsManifestVersion {
  int get major;
  int get minor;
  int get patch;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonAssetsManifestVersionCopyWith<TonAssetsManifestVersion> get copyWith =>
      _$TonAssetsManifestVersionCopyWithImpl<TonAssetsManifestVersion>(
          this as TonAssetsManifestVersion, _$identity);

  /// Serializes this TonAssetsManifestVersion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonAssetsManifestVersion &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.patch, patch) || other.patch == patch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, major, minor, patch);

  @override
  String toString() {
    return 'TonAssetsManifestVersion(major: $major, minor: $minor, patch: $patch)';
  }
}

/// @nodoc
abstract mixin class $TonAssetsManifestVersionCopyWith<$Res> {
  factory $TonAssetsManifestVersionCopyWith(TonAssetsManifestVersion value,
          $Res Function(TonAssetsManifestVersion) _then) =
      _$TonAssetsManifestVersionCopyWithImpl;
  @useResult
  $Res call({int major, int minor, int patch});
}

/// @nodoc
class _$TonAssetsManifestVersionCopyWithImpl<$Res>
    implements $TonAssetsManifestVersionCopyWith<$Res> {
  _$TonAssetsManifestVersionCopyWithImpl(this._self, this._then);

  final TonAssetsManifestVersion _self;
  final $Res Function(TonAssetsManifestVersion) _then;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = null,
  }) {
    return _then(_self.copyWith(
      major: null == major
          ? _self.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _self.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: null == patch
          ? _self.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TonAssetsManifestVersion].
extension TonAssetsManifestVersionPatterns on TonAssetsManifestVersion {
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
    TResult Function(_TonAssetsManifestVersion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TonAssetsManifestVersion() when $default != null:
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
    TResult Function(_TonAssetsManifestVersion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonAssetsManifestVersion():
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
    TResult? Function(_TonAssetsManifestVersion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonAssetsManifestVersion() when $default != null:
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
    TResult Function(int major, int minor, int patch)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TonAssetsManifestVersion() when $default != null:
        return $default(_that.major, _that.minor, _that.patch);
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
    TResult Function(int major, int minor, int patch) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonAssetsManifestVersion():
        return $default(_that.major, _that.minor, _that.patch);
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
    TResult? Function(int major, int minor, int patch)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TonAssetsManifestVersion() when $default != null:
        return $default(_that.major, _that.minor, _that.patch);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TonAssetsManifestVersion implements TonAssetsManifestVersion {
  const _TonAssetsManifestVersion(
      {required this.major, required this.minor, required this.patch});
  factory _TonAssetsManifestVersion.fromJson(Map<String, dynamic> json) =>
      _$TonAssetsManifestVersionFromJson(json);

  @override
  final int major;
  @override
  final int minor;
  @override
  final int patch;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TonAssetsManifestVersionCopyWith<_TonAssetsManifestVersion> get copyWith =>
      __$TonAssetsManifestVersionCopyWithImpl<_TonAssetsManifestVersion>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonAssetsManifestVersionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TonAssetsManifestVersion &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.patch, patch) || other.patch == patch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, major, minor, patch);

  @override
  String toString() {
    return 'TonAssetsManifestVersion(major: $major, minor: $minor, patch: $patch)';
  }
}

/// @nodoc
abstract mixin class _$TonAssetsManifestVersionCopyWith<$Res>
    implements $TonAssetsManifestVersionCopyWith<$Res> {
  factory _$TonAssetsManifestVersionCopyWith(_TonAssetsManifestVersion value,
          $Res Function(_TonAssetsManifestVersion) _then) =
      __$TonAssetsManifestVersionCopyWithImpl;
  @override
  @useResult
  $Res call({int major, int minor, int patch});
}

/// @nodoc
class __$TonAssetsManifestVersionCopyWithImpl<$Res>
    implements _$TonAssetsManifestVersionCopyWith<$Res> {
  __$TonAssetsManifestVersionCopyWithImpl(this._self, this._then);

  final _TonAssetsManifestVersion _self;
  final $Res Function(_TonAssetsManifestVersion) _then;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = null,
  }) {
    return _then(_TonAssetsManifestVersion(
      major: null == major
          ? _self.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _self.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: null == patch
          ? _self.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
