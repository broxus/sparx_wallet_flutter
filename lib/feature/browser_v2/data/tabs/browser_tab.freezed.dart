// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowserTab {
  /// The id of the tab.
  String get id;

  /// Initial url of the tab.
  Uri get url;

  /// Initial url of the tab.
  set url(Uri value);

  /// The title of the tab.
  String? get title;

  /// The title of the tab.
  set title(String? value);

  /// The sorting position of the tab.
  double get sortingOrder;

  /// The sorting position of the tab.
  set sortingOrder(double value);

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowserTabCopyWith<BrowserTab> get copyWith =>
      _$BrowserTabCopyWithImpl<BrowserTab>(this as BrowserTab, _$identity);

  /// Serializes this BrowserTab to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'BrowserTab(id: $id, url: $url, title: $title, sortingOrder: $sortingOrder)';
  }
}

/// @nodoc
abstract mixin class $BrowserTabCopyWith<$Res> {
  factory $BrowserTabCopyWith(
          BrowserTab value, $Res Function(BrowserTab) _then) =
      _$BrowserTabCopyWithImpl;
  @useResult
  $Res call({String id, Uri url, String? title, double sortingOrder});
}

/// @nodoc
class _$BrowserTabCopyWithImpl<$Res> implements $BrowserTabCopyWith<$Res> {
  _$BrowserTabCopyWithImpl(this._self, this._then);

  final BrowserTab _self;
  final $Res Function(BrowserTab) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrowserTab].
extension BrowserTabPatterns on BrowserTab {
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
    TResult Function(_BrowserTab value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserTab() when $default != null:
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
    TResult Function(_BrowserTab value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTab():
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
    TResult? Function(_BrowserTab value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTab() when $default != null:
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
    TResult Function(String id, @uriJsonConverter Uri url, String? title,
            double sortingOrder)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserTab() when $default != null:
        return $default(_that.id, _that.url, _that.title, _that.sortingOrder);
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
    TResult Function(String id, @uriJsonConverter Uri url, String? title,
            double sortingOrder)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTab():
        return $default(_that.id, _that.url, _that.title, _that.sortingOrder);
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
    TResult? Function(String id, @uriJsonConverter Uri url, String? title,
            double sortingOrder)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTab() when $default != null:
        return $default(_that.id, _that.url, _that.title, _that.sortingOrder);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrowserTab extends BrowserTab {
  _BrowserTab(
      {required this.id,
      required this.url,
      required this.title,
      required this.sortingOrder})
      : super._();
  factory _BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);

  /// The id of the tab.
  @override
  final String id;

  /// Initial url of the tab.
  @override
  Uri url;

  /// The title of the tab.
  @override
  String? title;

  /// The sorting position of the tab.
  @override
  double sortingOrder;

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowserTabCopyWith<_BrowserTab> get copyWith =>
      __$BrowserTabCopyWithImpl<_BrowserTab>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowserTabToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'BrowserTab(id: $id, url: $url, title: $title, sortingOrder: $sortingOrder)';
  }
}

/// @nodoc
abstract mixin class _$BrowserTabCopyWith<$Res>
    implements $BrowserTabCopyWith<$Res> {
  factory _$BrowserTabCopyWith(
          _BrowserTab value, $Res Function(_BrowserTab) _then) =
      __$BrowserTabCopyWithImpl;
  @override
  @useResult
  $Res call({String id, Uri url, String? title, double sortingOrder});
}

/// @nodoc
class __$BrowserTabCopyWithImpl<$Res> implements _$BrowserTabCopyWith<$Res> {
  __$BrowserTabCopyWithImpl(this._self, this._then);

  final _BrowserTab _self;
  final $Res Function(_BrowserTab) _then;

  /// Create a copy of BrowserTab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = freezed,
    Object? sortingOrder = null,
  }) {
    return _then(_BrowserTab(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
