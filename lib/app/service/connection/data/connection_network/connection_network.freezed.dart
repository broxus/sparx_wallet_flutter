// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionNetwork {
  String get id;
  String get networkName;
  int get defaultWorkchainId;
  List<ConnectionWorkchainData> get workchains;
  double get sortingOrder;

  /// Create a copy of ConnectionNetwork
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionNetworkCopyWith<ConnectionNetwork> get copyWith =>
      _$ConnectionNetworkCopyWithImpl<ConnectionNetwork>(
          this as ConnectionNetwork, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionNetwork &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.defaultWorkchainId, defaultWorkchainId) ||
                other.defaultWorkchainId == defaultWorkchainId) &&
            const DeepCollectionEquality()
                .equals(other.workchains, workchains) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      networkName,
      defaultWorkchainId,
      const DeepCollectionEquality().hash(workchains),
      sortingOrder);

  @override
  String toString() {
    return 'ConnectionNetwork(id: $id, networkName: $networkName, defaultWorkchainId: $defaultWorkchainId, workchains: $workchains, sortingOrder: $sortingOrder)';
  }
}

/// @nodoc
abstract mixin class $ConnectionNetworkCopyWith<$Res> {
  factory $ConnectionNetworkCopyWith(
          ConnectionNetwork value, $Res Function(ConnectionNetwork) _then) =
      _$ConnectionNetworkCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String networkName,
      int defaultWorkchainId,
      List<ConnectionWorkchainData> workchains,
      double sortingOrder});
}

/// @nodoc
class _$ConnectionNetworkCopyWithImpl<$Res>
    implements $ConnectionNetworkCopyWith<$Res> {
  _$ConnectionNetworkCopyWithImpl(this._self, this._then);

  final ConnectionNetwork _self;
  final $Res Function(ConnectionNetwork) _then;

  /// Create a copy of ConnectionNetwork
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? networkName = null,
    Object? defaultWorkchainId = null,
    Object? workchains = null,
    Object? sortingOrder = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      networkName: null == networkName
          ? _self.networkName
          : networkName // ignore: cast_nullable_to_non_nullable
              as String,
      defaultWorkchainId: null == defaultWorkchainId
          ? _self.defaultWorkchainId
          : defaultWorkchainId // ignore: cast_nullable_to_non_nullable
              as int,
      workchains: null == workchains
          ? _self.workchains
          : workchains // ignore: cast_nullable_to_non_nullable
              as List<ConnectionWorkchainData>,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _ConnectionNetwork extends ConnectionNetwork {
  _ConnectionNetwork(
      {required this.id,
      required this.networkName,
      required this.defaultWorkchainId,
      required final List<ConnectionWorkchainData> workchains,
      required this.sortingOrder})
      : _workchains = workchains,
        super._();

  @override
  final String id;
  @override
  final String networkName;
  @override
  final int defaultWorkchainId;
  final List<ConnectionWorkchainData> _workchains;
  @override
  List<ConnectionWorkchainData> get workchains {
    if (_workchains is EqualUnmodifiableListView) return _workchains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workchains);
  }

  @override
  final double sortingOrder;

  /// Create a copy of ConnectionNetwork
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionNetworkCopyWith<_ConnectionNetwork> get copyWith =>
      __$ConnectionNetworkCopyWithImpl<_ConnectionNetwork>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionNetwork &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.defaultWorkchainId, defaultWorkchainId) ||
                other.defaultWorkchainId == defaultWorkchainId) &&
            const DeepCollectionEquality()
                .equals(other._workchains, _workchains) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      networkName,
      defaultWorkchainId,
      const DeepCollectionEquality().hash(_workchains),
      sortingOrder);

  @override
  String toString() {
    return 'ConnectionNetwork(id: $id, networkName: $networkName, defaultWorkchainId: $defaultWorkchainId, workchains: $workchains, sortingOrder: $sortingOrder)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionNetworkCopyWith<$Res>
    implements $ConnectionNetworkCopyWith<$Res> {
  factory _$ConnectionNetworkCopyWith(
          _ConnectionNetwork value, $Res Function(_ConnectionNetwork) _then) =
      __$ConnectionNetworkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String networkName,
      int defaultWorkchainId,
      List<ConnectionWorkchainData> workchains,
      double sortingOrder});
}

/// @nodoc
class __$ConnectionNetworkCopyWithImpl<$Res>
    implements _$ConnectionNetworkCopyWith<$Res> {
  __$ConnectionNetworkCopyWithImpl(this._self, this._then);

  final _ConnectionNetwork _self;
  final $Res Function(_ConnectionNetwork) _then;

  /// Create a copy of ConnectionNetwork
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? networkName = null,
    Object? defaultWorkchainId = null,
    Object? workchains = null,
    Object? sortingOrder = null,
  }) {
    return _then(_ConnectionNetwork(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      networkName: null == networkName
          ? _self.networkName
          : networkName // ignore: cast_nullable_to_non_nullable
              as String,
      defaultWorkchainId: null == defaultWorkchainId
          ? _self.defaultWorkchainId
          : defaultWorkchainId // ignore: cast_nullable_to_non_nullable
              as int,
      workchains: null == workchains
          ? _self._workchains
          : workchains // ignore: cast_nullable_to_non_nullable
              as List<ConnectionWorkchainData>,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
