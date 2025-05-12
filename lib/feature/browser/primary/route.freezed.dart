// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserPrimaryRouteData {
  /// URL to navigate to
  String? get url => throw _privateConstructorUsedError;

  /// ID of tab to open
  String? get tabId => throw _privateConstructorUsedError;

  /// Create a copy of BrowserPrimaryRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserPrimaryRouteDataCopyWith<BrowserPrimaryRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserPrimaryRouteDataCopyWith<$Res> {
  factory $BrowserPrimaryRouteDataCopyWith(BrowserPrimaryRouteData value,
          $Res Function(BrowserPrimaryRouteData) then) =
      _$BrowserPrimaryRouteDataCopyWithImpl<$Res, BrowserPrimaryRouteData>;
  @useResult
  $Res call({String? url, String? tabId});
}

/// @nodoc
class _$BrowserPrimaryRouteDataCopyWithImpl<$Res,
        $Val extends BrowserPrimaryRouteData>
    implements $BrowserPrimaryRouteDataCopyWith<$Res> {
  _$BrowserPrimaryRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserPrimaryRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? tabId = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      tabId: freezed == tabId
          ? _value.tabId
          : tabId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserPrimaryRouteDataImplCopyWith<$Res>
    implements $BrowserPrimaryRouteDataCopyWith<$Res> {
  factory _$$BrowserPrimaryRouteDataImplCopyWith(
          _$BrowserPrimaryRouteDataImpl value,
          $Res Function(_$BrowserPrimaryRouteDataImpl) then) =
      __$$BrowserPrimaryRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, String? tabId});
}

/// @nodoc
class __$$BrowserPrimaryRouteDataImplCopyWithImpl<$Res>
    extends _$BrowserPrimaryRouteDataCopyWithImpl<$Res,
        _$BrowserPrimaryRouteDataImpl>
    implements _$$BrowserPrimaryRouteDataImplCopyWith<$Res> {
  __$$BrowserPrimaryRouteDataImplCopyWithImpl(
      _$BrowserPrimaryRouteDataImpl _value,
      $Res Function(_$BrowserPrimaryRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserPrimaryRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? tabId = freezed,
  }) {
    return _then(_$BrowserPrimaryRouteDataImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      tabId: freezed == tabId
          ? _value.tabId
          : tabId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BrowserPrimaryRouteDataImpl extends _BrowserPrimaryRouteData {
  const _$BrowserPrimaryRouteDataImpl({this.url, this.tabId}) : super._();

  /// URL to navigate to
  @override
  final String? url;

  /// ID of tab to open
  @override
  final String? tabId;

  @override
  String toString() {
    return 'BrowserPrimaryRouteData(url: $url, tabId: $tabId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserPrimaryRouteDataImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.tabId, tabId) || other.tabId == tabId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, tabId);

  /// Create a copy of BrowserPrimaryRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserPrimaryRouteDataImplCopyWith<_$BrowserPrimaryRouteDataImpl>
      get copyWith => __$$BrowserPrimaryRouteDataImplCopyWithImpl<
          _$BrowserPrimaryRouteDataImpl>(this, _$identity);
}

abstract class _BrowserPrimaryRouteData extends BrowserPrimaryRouteData {
  const factory _BrowserPrimaryRouteData(
      {final String? url, final String? tabId}) = _$BrowserPrimaryRouteDataImpl;
  const _BrowserPrimaryRouteData._() : super._();

  /// URL to navigate to
  @override
  String? get url;

  /// ID of tab to open
  @override
  String? get tabId;

  /// Create a copy of BrowserPrimaryRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserPrimaryRouteDataImplCopyWith<_$BrowserPrimaryRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
