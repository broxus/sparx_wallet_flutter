// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Feature _$FeatureFromJson(Map<String, dynamic> json) {
  switch (json['name']) {
    case 'SendTransaction':
      return _SendTransaction.fromJson(json);
    case 'SignData':
      return _SignData.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'name', 'Feature', 'Invalid union type "${json['name']}"!');
  }
}

/// @nodoc
mixin _$Feature {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int maxMessages) sendTransaction,
    required TResult Function() signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int maxMessages)? sendTransaction,
    TResult? Function()? signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int maxMessages)? sendTransaction,
    TResult Function()? signData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendTransaction value) sendTransaction,
    required TResult Function(_SignData value) signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendTransaction value)? sendTransaction,
    TResult? Function(_SignData value)? signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendTransaction value)? sendTransaction,
    TResult Function(_SignData value)? signData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Feature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureCopyWith<$Res> {
  factory $FeatureCopyWith(Feature value, $Res Function(Feature) then) =
      _$FeatureCopyWithImpl<$Res, Feature>;
}

/// @nodoc
class _$FeatureCopyWithImpl<$Res, $Val extends Feature>
    implements $FeatureCopyWith<$Res> {
  _$FeatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Feature
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SendTransactionImplCopyWith<$Res> {
  factory _$$SendTransactionImplCopyWith(_$SendTransactionImpl value,
          $Res Function(_$SendTransactionImpl) then) =
      __$$SendTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int maxMessages});
}

/// @nodoc
class __$$SendTransactionImplCopyWithImpl<$Res>
    extends _$FeatureCopyWithImpl<$Res, _$SendTransactionImpl>
    implements _$$SendTransactionImplCopyWith<$Res> {
  __$$SendTransactionImplCopyWithImpl(
      _$SendTransactionImpl _value, $Res Function(_$SendTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Feature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxMessages = null,
  }) {
    return _then(_$SendTransactionImpl(
      maxMessages: null == maxMessages
          ? _value.maxMessages
          : maxMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendTransactionImpl implements _SendTransaction {
  const _$SendTransactionImpl({required this.maxMessages, final String? $type})
      : $type = $type ?? 'SendTransaction';

  factory _$SendTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendTransactionImplFromJson(json);

  @override
  final int maxMessages;

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'Feature.sendTransaction(maxMessages: $maxMessages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionImpl &&
            (identical(other.maxMessages, maxMessages) ||
                other.maxMessages == maxMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, maxMessages);

  /// Create a copy of Feature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionImplCopyWith<_$SendTransactionImpl> get copyWith =>
      __$$SendTransactionImplCopyWithImpl<_$SendTransactionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int maxMessages) sendTransaction,
    required TResult Function() signData,
  }) {
    return sendTransaction(maxMessages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int maxMessages)? sendTransaction,
    TResult? Function()? signData,
  }) {
    return sendTransaction?.call(maxMessages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int maxMessages)? sendTransaction,
    TResult Function()? signData,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(maxMessages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendTransaction value) sendTransaction,
    required TResult Function(_SignData value) signData,
  }) {
    return sendTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendTransaction value)? sendTransaction,
    TResult? Function(_SignData value)? signData,
  }) {
    return sendTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendTransaction value)? sendTransaction,
    TResult Function(_SignData value)? signData,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SendTransactionImplToJson(
      this,
    );
  }
}

abstract class _SendTransaction implements Feature {
  const factory _SendTransaction({required final int maxMessages}) =
      _$SendTransactionImpl;

  factory _SendTransaction.fromJson(Map<String, dynamic> json) =
      _$SendTransactionImpl.fromJson;

  int get maxMessages;

  /// Create a copy of Feature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTransactionImplCopyWith<_$SendTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignDataImplCopyWith<$Res> {
  factory _$$SignDataImplCopyWith(
          _$SignDataImpl value, $Res Function(_$SignDataImpl) then) =
      __$$SignDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignDataImplCopyWithImpl<$Res>
    extends _$FeatureCopyWithImpl<$Res, _$SignDataImpl>
    implements _$$SignDataImplCopyWith<$Res> {
  __$$SignDataImplCopyWithImpl(
      _$SignDataImpl _value, $Res Function(_$SignDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Feature
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SignDataImpl implements _SignData {
  const _$SignDataImpl({final String? $type}) : $type = $type ?? 'SignData';

  factory _$SignDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignDataImplFromJson(json);

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'Feature.signData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignDataImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int maxMessages) sendTransaction,
    required TResult Function() signData,
  }) {
    return signData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int maxMessages)? sendTransaction,
    TResult? Function()? signData,
  }) {
    return signData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int maxMessages)? sendTransaction,
    TResult Function()? signData,
    required TResult orElse(),
  }) {
    if (signData != null) {
      return signData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendTransaction value) sendTransaction,
    required TResult Function(_SignData value) signData,
  }) {
    return signData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendTransaction value)? sendTransaction,
    TResult? Function(_SignData value)? signData,
  }) {
    return signData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendTransaction value)? sendTransaction,
    TResult Function(_SignData value)? signData,
    required TResult orElse(),
  }) {
    if (signData != null) {
      return signData(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SignDataImplToJson(
      this,
    );
  }
}

abstract class _SignData implements Feature {
  const factory _SignData() = _$SignDataImpl;

  factory _SignData.fromJson(Map<String, dynamic> json) =
      _$SignDataImpl.fromJson;
}
