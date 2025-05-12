// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckSeedPhraseRouteData {
  String get seedPhrase => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Create a copy of CheckSeedPhraseRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckSeedPhraseRouteDataCopyWith<CheckSeedPhraseRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckSeedPhraseRouteDataCopyWith<$Res> {
  factory $CheckSeedPhraseRouteDataCopyWith(CheckSeedPhraseRouteData value,
          $Res Function(CheckSeedPhraseRouteData) then) =
      _$CheckSeedPhraseRouteDataCopyWithImpl<$Res, CheckSeedPhraseRouteData>;
  @useResult
  $Res call({String seedPhrase, String? name});
}

/// @nodoc
class _$CheckSeedPhraseRouteDataCopyWithImpl<$Res,
        $Val extends CheckSeedPhraseRouteData>
    implements $CheckSeedPhraseRouteDataCopyWith<$Res> {
  _$CheckSeedPhraseRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckSeedPhraseRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedPhrase = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      seedPhrase: null == seedPhrase
          ? _value.seedPhrase
          : seedPhrase // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckSeedPhraseRouteDataImplCopyWith<$Res>
    implements $CheckSeedPhraseRouteDataCopyWith<$Res> {
  factory _$$CheckSeedPhraseRouteDataImplCopyWith(
          _$CheckSeedPhraseRouteDataImpl value,
          $Res Function(_$CheckSeedPhraseRouteDataImpl) then) =
      __$$CheckSeedPhraseRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String seedPhrase, String? name});
}

/// @nodoc
class __$$CheckSeedPhraseRouteDataImplCopyWithImpl<$Res>
    extends _$CheckSeedPhraseRouteDataCopyWithImpl<$Res,
        _$CheckSeedPhraseRouteDataImpl>
    implements _$$CheckSeedPhraseRouteDataImplCopyWith<$Res> {
  __$$CheckSeedPhraseRouteDataImplCopyWithImpl(
      _$CheckSeedPhraseRouteDataImpl _value,
      $Res Function(_$CheckSeedPhraseRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckSeedPhraseRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedPhrase = null,
    Object? name = freezed,
  }) {
    return _then(_$CheckSeedPhraseRouteDataImpl(
      seedPhrase: null == seedPhrase
          ? _value.seedPhrase
          : seedPhrase // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CheckSeedPhraseRouteDataImpl extends _CheckSeedPhraseRouteData {
  const _$CheckSeedPhraseRouteDataImpl(
      {required this.seedPhrase, required this.name})
      : super._();

  @override
  final String seedPhrase;
  @override
  final String? name;

  @override
  String toString() {
    return 'CheckSeedPhraseRouteData(seedPhrase: $seedPhrase, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckSeedPhraseRouteDataImpl &&
            (identical(other.seedPhrase, seedPhrase) ||
                other.seedPhrase == seedPhrase) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seedPhrase, name);

  /// Create a copy of CheckSeedPhraseRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckSeedPhraseRouteDataImplCopyWith<_$CheckSeedPhraseRouteDataImpl>
      get copyWith => __$$CheckSeedPhraseRouteDataImplCopyWithImpl<
          _$CheckSeedPhraseRouteDataImpl>(this, _$identity);
}

abstract class _CheckSeedPhraseRouteData extends CheckSeedPhraseRouteData {
  const factory _CheckSeedPhraseRouteData(
      {required final String seedPhrase,
      required final String? name}) = _$CheckSeedPhraseRouteDataImpl;
  const _CheckSeedPhraseRouteData._() : super._();

  @override
  String get seedPhrase;
  @override
  String? get name;

  /// Create a copy of CheckSeedPhraseRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckSeedPhraseRouteDataImplCopyWith<_$CheckSeedPhraseRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
