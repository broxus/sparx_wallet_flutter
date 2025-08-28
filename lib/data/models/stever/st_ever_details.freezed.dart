// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'st_ever_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StEverDetails {
  @amountJsonConverter
  BigInt get stEverSupply;
  @amountJsonConverter
  BigInt get totalAssets; // Time before withdrawing in secodns
  String get withdrawHoldTime;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StEverDetailsCopyWith<StEverDetails> get copyWith =>
      _$StEverDetailsCopyWithImpl<StEverDetails>(
          this as StEverDetails, _$identity);

  /// Serializes this StEverDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StEverDetails &&
            (identical(other.stEverSupply, stEverSupply) ||
                other.stEverSupply == stEverSupply) &&
            (identical(other.totalAssets, totalAssets) ||
                other.totalAssets == totalAssets) &&
            (identical(other.withdrawHoldTime, withdrawHoldTime) ||
                other.withdrawHoldTime == withdrawHoldTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stEverSupply, totalAssets, withdrawHoldTime);

  @override
  String toString() {
    return 'StEverDetails(stEverSupply: $stEverSupply, totalAssets: $totalAssets, withdrawHoldTime: $withdrawHoldTime)';
  }
}

/// @nodoc
abstract mixin class $StEverDetailsCopyWith<$Res> {
  factory $StEverDetailsCopyWith(
          StEverDetails value, $Res Function(StEverDetails) _then) =
      _$StEverDetailsCopyWithImpl;
  @useResult
  $Res call(
      {@amountJsonConverter BigInt stEverSupply,
      @amountJsonConverter BigInt totalAssets,
      String withdrawHoldTime});
}

/// @nodoc
class _$StEverDetailsCopyWithImpl<$Res>
    implements $StEverDetailsCopyWith<$Res> {
  _$StEverDetailsCopyWithImpl(this._self, this._then);

  final StEverDetails _self;
  final $Res Function(StEverDetails) _then;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stEverSupply = null,
    Object? totalAssets = null,
    Object? withdrawHoldTime = null,
  }) {
    return _then(_self.copyWith(
      stEverSupply: null == stEverSupply
          ? _self.stEverSupply
          : stEverSupply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      totalAssets: null == totalAssets
          ? _self.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as BigInt,
      withdrawHoldTime: null == withdrawHoldTime
          ? _self.withdrawHoldTime
          : withdrawHoldTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [StEverDetails].
extension StEverDetailsPatterns on StEverDetails {
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
    TResult Function(_StEverDetails value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StEverDetails() when $default != null:
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
    TResult Function(_StEverDetails value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverDetails():
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
    TResult? Function(_StEverDetails value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverDetails() when $default != null:
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
    TResult Function(@amountJsonConverter BigInt stEverSupply,
            @amountJsonConverter BigInt totalAssets, String withdrawHoldTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StEverDetails() when $default != null:
        return $default(
            _that.stEverSupply, _that.totalAssets, _that.withdrawHoldTime);
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
    TResult Function(@amountJsonConverter BigInt stEverSupply,
            @amountJsonConverter BigInt totalAssets, String withdrawHoldTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverDetails():
        return $default(
            _that.stEverSupply, _that.totalAssets, _that.withdrawHoldTime);
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
    TResult? Function(@amountJsonConverter BigInt stEverSupply,
            @amountJsonConverter BigInt totalAssets, String withdrawHoldTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverDetails() when $default != null:
        return $default(
            _that.stEverSupply, _that.totalAssets, _that.withdrawHoldTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StEverDetails implements StEverDetails {
  const _StEverDetails(
      {@amountJsonConverter required this.stEverSupply,
      @amountJsonConverter required this.totalAssets,
      required this.withdrawHoldTime});
  factory _StEverDetails.fromJson(Map<String, dynamic> json) =>
      _$StEverDetailsFromJson(json);

  @override
  @amountJsonConverter
  final BigInt stEverSupply;
  @override
  @amountJsonConverter
  final BigInt totalAssets;
// Time before withdrawing in secodns
  @override
  final String withdrawHoldTime;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StEverDetailsCopyWith<_StEverDetails> get copyWith =>
      __$StEverDetailsCopyWithImpl<_StEverDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StEverDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StEverDetails &&
            (identical(other.stEverSupply, stEverSupply) ||
                other.stEverSupply == stEverSupply) &&
            (identical(other.totalAssets, totalAssets) ||
                other.totalAssets == totalAssets) &&
            (identical(other.withdrawHoldTime, withdrawHoldTime) ||
                other.withdrawHoldTime == withdrawHoldTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stEverSupply, totalAssets, withdrawHoldTime);

  @override
  String toString() {
    return 'StEverDetails(stEverSupply: $stEverSupply, totalAssets: $totalAssets, withdrawHoldTime: $withdrawHoldTime)';
  }
}

/// @nodoc
abstract mixin class _$StEverDetailsCopyWith<$Res>
    implements $StEverDetailsCopyWith<$Res> {
  factory _$StEverDetailsCopyWith(
          _StEverDetails value, $Res Function(_StEverDetails) _then) =
      __$StEverDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@amountJsonConverter BigInt stEverSupply,
      @amountJsonConverter BigInt totalAssets,
      String withdrawHoldTime});
}

/// @nodoc
class __$StEverDetailsCopyWithImpl<$Res>
    implements _$StEverDetailsCopyWith<$Res> {
  __$StEverDetailsCopyWithImpl(this._self, this._then);

  final _StEverDetails _self;
  final $Res Function(_StEverDetails) _then;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stEverSupply = null,
    Object? totalAssets = null,
    Object? withdrawHoldTime = null,
  }) {
    return _then(_StEverDetails(
      stEverSupply: null == stEverSupply
          ? _self.stEverSupply
          : stEverSupply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      totalAssets: null == totalAssets
          ? _self.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as BigInt,
      withdrawHoldTime: null == withdrawHoldTime
          ? _self.withdrawHoldTime
          : withdrawHoldTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
