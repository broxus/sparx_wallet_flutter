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
TransportNativeTokenTickerOption _$TransportNativeTokenTickerOptionFromJson(
    Map<String, dynamic> json) {
  switch (json['type']) {
    case 'byName':
      return TransportNativeTokenTickerOptionByName.fromJson(json);

    default:
      return TransportNativeTokenTickerOptionFromConnection.fromJson(json);
  }
}

/// @nodoc
mixin _$TransportNativeTokenTickerOption {
  /// Serializes this TransportNativeTokenTickerOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportNativeTokenTickerOption);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
@JsonSerializable()
class TransportNativeTokenTickerOptionFromConnection
    implements TransportNativeTokenTickerOption {
  const TransportNativeTokenTickerOptionFromConnection({final String? $type})
      : $type = $type ?? 'fromConnection';
  factory TransportNativeTokenTickerOptionFromConnection.fromJson(
          Map<String, dynamic> json) =>
      _$TransportNativeTokenTickerOptionFromConnectionFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$TransportNativeTokenTickerOptionFromConnectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportNativeTokenTickerOptionFromConnection);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportNativeTokenTickerOption.fromConnection()';
  }
}

/// @nodoc
@JsonSerializable()
class TransportNativeTokenTickerOptionByName
    implements TransportNativeTokenTickerOption {
  const TransportNativeTokenTickerOptionByName(this.name, {final String? $type})
      : $type = $type ?? 'byName';
  factory TransportNativeTokenTickerOptionByName.fromJson(
          Map<String, dynamic> json) =>
      _$TransportNativeTokenTickerOptionByNameFromJson(json);

  final String name;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of TransportNativeTokenTickerOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransportNativeTokenTickerOptionByNameCopyWith<
          TransportNativeTokenTickerOptionByName>
      get copyWith => _$TransportNativeTokenTickerOptionByNameCopyWithImpl<
          TransportNativeTokenTickerOptionByName>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransportNativeTokenTickerOptionByNameToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportNativeTokenTickerOptionByName &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
