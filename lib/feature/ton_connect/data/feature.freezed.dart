// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Feature _$FeatureFromJson(
  Map<String, dynamic> json
) {
        switch (json['name']) {
                  case 'SendTransaction':
          return _SendTransaction.fromJson(
            json
          );
                case 'SignData':
          return _SignData.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'name',
  'Feature',
  'Invalid union type "${json['name']}"!'
);
        }
      
}

/// @nodoc
mixin _$Feature {



  /// Serializes this Feature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Feature);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Feature()';
}


}

/// @nodoc
class $FeatureCopyWith<$Res>  {
$FeatureCopyWith(Feature _, $Res Function(Feature) __);
}


/// Adds pattern-matching-related methods to [Feature].
extension FeaturePatterns on Feature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SendTransaction value)?  sendTransaction,TResult Function( _SignData value)?  signData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendTransaction() when sendTransaction != null:
return sendTransaction(_that);case _SignData() when signData != null:
return signData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SendTransaction value)  sendTransaction,required TResult Function( _SignData value)  signData,}){
final _that = this;
switch (_that) {
case _SendTransaction():
return sendTransaction(_that);case _SignData():
return signData(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SendTransaction value)?  sendTransaction,TResult? Function( _SignData value)?  signData,}){
final _that = this;
switch (_that) {
case _SendTransaction() when sendTransaction != null:
return sendTransaction(_that);case _SignData() when signData != null:
return signData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int maxMessages)?  sendTransaction,TResult Function( List<String> types)?  signData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendTransaction() when sendTransaction != null:
return sendTransaction(_that.maxMessages);case _SignData() when signData != null:
return signData(_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int maxMessages)  sendTransaction,required TResult Function( List<String> types)  signData,}) {final _that = this;
switch (_that) {
case _SendTransaction():
return sendTransaction(_that.maxMessages);case _SignData():
return signData(_that.types);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int maxMessages)?  sendTransaction,TResult? Function( List<String> types)?  signData,}) {final _that = this;
switch (_that) {
case _SendTransaction() when sendTransaction != null:
return sendTransaction(_that.maxMessages);case _SignData() when signData != null:
return signData(_that.types);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendTransaction implements Feature {
  const _SendTransaction({required this.maxMessages, final  String? $type}): $type = $type ?? 'SendTransaction';
  factory _SendTransaction.fromJson(Map<String, dynamic> json) => _$SendTransactionFromJson(json);

 final  int maxMessages;

@JsonKey(name: 'name')
final String $type;


/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTransactionCopyWith<_SendTransaction> get copyWith => __$SendTransactionCopyWithImpl<_SendTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTransaction&&(identical(other.maxMessages, maxMessages) || other.maxMessages == maxMessages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxMessages);

@override
String toString() {
  return 'Feature.sendTransaction(maxMessages: $maxMessages)';
}


}

/// @nodoc
abstract mixin class _$SendTransactionCopyWith<$Res> implements $FeatureCopyWith<$Res> {
  factory _$SendTransactionCopyWith(_SendTransaction value, $Res Function(_SendTransaction) _then) = __$SendTransactionCopyWithImpl;
@useResult
$Res call({
 int maxMessages
});




}
/// @nodoc
class __$SendTransactionCopyWithImpl<$Res>
    implements _$SendTransactionCopyWith<$Res> {
  __$SendTransactionCopyWithImpl(this._self, this._then);

  final _SendTransaction _self;
  final $Res Function(_SendTransaction) _then;

/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? maxMessages = null,}) {
  return _then(_SendTransaction(
maxMessages: null == maxMessages ? _self.maxMessages : maxMessages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _SignData implements Feature {
  const _SignData({required final  List<String> types, final  String? $type}): _types = types,$type = $type ?? 'SignData';
  factory _SignData.fromJson(Map<String, dynamic> json) => _$SignDataFromJson(json);

 final  List<String> _types;
 List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}


@JsonKey(name: 'name')
final String $type;


/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignDataCopyWith<_SignData> get copyWith => __$SignDataCopyWithImpl<_SignData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignData&&const DeepCollectionEquality().equals(other._types, _types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_types));

@override
String toString() {
  return 'Feature.signData(types: $types)';
}


}

/// @nodoc
abstract mixin class _$SignDataCopyWith<$Res> implements $FeatureCopyWith<$Res> {
  factory _$SignDataCopyWith(_SignData value, $Res Function(_SignData) _then) = __$SignDataCopyWithImpl;
@useResult
$Res call({
 List<String> types
});




}
/// @nodoc
class __$SignDataCopyWithImpl<$Res>
    implements _$SignDataCopyWith<$Res> {
  __$SignDataCopyWithImpl(this._self, this._then);

  final _SignData _self;
  final $Res Function(_SignData) _then;

/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? types = null,}) {
  return _then(_SignData(
types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
