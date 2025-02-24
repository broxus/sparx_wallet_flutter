// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RpcRequest _$RpcRequestFromJson(Map<String, dynamic> json) {
  switch (json['method']) {
    case 'disconnect':
      return DisconnectRpcRequest.fromJson(json);
    case 'sendTransaction':
      return SendTransactionRpcRequest.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'method', 'RpcRequest',
          'Invalid union type "${json['method']}"!');
  }
}

/// @nodoc
mixin _$RpcRequest {
  String get id => throw _privateConstructorUsedError;
  List<dynamic> get params => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, List<dynamic> params) disconnect,
    required TResult Function(String id, List<String> params) sendTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, List<dynamic> params)? disconnect,
    TResult? Function(String id, List<String> params)? sendTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, List<dynamic> params)? disconnect,
    TResult Function(String id, List<String> params)? sendTransaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisconnectRpcRequest value) disconnect,
    required TResult Function(SendTransactionRpcRequest value) sendTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisconnectRpcRequest value)? disconnect,
    TResult? Function(SendTransactionRpcRequest value)? sendTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisconnectRpcRequest value)? disconnect,
    TResult Function(SendTransactionRpcRequest value)? sendTransaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this RpcRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RpcRequestCopyWith<RpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcRequestCopyWith<$Res> {
  factory $RpcRequestCopyWith(
          RpcRequest value, $Res Function(RpcRequest) then) =
      _$RpcRequestCopyWithImpl<$Res, RpcRequest>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$RpcRequestCopyWithImpl<$Res, $Val extends RpcRequest>
    implements $RpcRequestCopyWith<$Res> {
  _$RpcRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DisconnectRpcRequestImplCopyWith<$Res>
    implements $RpcRequestCopyWith<$Res> {
  factory _$$DisconnectRpcRequestImplCopyWith(_$DisconnectRpcRequestImpl value,
          $Res Function(_$DisconnectRpcRequestImpl) then) =
      __$$DisconnectRpcRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<dynamic> params});
}

/// @nodoc
class __$$DisconnectRpcRequestImplCopyWithImpl<$Res>
    extends _$RpcRequestCopyWithImpl<$Res, _$DisconnectRpcRequestImpl>
    implements _$$DisconnectRpcRequestImplCopyWith<$Res> {
  __$$DisconnectRpcRequestImplCopyWithImpl(_$DisconnectRpcRequestImpl _value,
      $Res Function(_$DisconnectRpcRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(_$DisconnectRpcRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value._params
          : params // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DisconnectRpcRequestImpl implements DisconnectRpcRequest {
  const _$DisconnectRpcRequestImpl(
      {required this.id,
      final List<dynamic> params = const [],
      final String? $type})
      : _params = params,
        $type = $type ?? 'disconnect';

  factory _$DisconnectRpcRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DisconnectRpcRequestImplFromJson(json);

  @override
  final String id;
  final List<dynamic> _params;
  @override
  @JsonKey()
  List<dynamic> get params {
    if (_params is EqualUnmodifiableListView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_params);
  }

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'RpcRequest.disconnect(id: $id, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectRpcRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._params, _params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_params));

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DisconnectRpcRequestImplCopyWith<_$DisconnectRpcRequestImpl>
      get copyWith =>
          __$$DisconnectRpcRequestImplCopyWithImpl<_$DisconnectRpcRequestImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, List<dynamic> params) disconnect,
    required TResult Function(String id, List<String> params) sendTransaction,
  }) {
    return disconnect(id, params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, List<dynamic> params)? disconnect,
    TResult? Function(String id, List<String> params)? sendTransaction,
  }) {
    return disconnect?.call(id, params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, List<dynamic> params)? disconnect,
    TResult Function(String id, List<String> params)? sendTransaction,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(id, params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisconnectRpcRequest value) disconnect,
    required TResult Function(SendTransactionRpcRequest value) sendTransaction,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisconnectRpcRequest value)? disconnect,
    TResult? Function(SendTransactionRpcRequest value)? sendTransaction,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisconnectRpcRequest value)? disconnect,
    TResult Function(SendTransactionRpcRequest value)? sendTransaction,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DisconnectRpcRequestImplToJson(
      this,
    );
  }
}

abstract class DisconnectRpcRequest implements RpcRequest {
  const factory DisconnectRpcRequest(
      {required final String id,
      final List<dynamic> params}) = _$DisconnectRpcRequestImpl;

  factory DisconnectRpcRequest.fromJson(Map<String, dynamic> json) =
      _$DisconnectRpcRequestImpl.fromJson;

  @override
  String get id;
  @override
  List<dynamic> get params;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DisconnectRpcRequestImplCopyWith<_$DisconnectRpcRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTransactionRpcRequestImplCopyWith<$Res>
    implements $RpcRequestCopyWith<$Res> {
  factory _$$SendTransactionRpcRequestImplCopyWith(
          _$SendTransactionRpcRequestImpl value,
          $Res Function(_$SendTransactionRpcRequestImpl) then) =
      __$$SendTransactionRpcRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<String> params});
}

/// @nodoc
class __$$SendTransactionRpcRequestImplCopyWithImpl<$Res>
    extends _$RpcRequestCopyWithImpl<$Res, _$SendTransactionRpcRequestImpl>
    implements _$$SendTransactionRpcRequestImplCopyWith<$Res> {
  __$$SendTransactionRpcRequestImplCopyWithImpl(
      _$SendTransactionRpcRequestImpl _value,
      $Res Function(_$SendTransactionRpcRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(_$SendTransactionRpcRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value._params
          : params // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendTransactionRpcRequestImpl implements SendTransactionRpcRequest {
  const _$SendTransactionRpcRequestImpl(
      {required this.id,
      required final List<String> params,
      final String? $type})
      : _params = params,
        $type = $type ?? 'sendTransaction';

  factory _$SendTransactionRpcRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendTransactionRpcRequestImplFromJson(json);

  @override
  final String id;
  final List<String> _params;
  @override
  List<String> get params {
    if (_params is EqualUnmodifiableListView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_params);
  }

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'RpcRequest.sendTransaction(id: $id, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionRpcRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._params, _params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_params));

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionRpcRequestImplCopyWith<_$SendTransactionRpcRequestImpl>
      get copyWith => __$$SendTransactionRpcRequestImplCopyWithImpl<
          _$SendTransactionRpcRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, List<dynamic> params) disconnect,
    required TResult Function(String id, List<String> params) sendTransaction,
  }) {
    return sendTransaction(id, params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, List<dynamic> params)? disconnect,
    TResult? Function(String id, List<String> params)? sendTransaction,
  }) {
    return sendTransaction?.call(id, params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, List<dynamic> params)? disconnect,
    TResult Function(String id, List<String> params)? sendTransaction,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(id, params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisconnectRpcRequest value) disconnect,
    required TResult Function(SendTransactionRpcRequest value) sendTransaction,
  }) {
    return sendTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisconnectRpcRequest value)? disconnect,
    TResult? Function(SendTransactionRpcRequest value)? sendTransaction,
  }) {
    return sendTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisconnectRpcRequest value)? disconnect,
    TResult Function(SendTransactionRpcRequest value)? sendTransaction,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SendTransactionRpcRequestImplToJson(
      this,
    );
  }
}

abstract class SendTransactionRpcRequest implements RpcRequest {
  const factory SendTransactionRpcRequest(
      {required final String id,
      required final List<String> params}) = _$SendTransactionRpcRequestImpl;

  factory SendTransactionRpcRequest.fromJson(Map<String, dynamic> json) =
      _$SendTransactionRpcRequestImpl.fromJson;

  @override
  String get id;
  @override
  List<String> get params;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTransactionRpcRequestImplCopyWith<_$SendTransactionRpcRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
