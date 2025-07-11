// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_meta_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SiteMetaData {
  String get url;
  String? get title;
  String? get image;
  String? get description;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SiteMetaDataCopyWith<SiteMetaData> get copyWith =>
      _$SiteMetaDataCopyWithImpl<SiteMetaData>(
          this as SiteMetaData, _$identity);

  /// Serializes this SiteMetaData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SiteMetaData &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, title, image, description);

  @override
  String toString() {
    return 'SiteMetaData(url: $url, title: $title, image: $image, description: $description)';
  }
}

/// @nodoc
abstract mixin class $SiteMetaDataCopyWith<$Res> {
  factory $SiteMetaDataCopyWith(
          SiteMetaData value, $Res Function(SiteMetaData) _then) =
      _$SiteMetaDataCopyWithImpl;
  @useResult
  $Res call({String url, String? title, String? image, String? description});
}

/// @nodoc
class _$SiteMetaDataCopyWithImpl<$Res> implements $SiteMetaDataCopyWith<$Res> {
  _$SiteMetaDataCopyWithImpl(this._self, this._then);

  final SiteMetaData _self;
  final $Res Function(SiteMetaData) _then;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SiteMetaData implements SiteMetaData {
  const _SiteMetaData(
      {required this.url, this.title, this.image, this.description});
  factory _SiteMetaData.fromJson(Map<String, dynamic> json) =>
      _$SiteMetaDataFromJson(json);

  @override
  final String url;
  @override
  final String? title;
  @override
  final String? image;
  @override
  final String? description;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SiteMetaDataCopyWith<_SiteMetaData> get copyWith =>
      __$SiteMetaDataCopyWithImpl<_SiteMetaData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SiteMetaDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SiteMetaData &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, title, image, description);

  @override
  String toString() {
    return 'SiteMetaData(url: $url, title: $title, image: $image, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$SiteMetaDataCopyWith<$Res>
    implements $SiteMetaDataCopyWith<$Res> {
  factory _$SiteMetaDataCopyWith(
          _SiteMetaData value, $Res Function(_SiteMetaData) _then) =
      __$SiteMetaDataCopyWithImpl;
  @override
  @useResult
  $Res call({String url, String? title, String? image, String? description});
}

/// @nodoc
class __$SiteMetaDataCopyWithImpl<$Res>
    implements _$SiteMetaDataCopyWith<$Res> {
  __$SiteMetaDataCopyWithImpl(this._self, this._then);

  final _SiteMetaData _self;
  final $Res Function(_SiteMetaData) _then;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_SiteMetaData(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
