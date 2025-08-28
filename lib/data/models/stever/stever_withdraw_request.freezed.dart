// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stever_withdraw_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StEverWithdrawRequest {
  String get nonce;
  StEverWithdrawRequestData get data;
  @NekotonAddressConverter()
  Address get accountAddress;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StEverWithdrawRequestCopyWith<StEverWithdrawRequest> get copyWith =>
      _$StEverWithdrawRequestCopyWithImpl<StEverWithdrawRequest>(
          this as StEverWithdrawRequest, _$identity);

  /// Serializes this StEverWithdrawRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StEverWithdrawRequest &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.accountAddress, accountAddress) ||
                other.accountAddress == accountAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nonce, data, accountAddress);

  @override
  String toString() {
    return 'StEverWithdrawRequest(nonce: $nonce, data: $data, accountAddress: $accountAddress)';
  }
}

/// @nodoc
abstract mixin class $StEverWithdrawRequestCopyWith<$Res> {
  factory $StEverWithdrawRequestCopyWith(StEverWithdrawRequest value,
          $Res Function(StEverWithdrawRequest) _then) =
      _$StEverWithdrawRequestCopyWithImpl;
  @useResult
  $Res call(
      {String nonce,
      StEverWithdrawRequestData data,
      @NekotonAddressConverter() Address accountAddress});

  $StEverWithdrawRequestDataCopyWith<$Res> get data;
  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class _$StEverWithdrawRequestCopyWithImpl<$Res>
    implements $StEverWithdrawRequestCopyWith<$Res> {
  _$StEverWithdrawRequestCopyWithImpl(this._self, this._then);

  final StEverWithdrawRequest _self;
  final $Res Function(StEverWithdrawRequest) _then;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonce = null,
    Object? data = null,
    Object? accountAddress = null,
  }) {
    return _then(_self.copyWith(
      nonce: null == nonce
          ? _self.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as StEverWithdrawRequestData,
      accountAddress: null == accountAddress
          ? _self.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StEverWithdrawRequestDataCopyWith<$Res> get data {
    return $StEverWithdrawRequestDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get accountAddress {
    return $AddressCopyWith<$Res>(_self.accountAddress, (value) {
      return _then(_self.copyWith(accountAddress: value));
    });
  }
}

/// Adds pattern-matching-related methods to [StEverWithdrawRequest].
extension StEverWithdrawRequestPatterns on StEverWithdrawRequest {
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
    TResult Function(_StEverWithdrawRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequest() when $default != null:
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
    TResult Function(_StEverWithdrawRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequest():
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
    TResult? Function(_StEverWithdrawRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequest() when $default != null:
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
    TResult Function(String nonce, StEverWithdrawRequestData data,
            @NekotonAddressConverter() Address accountAddress)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequest() when $default != null:
        return $default(_that.nonce, _that.data, _that.accountAddress);
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
    TResult Function(String nonce, StEverWithdrawRequestData data,
            @NekotonAddressConverter() Address accountAddress)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequest():
        return $default(_that.nonce, _that.data, _that.accountAddress);
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
    TResult? Function(String nonce, StEverWithdrawRequestData data,
            @NekotonAddressConverter() Address accountAddress)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequest() when $default != null:
        return $default(_that.nonce, _that.data, _that.accountAddress);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StEverWithdrawRequest implements StEverWithdrawRequest {
  const _StEverWithdrawRequest(
      {required this.nonce,
      required this.data,
      @NekotonAddressConverter() required this.accountAddress});
  factory _StEverWithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$StEverWithdrawRequestFromJson(json);

  @override
  final String nonce;
  @override
  final StEverWithdrawRequestData data;
  @override
  @NekotonAddressConverter()
  final Address accountAddress;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StEverWithdrawRequestCopyWith<_StEverWithdrawRequest> get copyWith =>
      __$StEverWithdrawRequestCopyWithImpl<_StEverWithdrawRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StEverWithdrawRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StEverWithdrawRequest &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.accountAddress, accountAddress) ||
                other.accountAddress == accountAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nonce, data, accountAddress);

  @override
  String toString() {
    return 'StEverWithdrawRequest(nonce: $nonce, data: $data, accountAddress: $accountAddress)';
  }
}

/// @nodoc
abstract mixin class _$StEverWithdrawRequestCopyWith<$Res>
    implements $StEverWithdrawRequestCopyWith<$Res> {
  factory _$StEverWithdrawRequestCopyWith(_StEverWithdrawRequest value,
          $Res Function(_StEverWithdrawRequest) _then) =
      __$StEverWithdrawRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String nonce,
      StEverWithdrawRequestData data,
      @NekotonAddressConverter() Address accountAddress});

  @override
  $StEverWithdrawRequestDataCopyWith<$Res> get data;
  @override
  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class __$StEverWithdrawRequestCopyWithImpl<$Res>
    implements _$StEverWithdrawRequestCopyWith<$Res> {
  __$StEverWithdrawRequestCopyWithImpl(this._self, this._then);

  final _StEverWithdrawRequest _self;
  final $Res Function(_StEverWithdrawRequest) _then;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nonce = null,
    Object? data = null,
    Object? accountAddress = null,
  }) {
    return _then(_StEverWithdrawRequest(
      nonce: null == nonce
          ? _self.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as StEverWithdrawRequestData,
      accountAddress: null == accountAddress
          ? _self.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StEverWithdrawRequestDataCopyWith<$Res> get data {
    return $StEverWithdrawRequestDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get accountAddress {
    return $AddressCopyWith<$Res>(_self.accountAddress, (value) {
      return _then(_self.copyWith(accountAddress: value));
    });
  }
}

/// @nodoc
mixin _$StEverWithdrawRequestData {
  @amountJsonConverter
  BigInt get amount;
  @timestampFromStringJsonConverter
  DateTime get timestamp;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StEverWithdrawRequestDataCopyWith<StEverWithdrawRequestData> get copyWith =>
      _$StEverWithdrawRequestDataCopyWithImpl<StEverWithdrawRequestData>(
          this as StEverWithdrawRequestData, _$identity);

  /// Serializes this StEverWithdrawRequestData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StEverWithdrawRequestData &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, timestamp);

  @override
  String toString() {
    return 'StEverWithdrawRequestData(amount: $amount, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $StEverWithdrawRequestDataCopyWith<$Res> {
  factory $StEverWithdrawRequestDataCopyWith(StEverWithdrawRequestData value,
          $Res Function(StEverWithdrawRequestData) _then) =
      _$StEverWithdrawRequestDataCopyWithImpl;
  @useResult
  $Res call(
      {@amountJsonConverter BigInt amount,
      @timestampFromStringJsonConverter DateTime timestamp});
}

/// @nodoc
class _$StEverWithdrawRequestDataCopyWithImpl<$Res>
    implements $StEverWithdrawRequestDataCopyWith<$Res> {
  _$StEverWithdrawRequestDataCopyWithImpl(this._self, this._then);

  final StEverWithdrawRequestData _self;
  final $Res Function(StEverWithdrawRequestData) _then;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [StEverWithdrawRequestData].
extension StEverWithdrawRequestDataPatterns on StEverWithdrawRequestData {
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
    TResult Function(_StEverWithdrawRequestData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequestData() when $default != null:
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
    TResult Function(_StEverWithdrawRequestData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequestData():
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
    TResult? Function(_StEverWithdrawRequestData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequestData() when $default != null:
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
    TResult Function(@amountJsonConverter BigInt amount,
            @timestampFromStringJsonConverter DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequestData() when $default != null:
        return $default(_that.amount, _that.timestamp);
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
    TResult Function(@amountJsonConverter BigInt amount,
            @timestampFromStringJsonConverter DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequestData():
        return $default(_that.amount, _that.timestamp);
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
    TResult? Function(@amountJsonConverter BigInt amount,
            @timestampFromStringJsonConverter DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StEverWithdrawRequestData() when $default != null:
        return $default(_that.amount, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StEverWithdrawRequestData implements StEverWithdrawRequestData {
  const _StEverWithdrawRequestData(
      {@amountJsonConverter required this.amount,
      @timestampFromStringJsonConverter required this.timestamp});
  factory _StEverWithdrawRequestData.fromJson(Map<String, dynamic> json) =>
      _$StEverWithdrawRequestDataFromJson(json);

  @override
  @amountJsonConverter
  final BigInt amount;
  @override
  @timestampFromStringJsonConverter
  final DateTime timestamp;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StEverWithdrawRequestDataCopyWith<_StEverWithdrawRequestData>
      get copyWith =>
          __$StEverWithdrawRequestDataCopyWithImpl<_StEverWithdrawRequestData>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StEverWithdrawRequestDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StEverWithdrawRequestData &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, timestamp);

  @override
  String toString() {
    return 'StEverWithdrawRequestData(amount: $amount, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$StEverWithdrawRequestDataCopyWith<$Res>
    implements $StEverWithdrawRequestDataCopyWith<$Res> {
  factory _$StEverWithdrawRequestDataCopyWith(_StEverWithdrawRequestData value,
          $Res Function(_StEverWithdrawRequestData) _then) =
      __$StEverWithdrawRequestDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@amountJsonConverter BigInt amount,
      @timestampFromStringJsonConverter DateTime timestamp});
}

/// @nodoc
class __$StEverWithdrawRequestDataCopyWithImpl<$Res>
    implements _$StEverWithdrawRequestDataCopyWith<$Res> {
  __$StEverWithdrawRequestDataCopyWithImpl(this._self, this._then);

  final _StEverWithdrawRequestData _self;
  final $Res Function(_StEverWithdrawRequestData) _then;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? timestamp = null,
  }) {
    return _then(_StEverWithdrawRequestData(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
