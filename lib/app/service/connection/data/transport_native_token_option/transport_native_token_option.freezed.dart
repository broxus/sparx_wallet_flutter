// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_native_token_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransportNativeTokenTickerOption {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportNativeTokenTickerOption);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportNativeTokenTickerOption()';
  }
}

/// @nodoc
class $TransportNativeTokenTickerOptionCopyWith<$Res> {
  $TransportNativeTokenTickerOptionCopyWith(TransportNativeTokenTickerOption _,
      $Res Function(TransportNativeTokenTickerOption) __);
}

/// @nodoc

class TransportNativeTokenTickerOptionFromConnection
    implements TransportNativeTokenTickerOption {
  const TransportNativeTokenTickerOptionFromConnection();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportNativeTokenTickerOptionFromConnection);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportNativeTokenTickerOption.fromConnection()';
  }
}

/// @nodoc

class TransportNativeTokenTickerOptionByName
    implements TransportNativeTokenTickerOption {
  const TransportNativeTokenTickerOptionByName(this.name);

  final String name;

  /// Create a copy of TransportNativeTokenTickerOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransportNativeTokenTickerOptionByNameCopyWith<
          TransportNativeTokenTickerOptionByName>
      get copyWith => _$TransportNativeTokenTickerOptionByNameCopyWithImpl<
          TransportNativeTokenTickerOptionByName>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportNativeTokenTickerOptionByName &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'TransportNativeTokenTickerOption.byName(name: $name)';
  }
}

/// @nodoc
abstract mixin class $TransportNativeTokenTickerOptionByNameCopyWith<$Res>
    implements $TransportNativeTokenTickerOptionCopyWith<$Res> {
  factory $TransportNativeTokenTickerOptionByNameCopyWith(
          TransportNativeTokenTickerOptionByName value,
          $Res Function(TransportNativeTokenTickerOptionByName) _then) =
      _$TransportNativeTokenTickerOptionByNameCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$TransportNativeTokenTickerOptionByNameCopyWithImpl<$Res>
    implements $TransportNativeTokenTickerOptionByNameCopyWith<$Res> {
  _$TransportNativeTokenTickerOptionByNameCopyWithImpl(this._self, this._then);

  final TransportNativeTokenTickerOptionByName _self;
  final $Res Function(TransportNativeTokenTickerOptionByName) _then;

  /// Create a copy of TransportNativeTokenTickerOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(TransportNativeTokenTickerOptionByName(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
