// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'native_token_ticker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NativeTokenTicker {
  String get name;

  /// Create a copy of NativeTokenTicker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NativeTokenTickerCopyWith<NativeTokenTicker> get copyWith =>
      _$NativeTokenTickerCopyWithImpl<NativeTokenTicker>(
          this as NativeTokenTicker, _$identity);

  /// Serializes this NativeTokenTicker to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NativeTokenTicker &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'NativeTokenTicker(name: $name)';
  }
}

/// @nodoc
abstract mixin class $NativeTokenTickerCopyWith<$Res> {
  factory $NativeTokenTickerCopyWith(
          NativeTokenTicker value, $Res Function(NativeTokenTicker) _then) =
      _$NativeTokenTickerCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$NativeTokenTickerCopyWithImpl<$Res>
    implements $NativeTokenTickerCopyWith<$Res> {
  _$NativeTokenTickerCopyWithImpl(this._self, this._then);

  final NativeTokenTicker _self;
  final $Res Function(NativeTokenTicker) _then;

  /// Create a copy of NativeTokenTicker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _NativeTokenTicker implements NativeTokenTicker {
  const _NativeTokenTicker({this.name = ''});
  factory _NativeTokenTicker.fromJson(Map<String, dynamic> json) =>
      _$NativeTokenTickerFromJson(json);

  @override
  @JsonKey()
  final String name;

  /// Create a copy of NativeTokenTicker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NativeTokenTickerCopyWith<_NativeTokenTicker> get copyWith =>
      __$NativeTokenTickerCopyWithImpl<_NativeTokenTicker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NativeTokenTickerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NativeTokenTicker &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'NativeTokenTicker(name: $name)';
  }
}

/// @nodoc
abstract mixin class _$NativeTokenTickerCopyWith<$Res>
    implements $NativeTokenTickerCopyWith<$Res> {
  factory _$NativeTokenTickerCopyWith(
          _NativeTokenTicker value, $Res Function(_NativeTokenTicker) _then) =
      __$NativeTokenTickerCopyWithImpl;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$NativeTokenTickerCopyWithImpl<$Res>
    implements _$NativeTokenTickerCopyWith<$Res> {
  __$NativeTokenTickerCopyWithImpl(this._self, this._then);

  final _NativeTokenTicker _self;
  final $Res Function(_NativeTokenTicker) _then;

  /// Create a copy of NativeTokenTicker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(_NativeTokenTicker(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
