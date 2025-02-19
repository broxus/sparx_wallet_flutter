// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_event_success_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectEventSuccessPayload _$ConnectEventSuccessPayloadFromJson(
    Map<String, dynamic> json) {
  return _ConnectEventSuccessPayload.fromJson(json);
}

/// @nodoc
mixin _$ConnectEventSuccessPayload {
  List<ConnectItemReply> get items => throw _privateConstructorUsedError;
  DeviceInfo get device => throw _privateConstructorUsedError;

  /// Serializes this ConnectEventSuccessPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectEventSuccessPayloadCopyWith<ConnectEventSuccessPayload>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectEventSuccessPayloadCopyWith<$Res> {
  factory $ConnectEventSuccessPayloadCopyWith(ConnectEventSuccessPayload value,
          $Res Function(ConnectEventSuccessPayload) then) =
      _$ConnectEventSuccessPayloadCopyWithImpl<$Res,
          ConnectEventSuccessPayload>;
  @useResult
  $Res call({List<ConnectItemReply> items, DeviceInfo device});

  $DeviceInfoCopyWith<$Res> get device;
}

/// @nodoc
class _$ConnectEventSuccessPayloadCopyWithImpl<$Res,
        $Val extends ConnectEventSuccessPayload>
    implements $ConnectEventSuccessPayloadCopyWith<$Res> {
  _$ConnectEventSuccessPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? device = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      device: null == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
    ) as $Val);
  }

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<$Res> get device {
    return $DeviceInfoCopyWith<$Res>(_value.device, (value) {
      return _then(_value.copyWith(device: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConnectEventSuccessPayloadImplCopyWith<$Res>
    implements $ConnectEventSuccessPayloadCopyWith<$Res> {
  factory _$$ConnectEventSuccessPayloadImplCopyWith(
          _$ConnectEventSuccessPayloadImpl value,
          $Res Function(_$ConnectEventSuccessPayloadImpl) then) =
      __$$ConnectEventSuccessPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ConnectItemReply> items, DeviceInfo device});

  @override
  $DeviceInfoCopyWith<$Res> get device;
}

/// @nodoc
class __$$ConnectEventSuccessPayloadImplCopyWithImpl<$Res>
    extends _$ConnectEventSuccessPayloadCopyWithImpl<$Res,
        _$ConnectEventSuccessPayloadImpl>
    implements _$$ConnectEventSuccessPayloadImplCopyWith<$Res> {
  __$$ConnectEventSuccessPayloadImplCopyWithImpl(
      _$ConnectEventSuccessPayloadImpl _value,
      $Res Function(_$ConnectEventSuccessPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? device = null,
  }) {
    return _then(_$ConnectEventSuccessPayloadImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      device: null == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectEventSuccessPayloadImpl implements _ConnectEventSuccessPayload {
  const _$ConnectEventSuccessPayloadImpl(
      {required final List<ConnectItemReply> items, required this.device})
      : _items = items;

  factory _$ConnectEventSuccessPayloadImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ConnectEventSuccessPayloadImplFromJson(json);

  final List<ConnectItemReply> _items;
  @override
  List<ConnectItemReply> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DeviceInfo device;

  @override
  String toString() {
    return 'ConnectEventSuccessPayload(items: $items, device: $device)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectEventSuccessPayloadImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.device, device) || other.device == device));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), device);

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectEventSuccessPayloadImplCopyWith<_$ConnectEventSuccessPayloadImpl>
      get copyWith => __$$ConnectEventSuccessPayloadImplCopyWithImpl<
          _$ConnectEventSuccessPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectEventSuccessPayloadImplToJson(
      this,
    );
  }
}

abstract class _ConnectEventSuccessPayload
    implements ConnectEventSuccessPayload {
  const factory _ConnectEventSuccessPayload(
      {required final List<ConnectItemReply> items,
      required final DeviceInfo device}) = _$ConnectEventSuccessPayloadImpl;

  factory _ConnectEventSuccessPayload.fromJson(Map<String, dynamic> json) =
      _$ConnectEventSuccessPayloadImpl.fromJson;

  @override
  List<ConnectItemReply> get items;
  @override
  DeviceInfo get device;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectEventSuccessPayloadImplCopyWith<_$ConnectEventSuccessPayloadImpl>
      get copyWith => throw _privateConstructorUsedError;
}
