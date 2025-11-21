// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_connect_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TonConnectUiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TonConnectUiEvent()';
}


}

/// @nodoc
class $TonConnectUiEventCopyWith<$Res>  {
$TonConnectUiEventCopyWith(TonConnectUiEvent _, $Res Function(TonConnectUiEvent) __);
}


/// Adds pattern-matching-related methods to [TonConnectUiEvent].
extension TonConnectUiEventPatterns on TonConnectUiEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TonConnectUiEventError value)?  error,TResult Function( TonConnectUiEventConnect value)?  connect,TResult Function( TonConnectUiEventSendTransaction value)?  sendTransaction,TResult Function( TonConnectUiEventSignData value)?  signData,TResult Function( TonConnectUiEventChangeNetwork value)?  changeNetwork,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TonConnectUiEventError() when error != null:
return error(_that);case TonConnectUiEventConnect() when connect != null:
return connect(_that);case TonConnectUiEventSendTransaction() when sendTransaction != null:
return sendTransaction(_that);case TonConnectUiEventSignData() when signData != null:
return signData(_that);case TonConnectUiEventChangeNetwork() when changeNetwork != null:
return changeNetwork(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TonConnectUiEventError value)  error,required TResult Function( TonConnectUiEventConnect value)  connect,required TResult Function( TonConnectUiEventSendTransaction value)  sendTransaction,required TResult Function( TonConnectUiEventSignData value)  signData,required TResult Function( TonConnectUiEventChangeNetwork value)  changeNetwork,}){
final _that = this;
switch (_that) {
case TonConnectUiEventError():
return error(_that);case TonConnectUiEventConnect():
return connect(_that);case TonConnectUiEventSendTransaction():
return sendTransaction(_that);case TonConnectUiEventSignData():
return signData(_that);case TonConnectUiEventChangeNetwork():
return changeNetwork(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TonConnectUiEventError value)?  error,TResult? Function( TonConnectUiEventConnect value)?  connect,TResult? Function( TonConnectUiEventSendTransaction value)?  sendTransaction,TResult? Function( TonConnectUiEventSignData value)?  signData,TResult? Function( TonConnectUiEventChangeNetwork value)?  changeNetwork,}){
final _that = this;
switch (_that) {
case TonConnectUiEventError() when error != null:
return error(_that);case TonConnectUiEventConnect() when connect != null:
return connect(_that);case TonConnectUiEventSendTransaction() when sendTransaction != null:
return sendTransaction(_that);case TonConnectUiEventSignData() when signData != null:
return signData(_that);case TonConnectUiEventChangeNetwork() when changeNetwork != null:
return changeNetwork(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  error,TResult Function( ConnectRequest request,  DappManifest manifest,  Completer<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>> completer)?  connect,TResult Function( TonAppConnection connection,  TransactionPayload payload,  Completer<TonConnectUiEventResult<SignedMessage>> completer)?  sendTransaction,TResult Function( TonAppConnection connection,  SignDataPayload payload,  Completer<TonConnectUiEventResult<SignDataResult>> completer)?  signData,TResult Function( Uri origin,  int networkId,  List<ConnectionData> connections,  Completer<TransportStrategy?> completer)?  changeNetwork,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TonConnectUiEventError() when error != null:
return error(_that.message);case TonConnectUiEventConnect() when connect != null:
return connect(_that.request,_that.manifest,_that.completer);case TonConnectUiEventSendTransaction() when sendTransaction != null:
return sendTransaction(_that.connection,_that.payload,_that.completer);case TonConnectUiEventSignData() when signData != null:
return signData(_that.connection,_that.payload,_that.completer);case TonConnectUiEventChangeNetwork() when changeNetwork != null:
return changeNetwork(_that.origin,_that.networkId,_that.connections,_that.completer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  error,required TResult Function( ConnectRequest request,  DappManifest manifest,  Completer<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>> completer)  connect,required TResult Function( TonAppConnection connection,  TransactionPayload payload,  Completer<TonConnectUiEventResult<SignedMessage>> completer)  sendTransaction,required TResult Function( TonAppConnection connection,  SignDataPayload payload,  Completer<TonConnectUiEventResult<SignDataResult>> completer)  signData,required TResult Function( Uri origin,  int networkId,  List<ConnectionData> connections,  Completer<TransportStrategy?> completer)  changeNetwork,}) {final _that = this;
switch (_that) {
case TonConnectUiEventError():
return error(_that.message);case TonConnectUiEventConnect():
return connect(_that.request,_that.manifest,_that.completer);case TonConnectUiEventSendTransaction():
return sendTransaction(_that.connection,_that.payload,_that.completer);case TonConnectUiEventSignData():
return signData(_that.connection,_that.payload,_that.completer);case TonConnectUiEventChangeNetwork():
return changeNetwork(_that.origin,_that.networkId,_that.connections,_that.completer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  error,TResult? Function( ConnectRequest request,  DappManifest manifest,  Completer<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>> completer)?  connect,TResult? Function( TonAppConnection connection,  TransactionPayload payload,  Completer<TonConnectUiEventResult<SignedMessage>> completer)?  sendTransaction,TResult? Function( TonAppConnection connection,  SignDataPayload payload,  Completer<TonConnectUiEventResult<SignDataResult>> completer)?  signData,TResult? Function( Uri origin,  int networkId,  List<ConnectionData> connections,  Completer<TransportStrategy?> completer)?  changeNetwork,}) {final _that = this;
switch (_that) {
case TonConnectUiEventError() when error != null:
return error(_that.message);case TonConnectUiEventConnect() when connect != null:
return connect(_that.request,_that.manifest,_that.completer);case TonConnectUiEventSendTransaction() when sendTransaction != null:
return sendTransaction(_that.connection,_that.payload,_that.completer);case TonConnectUiEventSignData() when signData != null:
return signData(_that.connection,_that.payload,_that.completer);case TonConnectUiEventChangeNetwork() when changeNetwork != null:
return changeNetwork(_that.origin,_that.networkId,_that.connections,_that.completer);case _:
  return null;

}
}

}

/// @nodoc


class TonConnectUiEventError implements TonConnectUiEvent {
   TonConnectUiEventError({required this.message});
  

 final  String message;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventErrorCopyWith<TonConnectUiEventError> get copyWith => _$TonConnectUiEventErrorCopyWithImpl<TonConnectUiEventError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TonConnectUiEvent.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventErrorCopyWith<$Res> implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventErrorCopyWith(TonConnectUiEventError value, $Res Function(TonConnectUiEventError) _then) = _$TonConnectUiEventErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TonConnectUiEventErrorCopyWithImpl<$Res>
    implements $TonConnectUiEventErrorCopyWith<$Res> {
  _$TonConnectUiEventErrorCopyWithImpl(this._self, this._then);

  final TonConnectUiEventError _self;
  final $Res Function(TonConnectUiEventError) _then;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TonConnectUiEventError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TonConnectUiEventConnect implements TonConnectUiEvent {
   TonConnectUiEventConnect({required this.request, required this.manifest, required this.completer});
  

 final  ConnectRequest request;
 final  DappManifest manifest;
 final  Completer<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>> completer;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventConnectCopyWith<TonConnectUiEventConnect> get copyWith => _$TonConnectUiEventConnectCopyWithImpl<TonConnectUiEventConnect>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventConnect&&(identical(other.request, request) || other.request == request)&&(identical(other.manifest, manifest) || other.manifest == manifest)&&(identical(other.completer, completer) || other.completer == completer));
}


@override
int get hashCode => Object.hash(runtimeType,request,manifest,completer);

@override
String toString() {
  return 'TonConnectUiEvent.connect(request: $request, manifest: $manifest, completer: $completer)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventConnectCopyWith<$Res> implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventConnectCopyWith(TonConnectUiEventConnect value, $Res Function(TonConnectUiEventConnect) _then) = _$TonConnectUiEventConnectCopyWithImpl;
@useResult
$Res call({
 ConnectRequest request, DappManifest manifest, Completer<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>> completer
});


$ConnectRequestCopyWith<$Res> get request;$DappManifestCopyWith<$Res> get manifest;

}
/// @nodoc
class _$TonConnectUiEventConnectCopyWithImpl<$Res>
    implements $TonConnectUiEventConnectCopyWith<$Res> {
  _$TonConnectUiEventConnectCopyWithImpl(this._self, this._then);

  final TonConnectUiEventConnect _self;
  final $Res Function(TonConnectUiEventConnect) _then;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,Object? manifest = null,Object? completer = null,}) {
  return _then(TonConnectUiEventConnect(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ConnectRequest,manifest: null == manifest ? _self.manifest : manifest // ignore: cast_nullable_to_non_nullable
as DappManifest,completer: null == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>>,
  ));
}

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectRequestCopyWith<$Res> get request {
  
  return $ConnectRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DappManifestCopyWith<$Res> get manifest {
  
  return $DappManifestCopyWith<$Res>(_self.manifest, (value) {
    return _then(_self.copyWith(manifest: value));
  });
}
}

/// @nodoc


class TonConnectUiEventSendTransaction implements TonConnectUiEvent {
   TonConnectUiEventSendTransaction({required this.connection, required this.payload, required this.completer});
  

 final  TonAppConnection connection;
 final  TransactionPayload payload;
 final  Completer<TonConnectUiEventResult<SignedMessage>> completer;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventSendTransactionCopyWith<TonConnectUiEventSendTransaction> get copyWith => _$TonConnectUiEventSendTransactionCopyWithImpl<TonConnectUiEventSendTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventSendTransaction&&(identical(other.connection, connection) || other.connection == connection)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.completer, completer) || other.completer == completer));
}


@override
int get hashCode => Object.hash(runtimeType,connection,payload,completer);

@override
String toString() {
  return 'TonConnectUiEvent.sendTransaction(connection: $connection, payload: $payload, completer: $completer)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventSendTransactionCopyWith<$Res> implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventSendTransactionCopyWith(TonConnectUiEventSendTransaction value, $Res Function(TonConnectUiEventSendTransaction) _then) = _$TonConnectUiEventSendTransactionCopyWithImpl;
@useResult
$Res call({
 TonAppConnection connection, TransactionPayload payload, Completer<TonConnectUiEventResult<SignedMessage>> completer
});


$TonAppConnectionCopyWith<$Res> get connection;$TransactionPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$TonConnectUiEventSendTransactionCopyWithImpl<$Res>
    implements $TonConnectUiEventSendTransactionCopyWith<$Res> {
  _$TonConnectUiEventSendTransactionCopyWithImpl(this._self, this._then);

  final TonConnectUiEventSendTransaction _self;
  final $Res Function(TonConnectUiEventSendTransaction) _then;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? connection = null,Object? payload = null,Object? completer = null,}) {
  return _then(TonConnectUiEventSendTransaction(
connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as TonAppConnection,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as TransactionPayload,completer: null == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<TonConnectUiEventResult<SignedMessage>>,
  ));
}

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TonAppConnectionCopyWith<$Res> get connection {
  
  return $TonAppConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionPayloadCopyWith<$Res> get payload {
  
  return $TransactionPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}

/// @nodoc


class TonConnectUiEventSignData implements TonConnectUiEvent {
   TonConnectUiEventSignData({required this.connection, required this.payload, required this.completer});
  

 final  TonAppConnection connection;
 final  SignDataPayload payload;
 final  Completer<TonConnectUiEventResult<SignDataResult>> completer;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventSignDataCopyWith<TonConnectUiEventSignData> get copyWith => _$TonConnectUiEventSignDataCopyWithImpl<TonConnectUiEventSignData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventSignData&&(identical(other.connection, connection) || other.connection == connection)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.completer, completer) || other.completer == completer));
}


@override
int get hashCode => Object.hash(runtimeType,connection,payload,completer);

@override
String toString() {
  return 'TonConnectUiEvent.signData(connection: $connection, payload: $payload, completer: $completer)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventSignDataCopyWith<$Res> implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventSignDataCopyWith(TonConnectUiEventSignData value, $Res Function(TonConnectUiEventSignData) _then) = _$TonConnectUiEventSignDataCopyWithImpl;
@useResult
$Res call({
 TonAppConnection connection, SignDataPayload payload, Completer<TonConnectUiEventResult<SignDataResult>> completer
});


$TonAppConnectionCopyWith<$Res> get connection;$SignDataPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$TonConnectUiEventSignDataCopyWithImpl<$Res>
    implements $TonConnectUiEventSignDataCopyWith<$Res> {
  _$TonConnectUiEventSignDataCopyWithImpl(this._self, this._then);

  final TonConnectUiEventSignData _self;
  final $Res Function(TonConnectUiEventSignData) _then;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? connection = null,Object? payload = null,Object? completer = null,}) {
  return _then(TonConnectUiEventSignData(
connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as TonAppConnection,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as SignDataPayload,completer: null == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<TonConnectUiEventResult<SignDataResult>>,
  ));
}

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TonAppConnectionCopyWith<$Res> get connection {
  
  return $TonAppConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignDataPayloadCopyWith<$Res> get payload {
  
  return $SignDataPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}

/// @nodoc


class TonConnectUiEventChangeNetwork implements TonConnectUiEvent {
   TonConnectUiEventChangeNetwork({required this.origin, required this.networkId, required final  List<ConnectionData> connections, required this.completer}): _connections = connections;
  

 final  Uri origin;
 final  int networkId;
 final  List<ConnectionData> _connections;
 List<ConnectionData> get connections {
  if (_connections is EqualUnmodifiableListView) return _connections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_connections);
}

 final  Completer<TransportStrategy?> completer;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventChangeNetworkCopyWith<TonConnectUiEventChangeNetwork> get copyWith => _$TonConnectUiEventChangeNetworkCopyWithImpl<TonConnectUiEventChangeNetwork>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventChangeNetwork&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.networkId, networkId) || other.networkId == networkId)&&const DeepCollectionEquality().equals(other._connections, _connections)&&(identical(other.completer, completer) || other.completer == completer));
}


@override
int get hashCode => Object.hash(runtimeType,origin,networkId,const DeepCollectionEquality().hash(_connections),completer);

@override
String toString() {
  return 'TonConnectUiEvent.changeNetwork(origin: $origin, networkId: $networkId, connections: $connections, completer: $completer)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventChangeNetworkCopyWith<$Res> implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventChangeNetworkCopyWith(TonConnectUiEventChangeNetwork value, $Res Function(TonConnectUiEventChangeNetwork) _then) = _$TonConnectUiEventChangeNetworkCopyWithImpl;
@useResult
$Res call({
 Uri origin, int networkId, List<ConnectionData> connections, Completer<TransportStrategy?> completer
});




}
/// @nodoc
class _$TonConnectUiEventChangeNetworkCopyWithImpl<$Res>
    implements $TonConnectUiEventChangeNetworkCopyWith<$Res> {
  _$TonConnectUiEventChangeNetworkCopyWithImpl(this._self, this._then);

  final TonConnectUiEventChangeNetwork _self;
  final $Res Function(TonConnectUiEventChangeNetwork) _then;

/// Create a copy of TonConnectUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? origin = null,Object? networkId = null,Object? connections = null,Object? completer = null,}) {
  return _then(TonConnectUiEventChangeNetwork(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as Uri,networkId: null == networkId ? _self.networkId : networkId // ignore: cast_nullable_to_non_nullable
as int,connections: null == connections ? _self._connections : connections // ignore: cast_nullable_to_non_nullable
as List<ConnectionData>,completer: null == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<TransportStrategy?>,
  ));
}


}

// dart format on
