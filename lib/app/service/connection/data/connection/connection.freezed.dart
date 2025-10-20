// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Connection {
  String get id;
  String get networkName;
  int get defaultWorkchainId;
  ConnectionWorkchain get defaultWorkchain;
  List<ConnectionWorkchain> get workchains;
  bool get isPreset;
  bool get canBeEdited;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionCopyWith<Connection> get copyWith =>
      _$ConnectionCopyWithImpl<Connection>(this as Connection, _$identity);

  /// Serializes this Connection to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Connection &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.defaultWorkchainId, defaultWorkchainId) ||
                other.defaultWorkchainId == defaultWorkchainId) &&
            (identical(other.defaultWorkchain, defaultWorkchain) ||
                other.defaultWorkchain == defaultWorkchain) &&
            const DeepCollectionEquality()
                .equals(other.workchains, workchains) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      networkName,
      defaultWorkchainId,
      defaultWorkchain,
      const DeepCollectionEquality().hash(workchains),
      isPreset,
      canBeEdited);

  @override
  String toString() {
    return 'Connection(id: $id, networkName: $networkName, defaultWorkchainId: $defaultWorkchainId, defaultWorkchain: $defaultWorkchain, workchains: $workchains, isPreset: $isPreset, canBeEdited: $canBeEdited)';
  }
}

/// @nodoc
abstract mixin class $ConnectionCopyWith<$Res> {
  factory $ConnectionCopyWith(
          Connection value, $Res Function(Connection) _then) =
      _$ConnectionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String networkName,
      int defaultWorkchainId,
      ConnectionWorkchain defaultWorkchain,
      List<ConnectionWorkchain> workchains,
      bool isPreset,
      bool canBeEdited});

  $ConnectionWorkchainCopyWith<$Res> get defaultWorkchain;
}

/// @nodoc
class _$ConnectionCopyWithImpl<$Res> implements $ConnectionCopyWith<$Res> {
  _$ConnectionCopyWithImpl(this._self, this._then);

  final Connection _self;
  final $Res Function(Connection) _then;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? networkName = null,
    Object? defaultWorkchainId = null,
    Object? defaultWorkchain = null,
    Object? workchains = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
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
      defaultWorkchain: null == defaultWorkchain
          ? _self.defaultWorkchain
          : defaultWorkchain // ignore: cast_nullable_to_non_nullable
              as ConnectionWorkchain,
      workchains: null == workchains
          ? _self.workchains
          : workchains // ignore: cast_nullable_to_non_nullable
              as List<ConnectionWorkchain>,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionWorkchainCopyWith<$Res> get defaultWorkchain {
    return $ConnectionWorkchainCopyWith<$Res>(_self.defaultWorkchain, (value) {
      return _then(_self.copyWith(defaultWorkchain: value));
    });
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _Connection implements Connection {
  _Connection(
      {required this.id,
      required this.networkName,
      required this.defaultWorkchainId,
      required this.defaultWorkchain,
      required final List<ConnectionWorkchain> workchains,
      required this.isPreset,
      required this.canBeEdited})
      : _workchains = workchains;

  @override
  final String id;
  @override
  final String networkName;
  @override
  final int defaultWorkchainId;
  @override
  final ConnectionWorkchain defaultWorkchain;
  final List<ConnectionWorkchain> _workchains;
  @override
  List<ConnectionWorkchain> get workchains {
    if (_workchains is EqualUnmodifiableListView) return _workchains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workchains);
  }

  @override
  final bool isPreset;
  @override
  final bool canBeEdited;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionCopyWith<_Connection> get copyWith =>
      __$ConnectionCopyWithImpl<_Connection>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Connection &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.defaultWorkchainId, defaultWorkchainId) ||
                other.defaultWorkchainId == defaultWorkchainId) &&
            (identical(other.defaultWorkchain, defaultWorkchain) ||
                other.defaultWorkchain == defaultWorkchain) &&
            const DeepCollectionEquality()
                .equals(other._workchains, _workchains) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      networkName,
      defaultWorkchainId,
      defaultWorkchain,
      const DeepCollectionEquality().hash(_workchains),
      isPreset,
      canBeEdited);

  @override
  String toString() {
    return 'Connection._(id: $id, networkName: $networkName, defaultWorkchainId: $defaultWorkchainId, defaultWorkchain: $defaultWorkchain, workchains: $workchains, isPreset: $isPreset, canBeEdited: $canBeEdited)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionCopyWith<$Res>
    implements $ConnectionCopyWith<$Res> {
  factory _$ConnectionCopyWith(
          _Connection value, $Res Function(_Connection) _then) =
      __$ConnectionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String networkName,
      int defaultWorkchainId,
      ConnectionWorkchain defaultWorkchain,
      List<ConnectionWorkchain> workchains,
      bool isPreset,
      bool canBeEdited});

  @override
  $ConnectionWorkchainCopyWith<$Res> get defaultWorkchain;
}

/// @nodoc
class __$ConnectionCopyWithImpl<$Res> implements _$ConnectionCopyWith<$Res> {
  __$ConnectionCopyWithImpl(this._self, this._then);

  final _Connection _self;
  final $Res Function(_Connection) _then;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? networkName = null,
    Object? defaultWorkchainId = null,
    Object? defaultWorkchain = null,
    Object? workchains = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
  }) {
    return _then(_Connection(
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
      defaultWorkchain: null == defaultWorkchain
          ? _self.defaultWorkchain
          : defaultWorkchain // ignore: cast_nullable_to_non_nullable
              as ConnectionWorkchain,
      workchains: null == workchains
          ? _self._workchains
          : workchains // ignore: cast_nullable_to_non_nullable
              as List<ConnectionWorkchain>,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionWorkchainCopyWith<$Res> get defaultWorkchain {
    return $ConnectionWorkchainCopyWith<$Res>(_self.defaultWorkchain, (value) {
      return _then(_self.copyWith(defaultWorkchain: value));
    });
  }
}

// dart format on
