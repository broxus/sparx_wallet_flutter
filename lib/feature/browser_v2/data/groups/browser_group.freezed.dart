// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BrowserGroup _$BrowserGroupFromJson(Map<String, dynamic> json) {
  return _BrowserGroup.fromJson(json);
}

/// @nodoc
mixin _$BrowserGroup {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<String> get tabsIds => throw _privateConstructorUsedError;
  double get sortingOrder => throw _privateConstructorUsedError;
  bool get isCanRemoved => throw _privateConstructorUsedError;
  bool get isCanEditTitle => throw _privateConstructorUsedError;

  /// Serializes this BrowserGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserGroupCopyWith<BrowserGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserGroupCopyWith<$Res> {
  factory $BrowserGroupCopyWith(
          BrowserGroup value, $Res Function(BrowserGroup) then) =
      _$BrowserGroupCopyWithImpl<$Res, BrowserGroup>;
  @useResult
  $Res call(
      {String id,
      String? title,
      List<String> tabsIds,
      double sortingOrder,
      bool isCanRemoved,
      bool isCanEditTitle});
}

/// @nodoc
class _$BrowserGroupCopyWithImpl<$Res, $Val extends BrowserGroup>
    implements $BrowserGroupCopyWith<$Res> {
  _$BrowserGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? tabsIds = null,
    Object? sortingOrder = null,
    Object? isCanRemoved = null,
    Object? isCanEditTitle = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      tabsIds: null == tabsIds
          ? _value.tabsIds
          : tabsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isCanRemoved: null == isCanRemoved
          ? _value.isCanRemoved
          : isCanRemoved // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanEditTitle: null == isCanEditTitle
          ? _value.isCanEditTitle
          : isCanEditTitle // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserGroupImplCopyWith<$Res>
    implements $BrowserGroupCopyWith<$Res> {
  factory _$$BrowserGroupImplCopyWith(
          _$BrowserGroupImpl value, $Res Function(_$BrowserGroupImpl) then) =
      __$$BrowserGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      List<String> tabsIds,
      double sortingOrder,
      bool isCanRemoved,
      bool isCanEditTitle});
}

/// @nodoc
class __$$BrowserGroupImplCopyWithImpl<$Res>
    extends _$BrowserGroupCopyWithImpl<$Res, _$BrowserGroupImpl>
    implements _$$BrowserGroupImplCopyWith<$Res> {
  __$$BrowserGroupImplCopyWithImpl(
      _$BrowserGroupImpl _value, $Res Function(_$BrowserGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? tabsIds = null,
    Object? sortingOrder = null,
    Object? isCanRemoved = null,
    Object? isCanEditTitle = null,
  }) {
    return _then(_$BrowserGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      tabsIds: null == tabsIds
          ? _value._tabsIds
          : tabsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isCanRemoved: null == isCanRemoved
          ? _value.isCanRemoved
          : isCanRemoved // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanEditTitle: null == isCanEditTitle
          ? _value.isCanEditTitle
          : isCanEditTitle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowserGroupImpl implements _BrowserGroup {
  const _$BrowserGroupImpl(
      {required this.id,
      required this.title,
      final List<String> tabsIds = const [],
      required this.sortingOrder,
      this.isCanRemoved = false,
      this.isCanEditTitle = false})
      : _tabsIds = tabsIds;

  factory _$BrowserGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowserGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  final List<String> _tabsIds;
  @override
  @JsonKey()
  List<String> get tabsIds {
    if (_tabsIds is EqualUnmodifiableListView) return _tabsIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabsIds);
  }

  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isCanRemoved;
  @override
  @JsonKey()
  final bool isCanEditTitle;

  @override
  String toString() {
    return 'BrowserGroup(id: $id, title: $title, tabsIds: $tabsIds, sortingOrder: $sortingOrder, isCanRemoved: $isCanRemoved, isCanEditTitle: $isCanEditTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._tabsIds, _tabsIds) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isCanRemoved, isCanRemoved) ||
                other.isCanRemoved == isCanRemoved) &&
            (identical(other.isCanEditTitle, isCanEditTitle) ||
                other.isCanEditTitle == isCanEditTitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_tabsIds),
      sortingOrder,
      isCanRemoved,
      isCanEditTitle);

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserGroupImplCopyWith<_$BrowserGroupImpl> get copyWith =>
      __$$BrowserGroupImplCopyWithImpl<_$BrowserGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowserGroupImplToJson(
      this,
    );
  }
}

abstract class _BrowserGroup implements BrowserGroup {
  const factory _BrowserGroup(
      {required final String id,
      required final String? title,
      final List<String> tabsIds,
      required final double sortingOrder,
      final bool isCanRemoved,
      final bool isCanEditTitle}) = _$BrowserGroupImpl;

  factory _BrowserGroup.fromJson(Map<String, dynamic> json) =
      _$BrowserGroupImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  List<String> get tabsIds;
  @override
  double get sortingOrder;
  @override
  bool get isCanRemoved;
  @override
  bool get isCanEditTitle;

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserGroupImplCopyWith<_$BrowserGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
