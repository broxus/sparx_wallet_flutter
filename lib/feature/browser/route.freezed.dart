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
mixin _$BrowserRouteData {}

/// @nodoc
abstract class $BrowserRouteDataCopyWith<$Res> {
  factory $BrowserRouteDataCopyWith(
          BrowserRouteData value, $Res Function(BrowserRouteData) then) =
      _$BrowserRouteDataCopyWithImpl<$Res, BrowserRouteData>;
}

/// @nodoc
class _$BrowserRouteDataCopyWithImpl<$Res, $Val extends BrowserRouteData>
    implements $BrowserRouteDataCopyWith<$Res> {
  _$BrowserRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BrowserRouteDataImplCopyWith<$Res> {
  factory _$$BrowserRouteDataImplCopyWith(_$BrowserRouteDataImpl value,
          $Res Function(_$BrowserRouteDataImpl) then) =
      __$$BrowserRouteDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BrowserRouteDataImplCopyWithImpl<$Res>
    extends _$BrowserRouteDataCopyWithImpl<$Res, _$BrowserRouteDataImpl>
    implements _$$BrowserRouteDataImplCopyWith<$Res> {
  __$$BrowserRouteDataImplCopyWithImpl(_$BrowserRouteDataImpl _value,
      $Res Function(_$BrowserRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BrowserRouteDataImpl extends _BrowserRouteData {
  const _$BrowserRouteDataImpl() : super._();

  @override
  String toString() {
    return 'BrowserRouteData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BrowserRouteDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _BrowserRouteData extends BrowserRouteData {
  const factory _BrowserRouteData() = _$BrowserRouteDataImpl;
  const _BrowserRouteData._() : super._();
}

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

/// @nodoc
mixin _$BrowserHistoryRouteData {}

/// @nodoc
abstract class $BrowserHistoryRouteDataCopyWith<$Res> {
  factory $BrowserHistoryRouteDataCopyWith(BrowserHistoryRouteData value,
          $Res Function(BrowserHistoryRouteData) then) =
      _$BrowserHistoryRouteDataCopyWithImpl<$Res, BrowserHistoryRouteData>;
}

/// @nodoc
class _$BrowserHistoryRouteDataCopyWithImpl<$Res,
        $Val extends BrowserHistoryRouteData>
    implements $BrowserHistoryRouteDataCopyWith<$Res> {
  _$BrowserHistoryRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserHistoryRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BrowserHistoryRouteDataImplCopyWith<$Res> {
  factory _$$BrowserHistoryRouteDataImplCopyWith(
          _$BrowserHistoryRouteDataImpl value,
          $Res Function(_$BrowserHistoryRouteDataImpl) then) =
      __$$BrowserHistoryRouteDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BrowserHistoryRouteDataImplCopyWithImpl<$Res>
    extends _$BrowserHistoryRouteDataCopyWithImpl<$Res,
        _$BrowserHistoryRouteDataImpl>
    implements _$$BrowserHistoryRouteDataImplCopyWith<$Res> {
  __$$BrowserHistoryRouteDataImplCopyWithImpl(
      _$BrowserHistoryRouteDataImpl _value,
      $Res Function(_$BrowserHistoryRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserHistoryRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BrowserHistoryRouteDataImpl extends _BrowserHistoryRouteData {
  const _$BrowserHistoryRouteDataImpl() : super._();

  @override
  String toString() {
    return 'BrowserHistoryRouteData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserHistoryRouteDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _BrowserHistoryRouteData extends BrowserHistoryRouteData {
  const factory _BrowserHistoryRouteData() = _$BrowserHistoryRouteDataImpl;
  const _BrowserHistoryRouteData._() : super._();
}

/// @nodoc
mixin _$BrowserBookmarksRouteData {}

/// @nodoc
abstract class $BrowserBookmarksRouteDataCopyWith<$Res> {
  factory $BrowserBookmarksRouteDataCopyWith(BrowserBookmarksRouteData value,
          $Res Function(BrowserBookmarksRouteData) then) =
      _$BrowserBookmarksRouteDataCopyWithImpl<$Res, BrowserBookmarksRouteData>;
}

/// @nodoc
class _$BrowserBookmarksRouteDataCopyWithImpl<$Res,
        $Val extends BrowserBookmarksRouteData>
    implements $BrowserBookmarksRouteDataCopyWith<$Res> {
  _$BrowserBookmarksRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserBookmarksRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BrowserBookmarksRouteDataImplCopyWith<$Res> {
  factory _$$BrowserBookmarksRouteDataImplCopyWith(
          _$BrowserBookmarksRouteDataImpl value,
          $Res Function(_$BrowserBookmarksRouteDataImpl) then) =
      __$$BrowserBookmarksRouteDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BrowserBookmarksRouteDataImplCopyWithImpl<$Res>
    extends _$BrowserBookmarksRouteDataCopyWithImpl<$Res,
        _$BrowserBookmarksRouteDataImpl>
    implements _$$BrowserBookmarksRouteDataImplCopyWith<$Res> {
  __$$BrowserBookmarksRouteDataImplCopyWithImpl(
      _$BrowserBookmarksRouteDataImpl _value,
      $Res Function(_$BrowserBookmarksRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserBookmarksRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BrowserBookmarksRouteDataImpl extends _BrowserBookmarksRouteData {
  const _$BrowserBookmarksRouteDataImpl() : super._();

  @override
  String toString() {
    return 'BrowserBookmarksRouteData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserBookmarksRouteDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _BrowserBookmarksRouteData extends BrowserBookmarksRouteData {
  const factory _BrowserBookmarksRouteData() = _$BrowserBookmarksRouteDataImpl;
  const _BrowserBookmarksRouteData._() : super._();
}

/// @nodoc
mixin _$BrowserTabsRouteData {}

/// @nodoc
abstract class $BrowserTabsRouteDataCopyWith<$Res> {
  factory $BrowserTabsRouteDataCopyWith(BrowserTabsRouteData value,
          $Res Function(BrowserTabsRouteData) then) =
      _$BrowserTabsRouteDataCopyWithImpl<$Res, BrowserTabsRouteData>;
}

/// @nodoc
class _$BrowserTabsRouteDataCopyWithImpl<$Res,
        $Val extends BrowserTabsRouteData>
    implements $BrowserTabsRouteDataCopyWith<$Res> {
  _$BrowserTabsRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserTabsRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BrowserTabsRouteDataImplCopyWith<$Res> {
  factory _$$BrowserTabsRouteDataImplCopyWith(_$BrowserTabsRouteDataImpl value,
          $Res Function(_$BrowserTabsRouteDataImpl) then) =
      __$$BrowserTabsRouteDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BrowserTabsRouteDataImplCopyWithImpl<$Res>
    extends _$BrowserTabsRouteDataCopyWithImpl<$Res, _$BrowserTabsRouteDataImpl>
    implements _$$BrowserTabsRouteDataImplCopyWith<$Res> {
  __$$BrowserTabsRouteDataImplCopyWithImpl(_$BrowserTabsRouteDataImpl _value,
      $Res Function(_$BrowserTabsRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsRouteData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BrowserTabsRouteDataImpl extends _BrowserTabsRouteData {
  const _$BrowserTabsRouteDataImpl() : super._();

  @override
  String toString() {
    return 'BrowserTabsRouteData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserTabsRouteDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _BrowserTabsRouteData extends BrowserTabsRouteData {
  const factory _BrowserTabsRouteData() = _$BrowserTabsRouteDataImpl;
  const _BrowserTabsRouteData._() : super._();
}
