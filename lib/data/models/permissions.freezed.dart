// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Permissions {
  @JsonKey(includeIfNull: false)
  bool? get basic;
  @JsonKey(includeIfNull: false)
  AccountInteraction? get accountInteraction;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PermissionsCopyWith<Permissions> get copyWith =>
      _$PermissionsCopyWithImpl<Permissions>(this as Permissions, _$identity);

  /// Serializes this Permissions to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Permissions &&
            (identical(other.basic, basic) || other.basic == basic) &&
            (identical(other.accountInteraction, accountInteraction) ||
                other.accountInteraction == accountInteraction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basic, accountInteraction);

  @override
  String toString() {
    return 'Permissions(basic: $basic, accountInteraction: $accountInteraction)';
  }
}

/// @nodoc
abstract mixin class $PermissionsCopyWith<$Res> {
  factory $PermissionsCopyWith(
          Permissions value, $Res Function(Permissions) _then) =
      _$PermissionsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) bool? basic,
      @JsonKey(includeIfNull: false) AccountInteraction? accountInteraction});

  $AccountInteractionCopyWith<$Res>? get accountInteraction;
}

/// @nodoc
class _$PermissionsCopyWithImpl<$Res> implements $PermissionsCopyWith<$Res> {
  _$PermissionsCopyWithImpl(this._self, this._then);

  final Permissions _self;
  final $Res Function(Permissions) _then;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basic = freezed,
    Object? accountInteraction = freezed,
  }) {
    return _then(_self.copyWith(
      basic: freezed == basic
          ? _self.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as bool?,
      accountInteraction: freezed == accountInteraction
          ? _self.accountInteraction
          : accountInteraction // ignore: cast_nullable_to_non_nullable
              as AccountInteraction?,
    ));
  }

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountInteractionCopyWith<$Res>? get accountInteraction {
    if (_self.accountInteraction == null) {
      return null;
    }

    return $AccountInteractionCopyWith<$Res>(_self.accountInteraction!,
        (value) {
      return _then(_self.copyWith(accountInteraction: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Permissions].
extension PermissionsPatterns on Permissions {
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
    TResult Function(_Permissions value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Permissions() when $default != null:
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
    TResult Function(_Permissions value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Permissions():
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
    TResult? Function(_Permissions value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Permissions() when $default != null:
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
    TResult Function(
            @JsonKey(includeIfNull: false) bool? basic,
            @JsonKey(includeIfNull: false)
            AccountInteraction? accountInteraction)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Permissions() when $default != null:
        return $default(_that.basic, _that.accountInteraction);
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
    TResult Function(
            @JsonKey(includeIfNull: false) bool? basic,
            @JsonKey(includeIfNull: false)
            AccountInteraction? accountInteraction)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Permissions():
        return $default(_that.basic, _that.accountInteraction);
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
    TResult? Function(
            @JsonKey(includeIfNull: false) bool? basic,
            @JsonKey(includeIfNull: false)
            AccountInteraction? accountInteraction)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Permissions() when $default != null:
        return $default(_that.basic, _that.accountInteraction);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Permissions extends Permissions {
  const _Permissions(
      {@JsonKey(includeIfNull: false) this.basic,
      @JsonKey(includeIfNull: false) this.accountInteraction})
      : super._();
  factory _Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final bool? basic;
  @override
  @JsonKey(includeIfNull: false)
  final AccountInteraction? accountInteraction;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PermissionsCopyWith<_Permissions> get copyWith =>
      __$PermissionsCopyWithImpl<_Permissions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PermissionsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Permissions &&
            (identical(other.basic, basic) || other.basic == basic) &&
            (identical(other.accountInteraction, accountInteraction) ||
                other.accountInteraction == accountInteraction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basic, accountInteraction);

  @override
  String toString() {
    return 'Permissions(basic: $basic, accountInteraction: $accountInteraction)';
  }
}

/// @nodoc
abstract mixin class _$PermissionsCopyWith<$Res>
    implements $PermissionsCopyWith<$Res> {
  factory _$PermissionsCopyWith(
          _Permissions value, $Res Function(_Permissions) _then) =
      __$PermissionsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) bool? basic,
      @JsonKey(includeIfNull: false) AccountInteraction? accountInteraction});

  @override
  $AccountInteractionCopyWith<$Res>? get accountInteraction;
}

/// @nodoc
class __$PermissionsCopyWithImpl<$Res> implements _$PermissionsCopyWith<$Res> {
  __$PermissionsCopyWithImpl(this._self, this._then);

  final _Permissions _self;
  final $Res Function(_Permissions) _then;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? basic = freezed,
    Object? accountInteraction = freezed,
  }) {
    return _then(_Permissions(
      basic: freezed == basic
          ? _self.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as bool?,
      accountInteraction: freezed == accountInteraction
          ? _self.accountInteraction
          : accountInteraction // ignore: cast_nullable_to_non_nullable
              as AccountInteraction?,
    ));
  }

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountInteractionCopyWith<$Res>? get accountInteraction {
    if (_self.accountInteraction == null) {
      return null;
    }

    return $AccountInteractionCopyWith<$Res>(_self.accountInteraction!,
        (value) {
      return _then(_self.copyWith(accountInteraction: value));
    });
  }
}

// dart format on
