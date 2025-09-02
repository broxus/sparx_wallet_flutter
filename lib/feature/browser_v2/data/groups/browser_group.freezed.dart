// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowserGroup {
  String get id;
  set id(String value);
  String? get title;
  set title(String? value);
  double get sortingOrder;
  set sortingOrder(double value);
  List<String> get tabsIds;
  set tabsIds(List<String> value);
  bool get isEditable;
  set isEditable(bool value);

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowserGroupCopyWith<BrowserGroup> get copyWith =>
      _$BrowserGroupCopyWithImpl<BrowserGroup>(
          this as BrowserGroup, _$identity);

  /// Serializes this BrowserGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'BrowserGroup(id: $id, title: $title, sortingOrder: $sortingOrder, tabsIds: $tabsIds, isEditable: $isEditable)';
  }
}

/// @nodoc
abstract mixin class $BrowserGroupCopyWith<$Res> {
  factory $BrowserGroupCopyWith(
          BrowserGroup value, $Res Function(BrowserGroup) _then) =
      _$BrowserGroupCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String? title,
      double sortingOrder,
      List<String> tabsIds,
      bool isEditable});
}

/// @nodoc
class _$BrowserGroupCopyWithImpl<$Res> implements $BrowserGroupCopyWith<$Res> {
  _$BrowserGroupCopyWithImpl(this._self, this._then);

  final BrowserGroup _self;
  final $Res Function(BrowserGroup) _then;

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? sortingOrder = null,
    Object? tabsIds = null,
    Object? isEditable = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      tabsIds: null == tabsIds
          ? _self.tabsIds
          : tabsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEditable: null == isEditable
          ? _self.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrowserGroup].
extension BrowserGroupPatterns on BrowserGroup {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BrowserGroup value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserGroup() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BrowserGroup value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserGroup():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BrowserGroup value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserGroup() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String? title, double sortingOrder,
            List<String> tabsIds, bool isEditable)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserGroup() when $default != null:
        return $default(_that.id, _that.title, _that.sortingOrder,
            _that.tabsIds, _that.isEditable);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String? title, double sortingOrder,
            List<String> tabsIds, bool isEditable)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserGroup():
        return $default(_that.id, _that.title, _that.sortingOrder,
            _that.tabsIds, _that.isEditable);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String? title, double sortingOrder,
            List<String> tabsIds, bool isEditable)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserGroup() when $default != null:
        return $default(_that.id, _that.title, _that.sortingOrder,
            _that.tabsIds, _that.isEditable);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrowserGroup extends BrowserGroup {
  _BrowserGroup(
      {required this.id,
      required this.title,
      required this.sortingOrder,
      this.tabsIds = const <String>[],
      this.isEditable = true})
      : super._();
  factory _BrowserGroup.fromJson(Map<String, dynamic> json) =>
      _$BrowserGroupFromJson(json);

  @override
  String id;
  @override
  String? title;
  @override
  double sortingOrder;
  @override
  @JsonKey()
  List<String> tabsIds;
  @override
  @JsonKey()
  bool isEditable;

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowserGroupCopyWith<_BrowserGroup> get copyWith =>
      __$BrowserGroupCopyWithImpl<_BrowserGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowserGroupToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'BrowserGroup(id: $id, title: $title, sortingOrder: $sortingOrder, tabsIds: $tabsIds, isEditable: $isEditable)';
  }
}

/// @nodoc
abstract mixin class _$BrowserGroupCopyWith<$Res>
    implements $BrowserGroupCopyWith<$Res> {
  factory _$BrowserGroupCopyWith(
          _BrowserGroup value, $Res Function(_BrowserGroup) _then) =
      __$BrowserGroupCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      double sortingOrder,
      List<String> tabsIds,
      bool isEditable});
}

/// @nodoc
class __$BrowserGroupCopyWithImpl<$Res>
    implements _$BrowserGroupCopyWith<$Res> {
  __$BrowserGroupCopyWithImpl(this._self, this._then);

  final _BrowserGroup _self;
  final $Res Function(_BrowserGroup) _then;

  /// Create a copy of BrowserGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? sortingOrder = null,
    Object? tabsIds = null,
    Object? isEditable = null,
  }) {
    return _then(_BrowserGroup(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      tabsIds: null == tabsIds
          ? _self.tabsIds
          : tabsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEditable: null == isEditable
          ? _self.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
