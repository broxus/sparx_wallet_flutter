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
mixin _$CreateSeedPasswordRouteData {
  /// Seed phrase
  SeedPhraseModel? get phrase => throw _privateConstructorUsedError;

  /// Mnemonic type
  MnemonicType? get mnemonicType => throw _privateConstructorUsedError;

  /// Create a copy of CreateSeedPasswordRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSeedPasswordRouteDataCopyWith<CreateSeedPasswordRouteData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSeedPasswordRouteDataCopyWith<$Res> {
  factory $CreateSeedPasswordRouteDataCopyWith(
          CreateSeedPasswordRouteData value,
          $Res Function(CreateSeedPasswordRouteData) then) =
      _$CreateSeedPasswordRouteDataCopyWithImpl<$Res,
          CreateSeedPasswordRouteData>;
  @useResult
  $Res call({SeedPhraseModel? phrase, MnemonicType? mnemonicType});

  $MnemonicTypeCopyWith<$Res>? get mnemonicType;
}

/// @nodoc
class _$CreateSeedPasswordRouteDataCopyWithImpl<$Res,
        $Val extends CreateSeedPasswordRouteData>
    implements $CreateSeedPasswordRouteDataCopyWith<$Res> {
  _$CreateSeedPasswordRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSeedPasswordRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phrase = freezed,
    Object? mnemonicType = freezed,
  }) {
    return _then(_value.copyWith(
      phrase: freezed == phrase
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as SeedPhraseModel?,
      mnemonicType: freezed == mnemonicType
          ? _value.mnemonicType
          : mnemonicType // ignore: cast_nullable_to_non_nullable
              as MnemonicType?,
    ) as $Val);
  }

  /// Create a copy of CreateSeedPasswordRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MnemonicTypeCopyWith<$Res>? get mnemonicType {
    if (_value.mnemonicType == null) {
      return null;
    }

    return $MnemonicTypeCopyWith<$Res>(_value.mnemonicType!, (value) {
      return _then(_value.copyWith(mnemonicType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateSeedPasswordRouteDataImplCopyWith<$Res>
    implements $CreateSeedPasswordRouteDataCopyWith<$Res> {
  factory _$$CreateSeedPasswordRouteDataImplCopyWith(
          _$CreateSeedPasswordRouteDataImpl value,
          $Res Function(_$CreateSeedPasswordRouteDataImpl) then) =
      __$$CreateSeedPasswordRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SeedPhraseModel? phrase, MnemonicType? mnemonicType});

  @override
  $MnemonicTypeCopyWith<$Res>? get mnemonicType;
}

/// @nodoc
class __$$CreateSeedPasswordRouteDataImplCopyWithImpl<$Res>
    extends _$CreateSeedPasswordRouteDataCopyWithImpl<$Res,
        _$CreateSeedPasswordRouteDataImpl>
    implements _$$CreateSeedPasswordRouteDataImplCopyWith<$Res> {
  __$$CreateSeedPasswordRouteDataImplCopyWithImpl(
      _$CreateSeedPasswordRouteDataImpl _value,
      $Res Function(_$CreateSeedPasswordRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateSeedPasswordRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phrase = freezed,
    Object? mnemonicType = freezed,
  }) {
    return _then(_$CreateSeedPasswordRouteDataImpl(
      phrase: freezed == phrase
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as SeedPhraseModel?,
      mnemonicType: freezed == mnemonicType
          ? _value.mnemonicType
          : mnemonicType // ignore: cast_nullable_to_non_nullable
              as MnemonicType?,
    ));
  }
}

/// @nodoc

class _$CreateSeedPasswordRouteDataImpl extends _CreateSeedPasswordRouteData {
  const _$CreateSeedPasswordRouteDataImpl({this.phrase, this.mnemonicType})
      : super._();

  /// Seed phrase
  @override
  final SeedPhraseModel? phrase;

  /// Mnemonic type
  @override
  final MnemonicType? mnemonicType;

  @override
  String toString() {
    return 'CreateSeedPasswordRouteData(phrase: $phrase, mnemonicType: $mnemonicType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSeedPasswordRouteDataImpl &&
            (identical(other.phrase, phrase) || other.phrase == phrase) &&
            (identical(other.mnemonicType, mnemonicType) ||
                other.mnemonicType == mnemonicType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phrase, mnemonicType);

  /// Create a copy of CreateSeedPasswordRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSeedPasswordRouteDataImplCopyWith<_$CreateSeedPasswordRouteDataImpl>
      get copyWith => __$$CreateSeedPasswordRouteDataImplCopyWithImpl<
          _$CreateSeedPasswordRouteDataImpl>(this, _$identity);
}

abstract class _CreateSeedPasswordRouteData
    extends CreateSeedPasswordRouteData {
  const factory _CreateSeedPasswordRouteData(
      {final SeedPhraseModel? phrase,
      final MnemonicType? mnemonicType}) = _$CreateSeedPasswordRouteDataImpl;
  const _CreateSeedPasswordRouteData._() : super._();

  /// Seed phrase
  @override
  SeedPhraseModel? get phrase;

  /// Mnemonic type
  @override
  MnemonicType? get mnemonicType;

  /// Create a copy of CreateSeedPasswordRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSeedPasswordRouteDataImplCopyWith<_$CreateSeedPasswordRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
