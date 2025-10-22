// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_network_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionNetworkDto {

/// Identifier for the default network connection to use.
 String get defaultConnectionId;/// List of available networks with their configuration details.
 List<Map<String, dynamic>> get networks;/// List of available transport methods for connections.
 List<Map<String, dynamic>> get transports;/// Optional custom network configuration options.
 List<Map<String, dynamic>>? get customNetworkOtions;
/// Create a copy of ConnectionNetworkDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionNetworkDtoCopyWith<ConnectionNetworkDto> get copyWith => _$ConnectionNetworkDtoCopyWithImpl<ConnectionNetworkDto>(this as ConnectionNetworkDto, _$identity);

  /// Serializes this ConnectionNetworkDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionNetworkDto&&(identical(other.defaultConnectionId, defaultConnectionId) || other.defaultConnectionId == defaultConnectionId)&&const DeepCollectionEquality().equals(other.networks, networks)&&const DeepCollectionEquality().equals(other.transports, transports)&&const DeepCollectionEquality().equals(other.customNetworkOtions, customNetworkOtions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultConnectionId,const DeepCollectionEquality().hash(networks),const DeepCollectionEquality().hash(transports),const DeepCollectionEquality().hash(customNetworkOtions));

@override
String toString() {
  return 'ConnectionNetworkDto(defaultConnectionId: $defaultConnectionId, networks: $networks, transports: $transports, customNetworkOtions: $customNetworkOtions)';
}


}

/// @nodoc
abstract mixin class $ConnectionNetworkDtoCopyWith<$Res>  {
  factory $ConnectionNetworkDtoCopyWith(ConnectionNetworkDto value, $Res Function(ConnectionNetworkDto) _then) = _$ConnectionNetworkDtoCopyWithImpl;
@useResult
$Res call({
 String defaultConnectionId, List<Map<String, dynamic>> networks, List<Map<String, dynamic>> transports, List<Map<String, dynamic>>? customNetworkOtions
});




}
/// @nodoc
class _$ConnectionNetworkDtoCopyWithImpl<$Res>
    implements $ConnectionNetworkDtoCopyWith<$Res> {
  _$ConnectionNetworkDtoCopyWithImpl(this._self, this._then);

  final ConnectionNetworkDto _self;
  final $Res Function(ConnectionNetworkDto) _then;

/// Create a copy of ConnectionNetworkDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultConnectionId = null,Object? networks = null,Object? transports = null,Object? customNetworkOtions = freezed,}) {
  return _then(_self.copyWith(
defaultConnectionId: null == defaultConnectionId ? _self.defaultConnectionId : defaultConnectionId // ignore: cast_nullable_to_non_nullable
as String,networks: null == networks ? _self.networks : networks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,transports: null == transports ? _self.transports : transports // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,customNetworkOtions: freezed == customNetworkOtions ? _self.customNetworkOtions : customNetworkOtions // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectionNetworkDto].
extension ConnectionNetworkDtoPatterns on ConnectionNetworkDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionNetworkDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionNetworkDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionNetworkDto value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionNetworkDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionNetworkDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionNetworkDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String defaultConnectionId,  List<Map<String, dynamic>> networks,  List<Map<String, dynamic>> transports,  List<Map<String, dynamic>>? customNetworkOtions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionNetworkDto() when $default != null:
return $default(_that.defaultConnectionId,_that.networks,_that.transports,_that.customNetworkOtions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String defaultConnectionId,  List<Map<String, dynamic>> networks,  List<Map<String, dynamic>> transports,  List<Map<String, dynamic>>? customNetworkOtions)  $default,) {final _that = this;
switch (_that) {
case _ConnectionNetworkDto():
return $default(_that.defaultConnectionId,_that.networks,_that.transports,_that.customNetworkOtions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String defaultConnectionId,  List<Map<String, dynamic>> networks,  List<Map<String, dynamic>> transports,  List<Map<String, dynamic>>? customNetworkOtions)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionNetworkDto() when $default != null:
return $default(_that.defaultConnectionId,_that.networks,_that.transports,_that.customNetworkOtions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectionNetworkDto implements ConnectionNetworkDto {
  const _ConnectionNetworkDto({required this.defaultConnectionId, required final  List<Map<String, dynamic>> networks, required final  List<Map<String, dynamic>> transports, final  List<Map<String, dynamic>>? customNetworkOtions}): _networks = networks,_transports = transports,_customNetworkOtions = customNetworkOtions;
  factory _ConnectionNetworkDto.fromJson(Map<String, dynamic> json) => _$ConnectionNetworkDtoFromJson(json);

/// Identifier for the default network connection to use.
@override final  String defaultConnectionId;
/// List of available networks with their configuration details.
 final  List<Map<String, dynamic>> _networks;
/// List of available networks with their configuration details.
@override List<Map<String, dynamic>> get networks {
  if (_networks is EqualUnmodifiableListView) return _networks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_networks);
}

/// List of available transport methods for connections.
 final  List<Map<String, dynamic>> _transports;
/// List of available transport methods for connections.
@override List<Map<String, dynamic>> get transports {
  if (_transports is EqualUnmodifiableListView) return _transports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transports);
}

/// Optional custom network configuration options.
 final  List<Map<String, dynamic>>? _customNetworkOtions;
/// Optional custom network configuration options.
@override List<Map<String, dynamic>>? get customNetworkOtions {
  final value = _customNetworkOtions;
  if (value == null) return null;
  if (_customNetworkOtions is EqualUnmodifiableListView) return _customNetworkOtions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ConnectionNetworkDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionNetworkDtoCopyWith<_ConnectionNetworkDto> get copyWith => __$ConnectionNetworkDtoCopyWithImpl<_ConnectionNetworkDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectionNetworkDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionNetworkDto&&(identical(other.defaultConnectionId, defaultConnectionId) || other.defaultConnectionId == defaultConnectionId)&&const DeepCollectionEquality().equals(other._networks, _networks)&&const DeepCollectionEquality().equals(other._transports, _transports)&&const DeepCollectionEquality().equals(other._customNetworkOtions, _customNetworkOtions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultConnectionId,const DeepCollectionEquality().hash(_networks),const DeepCollectionEquality().hash(_transports),const DeepCollectionEquality().hash(_customNetworkOtions));

@override
String toString() {
  return 'ConnectionNetworkDto(defaultConnectionId: $defaultConnectionId, networks: $networks, transports: $transports, customNetworkOtions: $customNetworkOtions)';
}


}

/// @nodoc
abstract mixin class _$ConnectionNetworkDtoCopyWith<$Res> implements $ConnectionNetworkDtoCopyWith<$Res> {
  factory _$ConnectionNetworkDtoCopyWith(_ConnectionNetworkDto value, $Res Function(_ConnectionNetworkDto) _then) = __$ConnectionNetworkDtoCopyWithImpl;
@override @useResult
$Res call({
 String defaultConnectionId, List<Map<String, dynamic>> networks, List<Map<String, dynamic>> transports, List<Map<String, dynamic>>? customNetworkOtions
});




}
/// @nodoc
class __$ConnectionNetworkDtoCopyWithImpl<$Res>
    implements _$ConnectionNetworkDtoCopyWith<$Res> {
  __$ConnectionNetworkDtoCopyWithImpl(this._self, this._then);

  final _ConnectionNetworkDto _self;
  final $Res Function(_ConnectionNetworkDto) _then;

/// Create a copy of ConnectionNetworkDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultConnectionId = null,Object? networks = null,Object? transports = null,Object? customNetworkOtions = freezed,}) {
  return _then(_ConnectionNetworkDto(
defaultConnectionId: null == defaultConnectionId ? _self.defaultConnectionId : defaultConnectionId // ignore: cast_nullable_to_non_nullable
as String,networks: null == networks ? _self._networks : networks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,transports: null == transports ? _self._transports : transports // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,customNetworkOtions: freezed == customNetworkOtions ? _self._customNetworkOtions : customNetworkOtions // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}


}

// dart format on
