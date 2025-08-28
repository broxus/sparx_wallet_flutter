// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_transaction_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SendTransactionResponse _$SendTransactionResponseFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return SendTransactionResponseSuccess.fromJson(json);
    case 'error':
      return SendTransactionResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'SendTransactionResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SendTransactionResponse {
  String get id;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendTransactionResponseCopyWith<SendTransactionResponse> get copyWith =>
      _$SendTransactionResponseCopyWithImpl<SendTransactionResponse>(
          this as SendTransactionResponse, _$identity);

  /// Serializes this SendTransactionResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendTransactionResponse &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'SendTransactionResponse(id: $id)';
  }
}

/// @nodoc
abstract mixin class $SendTransactionResponseCopyWith<$Res> {
  factory $SendTransactionResponseCopyWith(SendTransactionResponse value,
          $Res Function(SendTransactionResponse) _then) =
      _$SendTransactionResponseCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SendTransactionResponseCopyWithImpl<$Res>
    implements $SendTransactionResponseCopyWith<$Res> {
  _$SendTransactionResponseCopyWithImpl(this._self, this._then);

  final SendTransactionResponse _self;
  final $Res Function(SendTransactionResponse) _then;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SendTransactionResponse].
extension SendTransactionResponsePatterns on SendTransactionResponse {
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
    TResult Function(SendTransactionResponseSuccess value)? success,
    TResult Function(SendTransactionResponseError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SendTransactionResponseSuccess() when success != null:
        return success(_that);
      case SendTransactionResponseError() when error != null:
        return error(_that);
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
    required TResult Function(SendTransactionResponseSuccess value) success,
    required TResult Function(SendTransactionResponseError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case SendTransactionResponseSuccess():
        return success(_that);
      case SendTransactionResponseError():
        return error(_that);
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
    TResult? Function(SendTransactionResponseSuccess value)? success,
    TResult? Function(SendTransactionResponseError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case SendTransactionResponseSuccess() when success != null:
        return success(_that);
      case SendTransactionResponseError() when error != null:
        return error(_that);
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
    TResult Function(String id, String result)? success,
    TResult Function(String id, TonConnectError error)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SendTransactionResponseSuccess() when success != null:
        return success(_that.id, _that.result);
      case SendTransactionResponseError() when error != null:
        return error(_that.id, _that.error);
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
    required TResult Function(String id, String result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) {
    final _that = this;
    switch (_that) {
      case SendTransactionResponseSuccess():
        return success(_that.id, _that.result);
      case SendTransactionResponseError():
        return error(_that.id, _that.error);
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
    TResult? Function(String id, String result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) {
    final _that = this;
    switch (_that) {
      case SendTransactionResponseSuccess() when success != null:
        return success(_that.id, _that.result);
      case SendTransactionResponseError() when error != null:
        return error(_that.id, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class SendTransactionResponseSuccess implements SendTransactionResponse {
  const SendTransactionResponseSuccess(
      {required this.id, required this.result, final String? $type})
      : $type = $type ?? 'success';
  factory SendTransactionResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseSuccessFromJson(json);

  @override
  final String id;
  final String result;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendTransactionResponseSuccessCopyWith<SendTransactionResponseSuccess>
      get copyWith => _$SendTransactionResponseSuccessCopyWithImpl<
          SendTransactionResponseSuccess>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SendTransactionResponseSuccessToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendTransactionResponseSuccess &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, result);

  @override
  String toString() {
    return 'SendTransactionResponse.success(id: $id, result: $result)';
  }
}

/// @nodoc
abstract mixin class $SendTransactionResponseSuccessCopyWith<$Res>
    implements $SendTransactionResponseCopyWith<$Res> {
  factory $SendTransactionResponseSuccessCopyWith(
          SendTransactionResponseSuccess value,
          $Res Function(SendTransactionResponseSuccess) _then) =
      _$SendTransactionResponseSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String result});
}

/// @nodoc
class _$SendTransactionResponseSuccessCopyWithImpl<$Res>
    implements $SendTransactionResponseSuccessCopyWith<$Res> {
  _$SendTransactionResponseSuccessCopyWithImpl(this._self, this._then);

  final SendTransactionResponseSuccess _self;
  final $Res Function(SendTransactionResponseSuccess) _then;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? result = null,
  }) {
    return _then(SendTransactionResponseSuccess(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SendTransactionResponseError implements SendTransactionResponse {
  const SendTransactionResponseError(
      {required this.id, required this.error, final String? $type})
      : $type = $type ?? 'error';
  factory SendTransactionResponseError.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseErrorFromJson(json);

  @override
  final String id;
  final TonConnectError error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendTransactionResponseErrorCopyWith<SendTransactionResponseError>
      get copyWith => _$SendTransactionResponseErrorCopyWithImpl<
          SendTransactionResponseError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SendTransactionResponseErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendTransactionResponseError &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, error);

  @override
  String toString() {
    return 'SendTransactionResponse.error(id: $id, error: $error)';
  }
}

/// @nodoc
abstract mixin class $SendTransactionResponseErrorCopyWith<$Res>
    implements $SendTransactionResponseCopyWith<$Res> {
  factory $SendTransactionResponseErrorCopyWith(
          SendTransactionResponseError value,
          $Res Function(SendTransactionResponseError) _then) =
      _$SendTransactionResponseErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String id, TonConnectError error});

  $TonConnectErrorCopyWith<$Res> get error;
}

/// @nodoc
class _$SendTransactionResponseErrorCopyWithImpl<$Res>
    implements $SendTransactionResponseErrorCopyWith<$Res> {
  _$SendTransactionResponseErrorCopyWithImpl(this._self, this._then);

  final SendTransactionResponseError _self;
  final $Res Function(SendTransactionResponseError) _then;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? error = null,
  }) {
    return _then(SendTransactionResponseError(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as TonConnectError,
    ));
  }

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<$Res> get error {
    return $TonConnectErrorCopyWith<$Res>(_self.error, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

// dart format on
