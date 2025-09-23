// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_manifest_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
TransportManifestOption _$TransportManifestOptionFromJson(
    Map<String, dynamic> json) {
  return TransportManifestOptionFromConnection.fromJson(json);
}

/// @nodoc
mixin _$TransportManifestOption {
  /// Serializes this TransportManifestOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TransportManifestOption);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportManifestOption()';
  }
}

/// @nodoc
class $TransportManifestOptionCopyWith<$Res> {
  $TransportManifestOptionCopyWith(
      TransportManifestOption _, $Res Function(TransportManifestOption) __);
}

/// @nodoc
@JsonSerializable()
class TransportManifestOptionFromConnection implements TransportManifestOption {
  const TransportManifestOptionFromConnection();
  factory TransportManifestOptionFromConnection.fromJson(
          Map<String, dynamic> json) =>
      _$TransportManifestOptionFromConnectionFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$TransportManifestOptionFromConnectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportManifestOptionFromConnection);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TransportManifestOption.fromConnection()';
  }
}

// dart format on
