// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionPayload {

 List<TransactionPayloadMessage> get messages;@JsonKey(name: 'valid_until', disallowNullValue: true) int? get validUntil; TonNetwork? get network; Address? get from;
/// Create a copy of TransactionPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionPayloadCopyWith<TransactionPayload> get copyWith => _$TransactionPayloadCopyWithImpl<TransactionPayload>(this as TransactionPayload, _$identity);

  /// Serializes this TransactionPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionPayload&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&(identical(other.network, network) || other.network == network)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),validUntil,network,from);

@override
String toString() {
  return 'TransactionPayload(messages: $messages, validUntil: $validUntil, network: $network, from: $from)';
}


}

/// @nodoc
abstract mixin class $TransactionPayloadCopyWith<$Res>  {
  factory $TransactionPayloadCopyWith(TransactionPayload value, $Res Function(TransactionPayload) _then) = _$TransactionPayloadCopyWithImpl;
@useResult
$Res call({
 List<TransactionPayloadMessage> messages,@JsonKey(name: 'valid_until', disallowNullValue: true) int? validUntil, TonNetwork? network, Address? from
});


$AddressCopyWith<$Res>? get from;

}
/// @nodoc
class _$TransactionPayloadCopyWithImpl<$Res>
    implements $TransactionPayloadCopyWith<$Res> {
  _$TransactionPayloadCopyWithImpl(this._self, this._then);

  final TransactionPayload _self;
  final $Res Function(TransactionPayload) _then;

/// Create a copy of TransactionPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? validUntil = freezed,Object? network = freezed,Object? from = freezed,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TransactionPayloadMessage>,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as int?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Address?,
  ));
}
/// Create a copy of TransactionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get from {
    if (_self.from == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.from!, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionPayload].
extension TransactionPayloadPatterns on TransactionPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionPayload() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionPayload value)  $default,){
final _that = this;
switch (_that) {
case _TransactionPayload():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionPayload() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TransactionPayloadMessage> messages, @JsonKey(name: 'valid_until', disallowNullValue: true)  int? validUntil,  TonNetwork? network,  Address? from)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionPayload() when $default != null:
return $default(_that.messages,_that.validUntil,_that.network,_that.from);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TransactionPayloadMessage> messages, @JsonKey(name: 'valid_until', disallowNullValue: true)  int? validUntil,  TonNetwork? network,  Address? from)  $default,) {final _that = this;
switch (_that) {
case _TransactionPayload():
return $default(_that.messages,_that.validUntil,_that.network,_that.from);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TransactionPayloadMessage> messages, @JsonKey(name: 'valid_until', disallowNullValue: true)  int? validUntil,  TonNetwork? network,  Address? from)?  $default,) {final _that = this;
switch (_that) {
case _TransactionPayload() when $default != null:
return $default(_that.messages,_that.validUntil,_that.network,_that.from);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionPayload implements TransactionPayload {
   _TransactionPayload({required final  List<TransactionPayloadMessage> messages, @JsonKey(name: 'valid_until', disallowNullValue: true) this.validUntil, this.network, this.from}): _messages = messages;
  factory _TransactionPayload.fromJson(Map<String, dynamic> json) => _$TransactionPayloadFromJson(json);

 final  List<TransactionPayloadMessage> _messages;
@override List<TransactionPayloadMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey(name: 'valid_until', disallowNullValue: true) final  int? validUntil;
@override final  TonNetwork? network;
@override final  Address? from;

/// Create a copy of TransactionPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionPayloadCopyWith<_TransactionPayload> get copyWith => __$TransactionPayloadCopyWithImpl<_TransactionPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionPayload&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&(identical(other.network, network) || other.network == network)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),validUntil,network,from);

@override
String toString() {
  return 'TransactionPayload(messages: $messages, validUntil: $validUntil, network: $network, from: $from)';
}


}

/// @nodoc
abstract mixin class _$TransactionPayloadCopyWith<$Res> implements $TransactionPayloadCopyWith<$Res> {
  factory _$TransactionPayloadCopyWith(_TransactionPayload value, $Res Function(_TransactionPayload) _then) = __$TransactionPayloadCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionPayloadMessage> messages,@JsonKey(name: 'valid_until', disallowNullValue: true) int? validUntil, TonNetwork? network, Address? from
});


@override $AddressCopyWith<$Res>? get from;

}
/// @nodoc
class __$TransactionPayloadCopyWithImpl<$Res>
    implements _$TransactionPayloadCopyWith<$Res> {
  __$TransactionPayloadCopyWithImpl(this._self, this._then);

  final _TransactionPayload _self;
  final $Res Function(_TransactionPayload) _then;

/// Create a copy of TransactionPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? validUntil = freezed,Object? network = freezed,Object? from = freezed,}) {
  return _then(_TransactionPayload(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TransactionPayloadMessage>,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as int?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Address?,
  ));
}

/// Create a copy of TransactionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get from {
    if (_self.from == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.from!, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}

// dart format on
