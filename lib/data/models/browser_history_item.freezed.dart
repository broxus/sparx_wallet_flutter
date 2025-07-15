// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
BrowserHistoryItem _$BrowserHistoryItemFromJson(Map<String, dynamic> json) {
  return _BrowserHistoryItemDto.fromJson(json);
}

/// @nodoc
mixin _$BrowserHistoryItem {
  /// The id of the tab.
  String get id;
  String get title;
  @uriJsonConverter
  Uri get url;
  DateTime get visitTime;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowserHistoryItemCopyWith<BrowserHistoryItem> get copyWith =>
      _$BrowserHistoryItemCopyWithImpl<BrowserHistoryItem>(
          this as BrowserHistoryItem, _$identity);

  /// Serializes this BrowserHistoryItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrowserHistoryItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.visitTime, visitTime) ||
                other.visitTime == visitTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, visitTime);

  @override
  String toString() {
    return 'BrowserHistoryItem(id: $id, title: $title, url: $url, visitTime: $visitTime)';
  }
}

/// @nodoc
abstract mixin class $BrowserHistoryItemCopyWith<$Res> {
  factory $BrowserHistoryItemCopyWith(
          BrowserHistoryItem value, $Res Function(BrowserHistoryItem) _then) =
      _$BrowserHistoryItemCopyWithImpl;
  @useResult
  $Res call(
      {String id, String title, @uriJsonConverter Uri url, DateTime visitTime});
}

/// @nodoc
class _$BrowserHistoryItemCopyWithImpl<$Res>
    implements $BrowserHistoryItemCopyWith<$Res> {
  _$BrowserHistoryItemCopyWithImpl(this._self, this._then);

  final BrowserHistoryItem _self;
  final $Res Function(BrowserHistoryItem) _then;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? visitTime = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      visitTime: null == visitTime
          ? _self.visitTime
          : visitTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BrowserHistoryItemDto extends BrowserHistoryItem {
  const _BrowserHistoryItemDto(
      {required this.id,
      required this.title,
      @uriJsonConverter required this.url,
      required this.visitTime})
      : super._();
  factory _BrowserHistoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$BrowserHistoryItemDtoFromJson(json);

  /// The id of the tab.
  @override
  final String id;
  @override
  final String title;
  @override
  @uriJsonConverter
  final Uri url;
  @override
  final DateTime visitTime;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowserHistoryItemDtoCopyWith<_BrowserHistoryItemDto> get copyWith =>
      __$BrowserHistoryItemDtoCopyWithImpl<_BrowserHistoryItemDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowserHistoryItemDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrowserHistoryItemDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.visitTime, visitTime) ||
                other.visitTime == visitTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, visitTime);

  @override
  String toString() {
    return 'BrowserHistoryItem(id: $id, title: $title, url: $url, visitTime: $visitTime)';
  }
}

/// @nodoc
abstract mixin class _$BrowserHistoryItemDtoCopyWith<$Res>
    implements $BrowserHistoryItemCopyWith<$Res> {
  factory _$BrowserHistoryItemDtoCopyWith(_BrowserHistoryItemDto value,
          $Res Function(_BrowserHistoryItemDto) _then) =
      __$BrowserHistoryItemDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String title, @uriJsonConverter Uri url, DateTime visitTime});
}

/// @nodoc
class __$BrowserHistoryItemDtoCopyWithImpl<$Res>
    implements _$BrowserHistoryItemDtoCopyWith<$Res> {
  __$BrowserHistoryItemDtoCopyWithImpl(this._self, this._then);

  final _BrowserHistoryItemDto _self;
  final $Res Function(_BrowserHistoryItemDto) _then;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? visitTime = null,
  }) {
    return _then(_BrowserHistoryItemDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      visitTime: null == visitTime
          ? _self.visitTime
          : visitTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
