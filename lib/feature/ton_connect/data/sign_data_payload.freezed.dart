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
SignDataPayload _$SignDataPayloadFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'cell':
          return SignDataPayloadCell.fromJson(
            json
          );
                case 'text':
          return SignDataPayloadText.fromJson(
            json
          );
                case 'binary':
          return SignDataPayloadBinary.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SignDataPayload',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SignDataPayload {

 TonNetwork? get network; String? get from;
/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataPayloadCopyWith<SignDataPayload> get copyWith => _$SignDataPayloadCopyWithImpl<SignDataPayload>(this as SignDataPayload, _$identity);

  /// Serializes this SignDataPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataPayload&&(identical(other.network, network) || other.network == network)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,from);

@override
String toString() {
  return 'SignDataPayload(network: $network, from: $from)';
}


}

/// @nodoc
abstract mixin class $SignDataPayloadCopyWith<$Res>  {
  factory $SignDataPayloadCopyWith(SignDataPayload value, $Res Function(SignDataPayload) _then) = _$SignDataPayloadCopyWithImpl;
@useResult
$Res call({
 TonNetwork? network, String? from
});




}
/// @nodoc
class _$SignDataPayloadCopyWithImpl<$Res>
    implements $SignDataPayloadCopyWith<$Res> {
  _$SignDataPayloadCopyWithImpl(this._self, this._then);

  final SignDataPayload _self;
  final $Res Function(SignDataPayload) _then;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = freezed,Object? from = freezed,}) {
  return _then(_self.copyWith(
network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignDataPayloadCell value)?  cell,TResult Function( SignDataPayloadText value)?  text,TResult Function( SignDataPayloadBinary value)?  binary,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignDataPayloadCell() when cell != null:
return cell(_that);case SignDataPayloadText() when text != null:
return text(_that);case SignDataPayloadBinary() when binary != null:
return binary(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignDataPayloadCell value)  cell,required TResult Function( SignDataPayloadText value)  text,required TResult Function( SignDataPayloadBinary value)  binary,}){
final _that = this;
switch (_that) {
case SignDataPayloadCell():
return cell(_that);case SignDataPayloadText():
return text(_that);case SignDataPayloadBinary():
return binary(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignDataPayloadCell value)?  cell,TResult? Function( SignDataPayloadText value)?  text,TResult? Function( SignDataPayloadBinary value)?  binary,}){
final _that = this;
switch (_that) {
case SignDataPayloadCell() when cell != null:
return cell(_that);case SignDataPayloadText() when text != null:
return text(_that);case SignDataPayloadBinary() when binary != null:
return binary(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String schema,  String cell,  TonNetwork? network,  String? from)?  cell,TResult Function( String text,  TonNetwork? network,  String? from)?  text,TResult Function( String bytes,  TonNetwork? network,  String? from)?  binary,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignDataPayloadCell() when cell != null:
return cell(_that.schema,_that.cell,_that.network,_that.from);case SignDataPayloadText() when text != null:
return text(_that.text,_that.network,_that.from);case SignDataPayloadBinary() when binary != null:
return binary(_that.bytes,_that.network,_that.from);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String schema,  String cell,  TonNetwork? network,  String? from)  cell,required TResult Function( String text,  TonNetwork? network,  String? from)  text,required TResult Function( String bytes,  TonNetwork? network,  String? from)  binary,}) {final _that = this;
switch (_that) {
case SignDataPayloadCell():
return cell(_that.schema,_that.cell,_that.network,_that.from);case SignDataPayloadText():
return text(_that.text,_that.network,_that.from);case SignDataPayloadBinary():
return binary(_that.bytes,_that.network,_that.from);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String schema,  String cell,  TonNetwork? network,  String? from)?  cell,TResult? Function( String text,  TonNetwork? network,  String? from)?  text,TResult? Function( String bytes,  TonNetwork? network,  String? from)?  binary,}) {final _that = this;
switch (_that) {
case SignDataPayloadCell() when cell != null:
return cell(_that.schema,_that.cell,_that.network,_that.from);case SignDataPayloadText() when text != null:
return text(_that.text,_that.network,_that.from);case SignDataPayloadBinary() when binary != null:
return binary(_that.bytes,_that.network,_that.from);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SignDataPayloadCell implements SignDataPayload {
  const SignDataPayloadCell({required this.schema, required this.cell, this.network, this.from, final  String? $type}): $type = $type ?? 'cell';
  factory SignDataPayloadCell.fromJson(Map<String, dynamic> json) => _$SignDataPayloadCellFromJson(json);

 final  String schema;
 final  String cell;
@override final  TonNetwork? network;
@override final  String? from;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataPayloadCellCopyWith<SignDataPayloadCell> get copyWith => _$SignDataPayloadCellCopyWithImpl<SignDataPayloadCell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignDataPayloadCellToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataPayloadCell&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.cell, cell) || other.cell == cell)&&(identical(other.network, network) || other.network == network)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,cell,network,from);

@override
String toString() {
  return 'SignDataPayload.cell(schema: $schema, cell: $cell, network: $network, from: $from)';
}


}

/// @nodoc
abstract mixin class $SignDataPayloadCellCopyWith<$Res> implements $SignDataPayloadCopyWith<$Res> {
  factory $SignDataPayloadCellCopyWith(SignDataPayloadCell value, $Res Function(SignDataPayloadCell) _then) = _$SignDataPayloadCellCopyWithImpl;
@override @useResult
$Res call({
 String schema, String cell, TonNetwork? network, String? from
});




}
/// @nodoc
class _$SignDataPayloadCellCopyWithImpl<$Res>
    implements $SignDataPayloadCellCopyWith<$Res> {
  _$SignDataPayloadCellCopyWithImpl(this._self, this._then);

  final SignDataPayloadCell _self;
  final $Res Function(SignDataPayloadCell) _then;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? cell = null,Object? network = freezed,Object? from = freezed,}) {
  return _then(SignDataPayloadCell(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,cell: null == cell ? _self.cell : cell // ignore: cast_nullable_to_non_nullable
as String,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SignDataPayloadText implements SignDataPayload {
  const SignDataPayloadText({required this.text, this.network, this.from, final  String? $type}): $type = $type ?? 'text';
  factory SignDataPayloadText.fromJson(Map<String, dynamic> json) => _$SignDataPayloadTextFromJson(json);

 final  String text;
@override final  TonNetwork? network;
@override final  String? from;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataPayloadTextCopyWith<SignDataPayloadText> get copyWith => _$SignDataPayloadTextCopyWithImpl<SignDataPayloadText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignDataPayloadTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataPayloadText&&(identical(other.text, text) || other.text == text)&&(identical(other.network, network) || other.network == network)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,network,from);

@override
String toString() {
  return 'SignDataPayload.text(text: $text, network: $network, from: $from)';
}


}

/// @nodoc
abstract mixin class $SignDataPayloadTextCopyWith<$Res> implements $SignDataPayloadCopyWith<$Res> {
  factory $SignDataPayloadTextCopyWith(SignDataPayloadText value, $Res Function(SignDataPayloadText) _then) = _$SignDataPayloadTextCopyWithImpl;
@override @useResult
$Res call({
 String text, TonNetwork? network, String? from
});




}
/// @nodoc
class _$SignDataPayloadTextCopyWithImpl<$Res>
    implements $SignDataPayloadTextCopyWith<$Res> {
  _$SignDataPayloadTextCopyWithImpl(this._self, this._then);

  final SignDataPayloadText _self;
  final $Res Function(SignDataPayloadText) _then;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? network = freezed,Object? from = freezed,}) {
  return _then(SignDataPayloadText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SignDataPayloadBinary implements SignDataPayload {
  const SignDataPayloadBinary({required this.bytes, this.network, this.from, final  String? $type}): $type = $type ?? 'binary';
  factory SignDataPayloadBinary.fromJson(Map<String, dynamic> json) => _$SignDataPayloadBinaryFromJson(json);

 final  String bytes;
@override final  TonNetwork? network;
@override final  String? from;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataPayloadBinaryCopyWith<SignDataPayloadBinary> get copyWith => _$SignDataPayloadBinaryCopyWithImpl<SignDataPayloadBinary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignDataPayloadBinaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataPayloadBinary&&(identical(other.bytes, bytes) || other.bytes == bytes)&&(identical(other.network, network) || other.network == network)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bytes,network,from);

@override
String toString() {
  return 'SignDataPayload.binary(bytes: $bytes, network: $network, from: $from)';
}


}

/// @nodoc
abstract mixin class $SignDataPayloadBinaryCopyWith<$Res> implements $SignDataPayloadCopyWith<$Res> {
  factory $SignDataPayloadBinaryCopyWith(SignDataPayloadBinary value, $Res Function(SignDataPayloadBinary) _then) = _$SignDataPayloadBinaryCopyWithImpl;
@override @useResult
$Res call({
 String bytes, TonNetwork? network, String? from
});




}
/// @nodoc
class _$SignDataPayloadBinaryCopyWithImpl<$Res>
    implements $SignDataPayloadBinaryCopyWith<$Res> {
  _$SignDataPayloadBinaryCopyWithImpl(this._self, this._then);

  final SignDataPayloadBinary _self;
  final $Res Function(SignDataPayloadBinary) _then;

/// Create a copy of SignDataPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? network = freezed,Object? from = freezed,}) {
  return _then(SignDataPayloadBinary(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as String,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
