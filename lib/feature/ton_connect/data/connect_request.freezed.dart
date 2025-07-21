// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectRequest {
  String get manifestUrl;
  List<ConnectItem> get items;

  /// Create a copy of ConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectRequestCopyWith<ConnectRequest> get copyWith =>
      _$ConnectRequestCopyWithImpl<ConnectRequest>(
          this as ConnectRequest, _$identity);

  /// Serializes this ConnectRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectRequest &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, manifestUrl, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'ConnectRequest(manifestUrl: $manifestUrl, items: $items)';
  }
}

/// @nodoc
abstract mixin class $ConnectRequestCopyWith<$Res> {
  factory $ConnectRequestCopyWith(
          ConnectRequest value, $Res Function(ConnectRequest) _then) =
      _$ConnectRequestCopyWithImpl;
  @useResult
  $Res call({String manifestUrl, List<ConnectItem> items});
}

/// @nodoc
class _$ConnectRequestCopyWithImpl<$Res>
    implements $ConnectRequestCopyWith<$Res> {
  _$ConnectRequestCopyWithImpl(this._self, this._then);

  final ConnectRequest _self;
  final $Res Function(ConnectRequest) _then;

  /// Create a copy of ConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manifestUrl = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConnectItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectRequest implements ConnectRequest {
  _ConnectRequest(
      {required this.manifestUrl, required final List<ConnectItem> items})
      : _items = items;
  factory _ConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectRequestFromJson(json);

  @override
  final String manifestUrl;
  final List<ConnectItem> _items;
  @override
  List<ConnectItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of ConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectRequestCopyWith<_ConnectRequest> get copyWith =>
      __$ConnectRequestCopyWithImpl<_ConnectRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectRequest &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, manifestUrl, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'ConnectRequest(manifestUrl: $manifestUrl, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$ConnectRequestCopyWith<$Res>
    implements $ConnectRequestCopyWith<$Res> {
  factory _$ConnectRequestCopyWith(
          _ConnectRequest value, $Res Function(_ConnectRequest) _then) =
      __$ConnectRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String manifestUrl, List<ConnectItem> items});
}

/// @nodoc
class __$ConnectRequestCopyWithImpl<$Res>
    implements _$ConnectRequestCopyWith<$Res> {
  __$ConnectRequestCopyWithImpl(this._self, this._then);

  final _ConnectRequest _self;
  final $Res Function(_ConnectRequest) _then;

  /// Create a copy of ConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? manifestUrl = null,
    Object? items = null,
  }) {
    return _then(_ConnectRequest(
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConnectItem>,
    ));
  }
}

// dart format on
