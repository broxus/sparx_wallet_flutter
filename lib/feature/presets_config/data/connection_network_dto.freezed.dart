// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_network_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectionNetworkDto _$ConnectionNetworkDtoFromJson(Map<String, dynamic> json) {
  return _ConnectionNetworkDto.fromJson(json);
}

/// @nodoc
mixin _$ConnectionNetworkDto {
  /// Identifier for the default network connection to use.
  String get defaultConnectionId => throw _privateConstructorUsedError;

  /// List of available networks with their configuration details.
  List<Map<String, dynamic>> get networks => throw _privateConstructorUsedError;

  /// List of available transport methods for connections.
  List<Map<String, dynamic>> get transports =>
      throw _privateConstructorUsedError;

  /// Optional custom network configuration options.
  List<Map<String, dynamic>>? get customNetworkOtions =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectionNetworkDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionNetworkDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionNetworkDtoCopyWith<ConnectionNetworkDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionNetworkDtoCopyWith<$Res> {
  factory $ConnectionNetworkDtoCopyWith(ConnectionNetworkDto value,
          $Res Function(ConnectionNetworkDto) then) =
      _$ConnectionNetworkDtoCopyWithImpl<$Res, ConnectionNetworkDto>;
  @useResult
  $Res call(
      {String defaultConnectionId,
      List<Map<String, dynamic>> networks,
      List<Map<String, dynamic>> transports,
      List<Map<String, dynamic>>? customNetworkOtions});
}

/// @nodoc
class _$ConnectionNetworkDtoCopyWithImpl<$Res,
        $Val extends ConnectionNetworkDto>
    implements $ConnectionNetworkDtoCopyWith<$Res> {
  _$ConnectionNetworkDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionNetworkDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultConnectionId = null,
    Object? networks = null,
    Object? transports = null,
    Object? customNetworkOtions = freezed,
  }) {
    return _then(_value.copyWith(
      defaultConnectionId: null == defaultConnectionId
          ? _value.defaultConnectionId
          : defaultConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      networks: null == networks
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      transports: null == transports
          ? _value.transports
          : transports // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      customNetworkOtions: freezed == customNetworkOtions
          ? _value.customNetworkOtions
          : customNetworkOtions // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionNetworkDtoImplCopyWith<$Res>
    implements $ConnectionNetworkDtoCopyWith<$Res> {
  factory _$$ConnectionNetworkDtoImplCopyWith(_$ConnectionNetworkDtoImpl value,
          $Res Function(_$ConnectionNetworkDtoImpl) then) =
      __$$ConnectionNetworkDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String defaultConnectionId,
      List<Map<String, dynamic>> networks,
      List<Map<String, dynamic>> transports,
      List<Map<String, dynamic>>? customNetworkOtions});
}

/// @nodoc
class __$$ConnectionNetworkDtoImplCopyWithImpl<$Res>
    extends _$ConnectionNetworkDtoCopyWithImpl<$Res, _$ConnectionNetworkDtoImpl>
    implements _$$ConnectionNetworkDtoImplCopyWith<$Res> {
  __$$ConnectionNetworkDtoImplCopyWithImpl(_$ConnectionNetworkDtoImpl _value,
      $Res Function(_$ConnectionNetworkDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionNetworkDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultConnectionId = null,
    Object? networks = null,
    Object? transports = null,
    Object? customNetworkOtions = freezed,
  }) {
    return _then(_$ConnectionNetworkDtoImpl(
      defaultConnectionId: null == defaultConnectionId
          ? _value.defaultConnectionId
          : defaultConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      networks: null == networks
          ? _value._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      transports: null == transports
          ? _value._transports
          : transports // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      customNetworkOtions: freezed == customNetworkOtions
          ? _value._customNetworkOtions
          : customNetworkOtions // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionNetworkDtoImpl implements _ConnectionNetworkDto {
  const _$ConnectionNetworkDtoImpl(
      {required this.defaultConnectionId,
      required final List<Map<String, dynamic>> networks,
      required final List<Map<String, dynamic>> transports,
      final List<Map<String, dynamic>>? customNetworkOtions})
      : _networks = networks,
        _transports = transports,
        _customNetworkOtions = customNetworkOtions;

  factory _$ConnectionNetworkDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionNetworkDtoImplFromJson(json);

  /// Identifier for the default network connection to use.
  @override
  final String defaultConnectionId;

  /// List of available networks with their configuration details.
  final List<Map<String, dynamic>> _networks;

  /// List of available networks with their configuration details.
  @override
  List<Map<String, dynamic>> get networks {
    if (_networks is EqualUnmodifiableListView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networks);
  }

  /// List of available transport methods for connections.
  final List<Map<String, dynamic>> _transports;

  /// List of available transport methods for connections.
  @override
  List<Map<String, dynamic>> get transports {
    if (_transports is EqualUnmodifiableListView) return _transports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transports);
  }

  /// Optional custom network configuration options.
  final List<Map<String, dynamic>>? _customNetworkOtions;

  /// Optional custom network configuration options.
  @override
  List<Map<String, dynamic>>? get customNetworkOtions {
    final value = _customNetworkOtions;
    if (value == null) return null;
    if (_customNetworkOtions is EqualUnmodifiableListView)
      return _customNetworkOtions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConnectionNetworkDto(defaultConnectionId: $defaultConnectionId, networks: $networks, transports: $transports, customNetworkOtions: $customNetworkOtions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionNetworkDtoImpl &&
            (identical(other.defaultConnectionId, defaultConnectionId) ||
                other.defaultConnectionId == defaultConnectionId) &&
            const DeepCollectionEquality().equals(other._networks, _networks) &&
            const DeepCollectionEquality()
                .equals(other._transports, _transports) &&
            const DeepCollectionEquality()
                .equals(other._customNetworkOtions, _customNetworkOtions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultConnectionId,
      const DeepCollectionEquality().hash(_networks),
      const DeepCollectionEquality().hash(_transports),
      const DeepCollectionEquality().hash(_customNetworkOtions));

  /// Create a copy of ConnectionNetworkDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionNetworkDtoImplCopyWith<_$ConnectionNetworkDtoImpl>
      get copyWith =>
          __$$ConnectionNetworkDtoImplCopyWithImpl<_$ConnectionNetworkDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionNetworkDtoImplToJson(
      this,
    );
  }
}

abstract class _ConnectionNetworkDto implements ConnectionNetworkDto {
  const factory _ConnectionNetworkDto(
          {required final String defaultConnectionId,
          required final List<Map<String, dynamic>> networks,
          required final List<Map<String, dynamic>> transports,
          final List<Map<String, dynamic>>? customNetworkOtions}) =
      _$ConnectionNetworkDtoImpl;

  factory _ConnectionNetworkDto.fromJson(Map<String, dynamic> json) =
      _$ConnectionNetworkDtoImpl.fromJson;

  /// Identifier for the default network connection to use.
  @override
  String get defaultConnectionId;

  /// List of available networks with their configuration details.
  @override
  List<Map<String, dynamic>> get networks;

  /// List of available transport methods for connections.
  @override
  List<Map<String, dynamic>> get transports;

  /// Optional custom network configuration options.
  @override
  List<Map<String, dynamic>>? get customNetworkOtions;

  /// Create a copy of ConnectionNetworkDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionNetworkDtoImplCopyWith<_$ConnectionNetworkDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
