// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignDataPayload {

@JsonKey(name: 'schema_crc') int get schema; String get cell; PublicKey? get publicKey;
/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataPayloadCopyWith<SignDataPayload> get copyWith => _$SignDataPayloadCopyWithImpl<SignDataPayload>(this as SignDataPayload, _$identity);

  /// Serializes this SignDataPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataPayload&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.cell, cell) || other.cell == cell)&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,cell,publicKey);

@override
String toString() {
  return 'SignDataPayload(schema: $schema, cell: $cell, publicKey: $publicKey)';
}


}

/// @nodoc
abstract mixin class $SignDataPayloadCopyWith<$Res>  {
  factory $SignDataPayloadCopyWith(SignDataPayload value, $Res Function(SignDataPayload) _then) = _$SignDataPayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'schema_crc') int schema, String cell, PublicKey? publicKey
});


$PublicKeyCopyWith<$Res>? get publicKey;

}
/// @nodoc
class _$SignDataPayloadCopyWithImpl<$Res>
    implements $SignDataPayloadCopyWith<$Res> {
  _$SignDataPayloadCopyWithImpl(this._self, this._then);

  final SignDataPayload _self;
  final $Res Function(SignDataPayload) _then;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schema = null,Object? cell = null,Object? publicKey = freezed,}) {
  return _then(_self.copyWith(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as int,cell: null == cell ? _self.cell : cell // ignore: cast_nullable_to_non_nullable
as String,publicKey: freezed == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as PublicKey?,
  ));
}
/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<$Res>? get publicKey {
    if (_self.publicKey == null) {
    return null;
  }

  return $PublicKeyCopyWith<$Res>(_self.publicKey!, (value) {
    return _then(_self.copyWith(publicKey: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignDataPayload].
extension SignDataPayloadPatterns on SignDataPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignDataPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignDataPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignDataPayload value)  $default,){
final _that = this;
switch (_that) {
case _SignDataPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignDataPayload value)?  $default,){
final _that = this;
switch (_that) {
case _SignDataPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'schema_crc')  int schema,  String cell,  PublicKey? publicKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignDataPayload() when $default != null:
return $default(_that.schema,_that.cell,_that.publicKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'schema_crc')  int schema,  String cell,  PublicKey? publicKey)  $default,) {final _that = this;
switch (_that) {
case _SignDataPayload():
return $default(_that.schema,_that.cell,_that.publicKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'schema_crc')  int schema,  String cell,  PublicKey? publicKey)?  $default,) {final _that = this;
switch (_that) {
case _SignDataPayload() when $default != null:
return $default(_that.schema,_that.cell,_that.publicKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignDataPayload implements SignDataPayload {
   _SignDataPayload({@JsonKey(name: 'schema_crc') required this.schema, required this.cell, this.publicKey});
  factory _SignDataPayload.fromJson(Map<String, dynamic> json) => _$SignDataPayloadFromJson(json);

@override@JsonKey(name: 'schema_crc') final  int schema;
@override final  String cell;
@override final  PublicKey? publicKey;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignDataPayloadCopyWith<_SignDataPayload> get copyWith => __$SignDataPayloadCopyWithImpl<_SignDataPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignDataPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignDataPayload&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.cell, cell) || other.cell == cell)&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,cell,publicKey);

@override
String toString() {
  return 'SignDataPayload(schema: $schema, cell: $cell, publicKey: $publicKey)';
}


}

/// @nodoc
abstract mixin class _$SignDataPayloadCopyWith<$Res> implements $SignDataPayloadCopyWith<$Res> {
  factory _$SignDataPayloadCopyWith(_SignDataPayload value, $Res Function(_SignDataPayload) _then) = __$SignDataPayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'schema_crc') int schema, String cell, PublicKey? publicKey
});


@override $PublicKeyCopyWith<$Res>? get publicKey;

}
/// @nodoc
class __$SignDataPayloadCopyWithImpl<$Res>
    implements _$SignDataPayloadCopyWith<$Res> {
  __$SignDataPayloadCopyWithImpl(this._self, this._then);

  final _SignDataPayload _self;
  final $Res Function(_SignDataPayload) _then;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? cell = null,Object? publicKey = freezed,}) {
  return _then(_SignDataPayload(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as int,cell: null == cell ? _self.cell : cell // ignore: cast_nullable_to_non_nullable
as String,publicKey: freezed == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as PublicKey?,
  ));
}

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<$Res>? get publicKey {
    if (_self.publicKey == null) {
    return null;
  }

  return $PublicKeyCopyWith<$Res>(_self.publicKey!, (value) {
    return _then(_self.copyWith(publicKey: value));
  });
}
}

// dart format on
