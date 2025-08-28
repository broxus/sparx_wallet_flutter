// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateRequest {
  /// The status of the update (blocking, warning, none)
  UpdateStatus get status;

  /// The target version to update to
  String? get targetVersion;

  /// Optional release notes for the target version
  ReleaseNote? get releaseNote;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateRequestCopyWith<UpdateRequest> get copyWith =>
      _$UpdateRequestCopyWithImpl<UpdateRequest>(
          this as UpdateRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateRequest &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.targetVersion, targetVersion) ||
                other.targetVersion == targetVersion) &&
            (identical(other.releaseNote, releaseNote) ||
                other.releaseNote == releaseNote));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, targetVersion, releaseNote);

  @override
  String toString() {
    return 'UpdateRequest(status: $status, targetVersion: $targetVersion, releaseNote: $releaseNote)';
  }
}

/// @nodoc
abstract mixin class $UpdateRequestCopyWith<$Res> {
  factory $UpdateRequestCopyWith(
          UpdateRequest value, $Res Function(UpdateRequest) _then) =
      _$UpdateRequestCopyWithImpl;
  @useResult
  $Res call(
      {UpdateStatus status, String? targetVersion, ReleaseNote? releaseNote});

  $ReleaseNoteCopyWith<$Res>? get releaseNote;
}

/// @nodoc
class _$UpdateRequestCopyWithImpl<$Res>
    implements $UpdateRequestCopyWith<$Res> {
  _$UpdateRequestCopyWithImpl(this._self, this._then);

  final UpdateRequest _self;
  final $Res Function(UpdateRequest) _then;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? targetVersion = freezed,
    Object? releaseNote = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdateStatus,
      targetVersion: freezed == targetVersion
          ? _self.targetVersion
          : targetVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseNote: freezed == releaseNote
          ? _self.releaseNote
          : releaseNote // ignore: cast_nullable_to_non_nullable
              as ReleaseNote?,
    ));
  }

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReleaseNoteCopyWith<$Res>? get releaseNote {
    if (_self.releaseNote == null) {
      return null;
    }

    return $ReleaseNoteCopyWith<$Res>(_self.releaseNote!, (value) {
      return _then(_self.copyWith(releaseNote: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UpdateRequest].
extension UpdateRequestPatterns on UpdateRequest {
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
    TResult Function(_UpdateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateRequest() when $default != null:
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
    TResult Function(_UpdateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequest():
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
    TResult? Function(_UpdateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequest() when $default != null:
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
    TResult Function(UpdateStatus status, String? targetVersion,
            ReleaseNote? releaseNote)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateRequest() when $default != null:
        return $default(_that.status, _that.targetVersion, _that.releaseNote);
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
    TResult Function(UpdateStatus status, String? targetVersion,
            ReleaseNote? releaseNote)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequest():
        return $default(_that.status, _that.targetVersion, _that.releaseNote);
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
    TResult? Function(UpdateStatus status, String? targetVersion,
            ReleaseNote? releaseNote)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequest() when $default != null:
        return $default(_that.status, _that.targetVersion, _that.releaseNote);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UpdateRequest implements UpdateRequest {
  const _UpdateRequest(
      {required this.status, this.targetVersion, this.releaseNote});

  /// The status of the update (blocking, warning, none)
  @override
  final UpdateStatus status;

  /// The target version to update to
  @override
  final String? targetVersion;

  /// Optional release notes for the target version
  @override
  final ReleaseNote? releaseNote;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateRequestCopyWith<_UpdateRequest> get copyWith =>
      __$UpdateRequestCopyWithImpl<_UpdateRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateRequest &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.targetVersion, targetVersion) ||
                other.targetVersion == targetVersion) &&
            (identical(other.releaseNote, releaseNote) ||
                other.releaseNote == releaseNote));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, targetVersion, releaseNote);

  @override
  String toString() {
    return 'UpdateRequest(status: $status, targetVersion: $targetVersion, releaseNote: $releaseNote)';
  }
}

/// @nodoc
abstract mixin class _$UpdateRequestCopyWith<$Res>
    implements $UpdateRequestCopyWith<$Res> {
  factory _$UpdateRequestCopyWith(
          _UpdateRequest value, $Res Function(_UpdateRequest) _then) =
      __$UpdateRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {UpdateStatus status, String? targetVersion, ReleaseNote? releaseNote});

  @override
  $ReleaseNoteCopyWith<$Res>? get releaseNote;
}

/// @nodoc
class __$UpdateRequestCopyWithImpl<$Res>
    implements _$UpdateRequestCopyWith<$Res> {
  __$UpdateRequestCopyWithImpl(this._self, this._then);

  final _UpdateRequest _self;
  final $Res Function(_UpdateRequest) _then;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? targetVersion = freezed,
    Object? releaseNote = freezed,
  }) {
    return _then(_UpdateRequest(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdateStatus,
      targetVersion: freezed == targetVersion
          ? _self.targetVersion
          : targetVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseNote: freezed == releaseNote
          ? _self.releaseNote
          : releaseNote // ignore: cast_nullable_to_non_nullable
              as ReleaseNote?,
    ));
  }

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReleaseNoteCopyWith<$Res>? get releaseNote {
    if (_self.releaseNote == null) {
      return null;
    }

    return $ReleaseNoteCopyWith<$Res>(_self.releaseNote!, (value) {
      return _then(_self.copyWith(releaseNote: value));
    });
  }
}

// dart format on
