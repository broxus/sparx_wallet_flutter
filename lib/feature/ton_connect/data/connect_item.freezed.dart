// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ConnectItem _$ConnectItemFromJson(Map<String, dynamic> json) {
  switch (json['name']) {
    case 'ton_addr':
      return TonAddressItem.fromJson(json);
    case 'ton_proof':
      return TonProofItem.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'name', 'ConnectItem', 'Invalid union type "${json['name']}"!');
  }
}

/// @nodoc
mixin _$ConnectItem {
  /// Serializes this ConnectItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConnectItem);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConnectItem()';
  }
}

/// @nodoc
class $ConnectItemCopyWith<$Res> {
  $ConnectItemCopyWith(ConnectItem _, $Res Function(ConnectItem) __);
}

/// Adds pattern-matching-related methods to [ConnectItem].
extension ConnectItemPatterns on ConnectItem {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItem value)? tonAddress,
    TResult Function(TonProofItem value)? tonProof,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TonAddressItem() when tonAddress != null:
        return tonAddress(_that);
      case TonProofItem() when tonProof != null:
        return tonProof(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItem value) tonAddress,
    required TResult Function(TonProofItem value) tonProof,
  }) {
    final _that = this;
    switch (_that) {
      case TonAddressItem():
        return tonAddress(_that);
      case TonProofItem():
        return tonProof(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItem value)? tonAddress,
    TResult? Function(TonProofItem value)? tonProof,
  }) {
    final _that = this;
    switch (_that) {
      case TonAddressItem() when tonAddress != null:
        return tonAddress(_that);
      case TonProofItem() when tonProof != null:
        return tonProof(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? tonAddress,
    TResult Function(String payload)? tonProof,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TonAddressItem() when tonAddress != null:
        return tonAddress();
      case TonProofItem() when tonProof != null:
        return tonProof(_that.payload);
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
  TResult when<TResult extends Object?>({
    required TResult Function() tonAddress,
    required TResult Function(String payload) tonProof,
  }) {
    final _that = this;
    switch (_that) {
      case TonAddressItem():
        return tonAddress();
      case TonProofItem():
        return tonProof(_that.payload);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? tonAddress,
    TResult? Function(String payload)? tonProof,
  }) {
    final _that = this;
    switch (_that) {
      case TonAddressItem() when tonAddress != null:
        return tonAddress();
      case TonProofItem() when tonProof != null:
        return tonProof(_that.payload);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class TonAddressItem implements ConnectItem {
  const TonAddressItem({final String? $type}) : $type = $type ?? 'ton_addr';
  factory TonAddressItem.fromJson(Map<String, dynamic> json) =>
      _$TonAddressItemFromJson(json);

  @JsonKey(name: 'name')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$TonAddressItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TonAddressItem);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConnectItem.tonAddress()';
  }
}

/// @nodoc
@JsonSerializable()
class TonProofItem implements ConnectItem {
  const TonProofItem({required this.payload, final String? $type})
      : $type = $type ?? 'ton_proof';
  factory TonProofItem.fromJson(Map<String, dynamic> json) =>
      _$TonProofItemFromJson(json);

  final String payload;

  @JsonKey(name: 'name')
  final String $type;

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonProofItemCopyWith<TonProofItem> get copyWith =>
      _$TonProofItemCopyWithImpl<TonProofItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonProofItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonProofItem &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, payload);

  @override
  String toString() {
    return 'ConnectItem.tonProof(payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $TonProofItemCopyWith<$Res>
    implements $ConnectItemCopyWith<$Res> {
  factory $TonProofItemCopyWith(
          TonProofItem value, $Res Function(TonProofItem) _then) =
      _$TonProofItemCopyWithImpl;
  @useResult
  $Res call({String payload});
}

/// @nodoc
class _$TonProofItemCopyWithImpl<$Res> implements $TonProofItemCopyWith<$Res> {
  _$TonProofItemCopyWithImpl(this._self, this._then);

  final TonProofItem _self;
  final $Res Function(TonProofItem) _then;

  /// Create a copy of ConnectItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? payload = null,
  }) {
    return _then(TonProofItem(
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
