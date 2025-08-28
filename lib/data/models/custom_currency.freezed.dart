// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomCurrency {
  Address get address;

  /// Price in USD
  String get price;
  NetworkType get networkType;
  NetworkGroup get networkGroup;

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomCurrencyCopyWith<CustomCurrency> get copyWith =>
      _$CustomCurrencyCopyWithImpl<CustomCurrency>(
          this as CustomCurrency, _$identity);

  /// Serializes this CustomCurrency to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomCurrency &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, price, networkType, networkGroup);

  @override
  String toString() {
    return 'CustomCurrency(address: $address, price: $price, networkType: $networkType, networkGroup: $networkGroup)';
  }
}

/// @nodoc
abstract mixin class $CustomCurrencyCopyWith<$Res> {
  factory $CustomCurrencyCopyWith(
          CustomCurrency value, $Res Function(CustomCurrency) _then) =
      _$CustomCurrencyCopyWithImpl;
  @useResult
  $Res call(
      {Address address,
      String price,
      NetworkType networkType,
      NetworkGroup networkGroup});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$CustomCurrencyCopyWithImpl<$Res>
    implements $CustomCurrencyCopyWith<$Res> {
  _$CustomCurrencyCopyWithImpl(this._self, this._then);

  final CustomCurrency _self;
  final $Res Function(CustomCurrency) _then;

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? price = null,
    Object? networkType = null,
    Object? networkGroup = null,
  }) {
    return _then(_self.copyWith(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as NetworkGroup,
    ));
  }

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CustomCurrency].
extension CustomCurrencyPatterns on CustomCurrency {
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
    TResult Function(_CustomCurrency value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomCurrency() when $default != null:
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
    TResult Function(_CustomCurrency value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomCurrency():
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
    TResult? Function(_CustomCurrency value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomCurrency() when $default != null:
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
    TResult Function(Address address, String price, NetworkType networkType,
            NetworkGroup networkGroup)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomCurrency() when $default != null:
        return $default(
            _that.address, _that.price, _that.networkType, _that.networkGroup);
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
    TResult Function(Address address, String price, NetworkType networkType,
            NetworkGroup networkGroup)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomCurrency():
        return $default(
            _that.address, _that.price, _that.networkType, _that.networkGroup);
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
    TResult? Function(Address address, String price, NetworkType networkType,
            NetworkGroup networkGroup)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomCurrency() when $default != null:
        return $default(
            _that.address, _that.price, _that.networkType, _that.networkGroup);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomCurrency implements CustomCurrency {
  const _CustomCurrency(
      {required this.address,
      required this.price,
      required this.networkType,
      required this.networkGroup});
  factory _CustomCurrency.fromJson(Map<String, dynamic> json) =>
      _$CustomCurrencyFromJson(json);

  @override
  final Address address;

  /// Price in USD
  @override
  final String price;
  @override
  final NetworkType networkType;
  @override
  final NetworkGroup networkGroup;

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomCurrencyCopyWith<_CustomCurrency> get copyWith =>
      __$CustomCurrencyCopyWithImpl<_CustomCurrency>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomCurrencyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomCurrency &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, price, networkType, networkGroup);

  @override
  String toString() {
    return 'CustomCurrency(address: $address, price: $price, networkType: $networkType, networkGroup: $networkGroup)';
  }
}

/// @nodoc
abstract mixin class _$CustomCurrencyCopyWith<$Res>
    implements $CustomCurrencyCopyWith<$Res> {
  factory _$CustomCurrencyCopyWith(
          _CustomCurrency value, $Res Function(_CustomCurrency) _then) =
      __$CustomCurrencyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Address address,
      String price,
      NetworkType networkType,
      NetworkGroup networkGroup});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$CustomCurrencyCopyWithImpl<$Res>
    implements _$CustomCurrencyCopyWith<$Res> {
  __$CustomCurrencyCopyWithImpl(this._self, this._then);

  final _CustomCurrency _self;
  final $Res Function(_CustomCurrency) _then;

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
    Object? price = null,
    Object? networkType = null,
    Object? networkGroup = null,
  }) {
    return _then(_CustomCurrency(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as NetworkGroup,
    ));
  }

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

// dart format on
