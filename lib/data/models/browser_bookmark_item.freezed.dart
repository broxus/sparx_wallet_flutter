// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_bookmark_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowserBookmarkItem {
  String get id;
  String get title;
  Uri get url;
  double get sortingOrder;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowserBookmarkItemCopyWith<BrowserBookmarkItem> get copyWith =>
      _$BrowserBookmarkItemCopyWithImpl<BrowserBookmarkItem>(
          this as BrowserBookmarkItem, _$identity);

  /// Serializes this BrowserBookmarkItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrowserBookmarkItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, sortingOrder);

  @override
  String toString() {
    return 'BrowserBookmarkItem(id: $id, title: $title, url: $url, sortingOrder: $sortingOrder)';
  }
}

/// @nodoc
abstract mixin class $BrowserBookmarkItemCopyWith<$Res> {
  factory $BrowserBookmarkItemCopyWith(
          BrowserBookmarkItem value, $Res Function(BrowserBookmarkItem) _then) =
      _$BrowserBookmarkItemCopyWithImpl;
  @useResult
  $Res call({String id, String title, Uri url, double sortingOrder});
}

/// @nodoc
class _$BrowserBookmarkItemCopyWithImpl<$Res>
    implements $BrowserBookmarkItemCopyWith<$Res> {
  _$BrowserBookmarkItemCopyWithImpl(this._self, this._then);

  final BrowserBookmarkItem _self;
  final $Res Function(BrowserBookmarkItem) _then;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? sortingOrder = null,
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
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrowserBookmarkItem].
extension BrowserBookmarkItemPatterns on BrowserBookmarkItem {
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
    TResult Function(_BrowserBookmarkItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserBookmarkItem() when $default != null:
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
    TResult Function(_BrowserBookmarkItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserBookmarkItem():
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
    TResult? Function(_BrowserBookmarkItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserBookmarkItem() when $default != null:
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
    TResult Function(String id, String title, @uriJsonConverter Uri url,
            double sortingOrder)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserBookmarkItem() when $default != null:
        return $default(_that.id, _that.title, _that.url, _that.sortingOrder);
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
    TResult Function(String id, String title, @uriJsonConverter Uri url,
            double sortingOrder)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserBookmarkItem():
        return $default(_that.id, _that.title, _that.url, _that.sortingOrder);
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
    TResult? Function(String id, String title, @uriJsonConverter Uri url,
            double sortingOrder)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserBookmarkItem() when $default != null:
        return $default(_that.id, _that.title, _that.url, _that.sortingOrder);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrowserBookmarkItem implements BrowserBookmarkItem {
  const _BrowserBookmarkItem(
      {required this.id,
      required this.title,
      required this.url,
      required this.sortingOrder});
  factory _BrowserBookmarkItem.fromJson(Map<String, dynamic> json) =>
      _$BrowserBookmarkItemFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final Uri url;
  @override
  final double sortingOrder;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowserBookmarkItemCopyWith<_BrowserBookmarkItem> get copyWith =>
      __$BrowserBookmarkItemCopyWithImpl<_BrowserBookmarkItem>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowserBookmarkItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrowserBookmarkItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, sortingOrder);

  @override
  String toString() {
    return 'BrowserBookmarkItem(id: $id, title: $title, url: $url, sortingOrder: $sortingOrder)';
  }
}

/// @nodoc
abstract mixin class _$BrowserBookmarkItemCopyWith<$Res>
    implements $BrowserBookmarkItemCopyWith<$Res> {
  factory _$BrowserBookmarkItemCopyWith(_BrowserBookmarkItem value,
          $Res Function(_BrowserBookmarkItem) _then) =
      __$BrowserBookmarkItemCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String title, Uri url, double sortingOrder});
}

/// @nodoc
class __$BrowserBookmarkItemCopyWithImpl<$Res>
    implements _$BrowserBookmarkItemCopyWith<$Res> {
  __$BrowserBookmarkItemCopyWithImpl(this._self, this._then);

  final _BrowserBookmarkItem _self;
  final $Res Function(_BrowserBookmarkItem) _then;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? sortingOrder = null,
  }) {
    return _then(_BrowserBookmarkItem(
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
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
