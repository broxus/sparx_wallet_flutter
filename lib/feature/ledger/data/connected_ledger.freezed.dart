// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connected_ledger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectedLedger {
  String get remoteId;
  PublicKey get masterKey;
  DeviceModelId get deviceModelId;

  /// Create a copy of ConnectedLedger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectedLedgerCopyWith<ConnectedLedger> get copyWith =>
      _$ConnectedLedgerCopyWithImpl<ConnectedLedger>(
          this as ConnectedLedger, _$identity);

  /// Serializes this ConnectedLedger to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectedLedger &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.masterKey, masterKey) ||
                other.masterKey == masterKey) &&
            (identical(other.deviceModelId, deviceModelId) ||
                other.deviceModelId == deviceModelId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, remoteId, masterKey, deviceModelId);

  @override
  String toString() {
    return 'ConnectedLedger(remoteId: $remoteId, masterKey: $masterKey, deviceModelId: $deviceModelId)';
  }
}

/// @nodoc
abstract mixin class $ConnectedLedgerCopyWith<$Res> {
  factory $ConnectedLedgerCopyWith(
          ConnectedLedger value, $Res Function(ConnectedLedger) _then) =
      _$ConnectedLedgerCopyWithImpl;
  @useResult
  $Res call(
      {String remoteId, PublicKey masterKey, DeviceModelId deviceModelId});

  $PublicKeyCopyWith<$Res> get masterKey;
}

/// @nodoc
class _$ConnectedLedgerCopyWithImpl<$Res>
    implements $ConnectedLedgerCopyWith<$Res> {
  _$ConnectedLedgerCopyWithImpl(this._self, this._then);

  final ConnectedLedger _self;
  final $Res Function(ConnectedLedger) _then;

  /// Create a copy of ConnectedLedger
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remoteId = null,
    Object? masterKey = null,
    Object? deviceModelId = null,
  }) {
    return _then(_self.copyWith(
      remoteId: null == remoteId
          ? _self.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String,
      masterKey: null == masterKey
          ? _self.masterKey
          : masterKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      deviceModelId: null == deviceModelId
          ? _self.deviceModelId
          : deviceModelId // ignore: cast_nullable_to_non_nullable
              as DeviceModelId,
    ));
  }

  /// Create a copy of ConnectedLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get masterKey {
    return $PublicKeyCopyWith<$Res>(_self.masterKey, (value) {
      return _then(_self.copyWith(masterKey: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ConnectedLedger].
extension ConnectedLedgerPatterns on ConnectedLedger {
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
    TResult Function(_ConnectedLedger value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectedLedger() when $default != null:
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
    TResult Function(_ConnectedLedger value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectedLedger():
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
    TResult? Function(_ConnectedLedger value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectedLedger() when $default != null:
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
            String remoteId, PublicKey masterKey, DeviceModelId deviceModelId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectedLedger() when $default != null:
        return $default(_that.remoteId, _that.masterKey, _that.deviceModelId);
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
            String remoteId, PublicKey masterKey, DeviceModelId deviceModelId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectedLedger():
        return $default(_that.remoteId, _that.masterKey, _that.deviceModelId);
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
            String remoteId, PublicKey masterKey, DeviceModelId deviceModelId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectedLedger() when $default != null:
        return $default(_that.remoteId, _that.masterKey, _that.deviceModelId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectedLedger implements ConnectedLedger {
  const _ConnectedLedger(
      {required this.remoteId,
      required this.masterKey,
      required this.deviceModelId});
  factory _ConnectedLedger.fromJson(Map<String, dynamic> json) =>
      _$ConnectedLedgerFromJson(json);

  @override
  final String remoteId;
  @override
  final PublicKey masterKey;
  @override
  final DeviceModelId deviceModelId;

  /// Create a copy of ConnectedLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectedLedgerCopyWith<_ConnectedLedger> get copyWith =>
      __$ConnectedLedgerCopyWithImpl<_ConnectedLedger>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectedLedgerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectedLedger &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.masterKey, masterKey) ||
                other.masterKey == masterKey) &&
            (identical(other.deviceModelId, deviceModelId) ||
                other.deviceModelId == deviceModelId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, remoteId, masterKey, deviceModelId);

  @override
  String toString() {
    return 'ConnectedLedger(remoteId: $remoteId, masterKey: $masterKey, deviceModelId: $deviceModelId)';
  }
}

/// @nodoc
abstract mixin class _$ConnectedLedgerCopyWith<$Res>
    implements $ConnectedLedgerCopyWith<$Res> {
  factory _$ConnectedLedgerCopyWith(
          _ConnectedLedger value, $Res Function(_ConnectedLedger) _then) =
      __$ConnectedLedgerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String remoteId, PublicKey masterKey, DeviceModelId deviceModelId});

  @override
  $PublicKeyCopyWith<$Res> get masterKey;
}

/// @nodoc
class __$ConnectedLedgerCopyWithImpl<$Res>
    implements _$ConnectedLedgerCopyWith<$Res> {
  __$ConnectedLedgerCopyWithImpl(this._self, this._then);

  final _ConnectedLedger _self;
  final $Res Function(_ConnectedLedger) _then;

  /// Create a copy of ConnectedLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? remoteId = null,
    Object? masterKey = null,
    Object? deviceModelId = null,
  }) {
    return _then(_ConnectedLedger(
      remoteId: null == remoteId
          ? _self.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String,
      masterKey: null == masterKey
          ? _self.masterKey
          : masterKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      deviceModelId: null == deviceModelId
          ? _self.deviceModelId
          : deviceModelId // ignore: cast_nullable_to_non_nullable
              as DeviceModelId,
    ));
  }

  /// Create a copy of ConnectedLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get masterKey {
    return $PublicKeyCopyWith<$Res>(_self.masterKey, (value) {
      return _then(_self.copyWith(masterKey: value));
    });
  }
}

// dart format on
