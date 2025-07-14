// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NftInformation _$NftInformationFromJson(Map<String, dynamic> json) {
  return _NftInformation.fromJson(json);
}

/// @nodoc
mixin _$NftInformation {
  String? get marketplaceUrl => throw _privateConstructorUsedError;
  List<Address>? get defaultCollections => throw _privateConstructorUsedError;

  /// Serializes this NftInformation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NftInformationCopyWith<NftInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftInformationCopyWith<$Res> {
  factory $NftInformationCopyWith(
          NftInformation value, $Res Function(NftInformation) then) =
      _$NftInformationCopyWithImpl<$Res, NftInformation>;
  @useResult
  $Res call({String? marketplaceUrl, List<Address>? defaultCollections});
}

/// @nodoc
class _$NftInformationCopyWithImpl<$Res, $Val extends NftInformation>
    implements $NftInformationCopyWith<$Res> {
  _$NftInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketplaceUrl = freezed,
    Object? defaultCollections = freezed,
  }) {
    return _then(_value.copyWith(
      marketplaceUrl: freezed == marketplaceUrl
          ? _value.marketplaceUrl
          : marketplaceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultCollections: freezed == defaultCollections
          ? _value.defaultCollections
          : defaultCollections // ignore: cast_nullable_to_non_nullable
              as List<Address>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NftInformationImplCopyWith<$Res>
    implements $NftInformationCopyWith<$Res> {
  factory _$$NftInformationImplCopyWith(_$NftInformationImpl value,
          $Res Function(_$NftInformationImpl) then) =
      __$$NftInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? marketplaceUrl, List<Address>? defaultCollections});
}

/// @nodoc
class __$$NftInformationImplCopyWithImpl<$Res>
    extends _$NftInformationCopyWithImpl<$Res, _$NftInformationImpl>
    implements _$$NftInformationImplCopyWith<$Res> {
  __$$NftInformationImplCopyWithImpl(
      _$NftInformationImpl _value, $Res Function(_$NftInformationImpl) _then)
      : super(_value, _then);

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketplaceUrl = freezed,
    Object? defaultCollections = freezed,
  }) {
    return _then(_$NftInformationImpl(
      marketplaceUrl: freezed == marketplaceUrl
          ? _value.marketplaceUrl
          : marketplaceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultCollections: freezed == defaultCollections
          ? _value._defaultCollections
          : defaultCollections // ignore: cast_nullable_to_non_nullable
              as List<Address>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NftInformationImpl implements _NftInformation {
  _$NftInformationImpl(
      {this.marketplaceUrl, final List<Address>? defaultCollections})
      : _defaultCollections = defaultCollections;

  factory _$NftInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NftInformationImplFromJson(json);

  @override
  final String? marketplaceUrl;
  final List<Address>? _defaultCollections;
  @override
  List<Address>? get defaultCollections {
    final value = _defaultCollections;
    if (value == null) return null;
    if (_defaultCollections is EqualUnmodifiableListView)
      return _defaultCollections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NftInformation(marketplaceUrl: $marketplaceUrl, defaultCollections: $defaultCollections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftInformationImpl &&
            (identical(other.marketplaceUrl, marketplaceUrl) ||
                other.marketplaceUrl == marketplaceUrl) &&
            const DeepCollectionEquality()
                .equals(other._defaultCollections, _defaultCollections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, marketplaceUrl,
      const DeepCollectionEquality().hash(_defaultCollections));

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NftInformationImplCopyWith<_$NftInformationImpl> get copyWith =>
      __$$NftInformationImplCopyWithImpl<_$NftInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NftInformationImplToJson(
      this,
    );
  }
}

abstract class _NftInformation implements NftInformation {
  factory _NftInformation(
      {final String? marketplaceUrl,
      final List<Address>? defaultCollections}) = _$NftInformationImpl;

  factory _NftInformation.fromJson(Map<String, dynamic> json) =
      _$NftInformationImpl.fromJson;

  @override
  String? get marketplaceUrl;
  @override
  List<Address>? get defaultCollections;

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NftInformationImplCopyWith<_$NftInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
