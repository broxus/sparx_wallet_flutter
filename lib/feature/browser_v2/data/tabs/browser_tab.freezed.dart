// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BrowserTab _$BrowserTabFromJson(Map<String, dynamic> json) {
  return _BrowserTab.fromJson(json);
}

/// @nodoc
mixin _$BrowserTab {
  /// The id of the tab.
  String get id => throw _privateConstructorUsedError;

  /// Initial url of the tab.
  @uriJsonConverter
  Uri get url => throw _privateConstructorUsedError;

  /// Initial url of the tab.
  @uriJsonConverter
  set url(Uri value) => throw _privateConstructorUsedError;

  /// The title of the tab.
  String? get title => throw _privateConstructorUsedError;

  /// The title of the tab.
  set title(String? value) => throw _privateConstructorUsedError;

  /// The sorting position of the tab.
  double get sortingOrder => throw _privateConstructorUsedError;

  /// The sorting position of the tab.
  set sortingOrder(double value) => throw _privateConstructorUsedError;

  /// Serializes this BrowserTab to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserTabCopyWith<BrowserTab> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabCopyWith<$Res> {
  factory $BrowserTabCopyWith(
          BrowserTab value, $Res Function(BrowserTab) then) =
      _$BrowserTabCopyWithImpl<$Res, BrowserTab>;
  @useResult
  $Res call(
      {String id,
      @uriJsonConverter Uri url,
      String? title,
      double sortingOrder});
}

/// @nodoc
class _$BrowserTabCopyWithImpl<$Res, $Val extends BrowserTab>
    implements $BrowserTabCopyWith<$Res> {
  _$BrowserTabCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = freezed,
    Object? sortingOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserTabImplCopyWith<$Res>
    implements $BrowserTabCopyWith<$Res> {
  factory _$$BrowserTabImplCopyWith(
          _$BrowserTabImpl value, $Res Function(_$BrowserTabImpl) then) =
      __$$BrowserTabImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @uriJsonConverter Uri url,
      String? title,
      double sortingOrder});
}

/// @nodoc
class __$$BrowserTabImplCopyWithImpl<$Res>
    extends _$BrowserTabCopyWithImpl<$Res, _$BrowserTabImpl>
    implements _$$BrowserTabImplCopyWith<$Res> {
  __$$BrowserTabImplCopyWithImpl(
      _$BrowserTabImpl _value, $Res Function(_$BrowserTabImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = freezed,
    Object? sortingOrder = null,
  }) {
    return _then(_$BrowserTabImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowserTabImpl extends _BrowserTab {
  _$BrowserTabImpl(
      {required this.id,
      @uriJsonConverter required this.url,
      required this.title,
      required this.sortingOrder})
      : super._();

  factory _$BrowserTabImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowserTabImplFromJson(json);

  /// The id of the tab.
  @override
  final String id;

  /// Initial url of the tab.
  @override
  @uriJsonConverter
  Uri url;

  /// The title of the tab.
  @override
  String? title;

  /// The sorting position of the tab.
  @override
  double sortingOrder;

  @override
  String toString() {
    return 'BrowserTab(id: $id, url: $url, title: $title, sortingOrder: $sortingOrder)';
  }

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserTabImplCopyWith<_$BrowserTabImpl> get copyWith =>
      __$$BrowserTabImplCopyWithImpl<_$BrowserTabImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowserTabImplToJson(
      this,
    );
  }
}

abstract class _BrowserTab extends BrowserTab {
  factory _BrowserTab(
      {required final String id,
      @uriJsonConverter required Uri url,
      required String? title,
      required double sortingOrder}) = _$BrowserTabImpl;
  _BrowserTab._() : super._();

  factory _BrowserTab.fromJson(Map<String, dynamic> json) =
      _$BrowserTabImpl.fromJson;

  /// The id of the tab.
  @override
  String get id;

  /// Initial url of the tab.
  @override
  @uriJsonConverter
  Uri get url;

  /// Initial url of the tab.
  @uriJsonConverter
  set url(Uri value);

  /// The title of the tab.
  @override
  String? get title;

  /// The title of the tab.
  set title(String? value);

  /// The sorting position of the tab.
  @override
  double get sortingOrder;

  /// The sorting position of the tab.
  set sortingOrder(double value);

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserTabImplCopyWith<_$BrowserTabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
