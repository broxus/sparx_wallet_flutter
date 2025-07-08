// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConnectResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KeyAccount account,
            List<ConnectItemReply> replyItems, DappManifest manifest)
        success,
    required TResult Function(TonConnectError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KeyAccount account, List<ConnectItemReply> replyItems,
            DappManifest manifest)?
        success,
    TResult? Function(TonConnectError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KeyAccount account, List<ConnectItemReply> replyItems,
            DappManifest manifest)?
        success,
    TResult Function(TonConnectError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectResultSuccess value) success,
    required TResult Function(ConnectResultError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectResultSuccess value)? success,
    TResult? Function(ConnectResultError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectResultSuccess value)? success,
    TResult Function(ConnectResultError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectResultCopyWith<$Res> {
  factory $ConnectResultCopyWith(
          ConnectResult value, $Res Function(ConnectResult) then) =
      _$ConnectResultCopyWithImpl<$Res, ConnectResult>;
}

/// @nodoc
class _$ConnectResultCopyWithImpl<$Res, $Val extends ConnectResult>
    implements $ConnectResultCopyWith<$Res> {
  _$ConnectResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectResultSuccessImplCopyWith<$Res> {
  factory _$$ConnectResultSuccessImplCopyWith(_$ConnectResultSuccessImpl value,
          $Res Function(_$ConnectResultSuccessImpl) then) =
      __$$ConnectResultSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {KeyAccount account,
      List<ConnectItemReply> replyItems,
      DappManifest manifest});

  $DappManifestCopyWith<$Res> get manifest;
}

/// @nodoc
class __$$ConnectResultSuccessImplCopyWithImpl<$Res>
    extends _$ConnectResultCopyWithImpl<$Res, _$ConnectResultSuccessImpl>
    implements _$$ConnectResultSuccessImplCopyWith<$Res> {
  __$$ConnectResultSuccessImplCopyWithImpl(_$ConnectResultSuccessImpl _value,
      $Res Function(_$ConnectResultSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? replyItems = null,
    Object? manifest = null,
  }) {
    return _then(_$ConnectResultSuccessImpl(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      replyItems: null == replyItems
          ? _value._replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      manifest: null == manifest
          ? _value.manifest
          : manifest // ignore: cast_nullable_to_non_nullable
              as DappManifest,
    ));
  }

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DappManifestCopyWith<$Res> get manifest {
    return $DappManifestCopyWith<$Res>(_value.manifest, (value) {
      return _then(_value.copyWith(manifest: value));
    });
  }
}

/// @nodoc

class _$ConnectResultSuccessImpl implements ConnectResultSuccess {
  _$ConnectResultSuccessImpl(
      {required this.account,
      required final List<ConnectItemReply> replyItems,
      required this.manifest})
      : _replyItems = replyItems;

  @override
  final KeyAccount account;
  final List<ConnectItemReply> _replyItems;
  @override
  List<ConnectItemReply> get replyItems {
    if (_replyItems is EqualUnmodifiableListView) return _replyItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyItems);
  }

  @override
  final DappManifest manifest;

  @override
  String toString() {
    return 'ConnectResult.success(account: $account, replyItems: $replyItems, manifest: $manifest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectResultSuccessImpl &&
            (identical(other.account, account) || other.account == account) &&
            const DeepCollectionEquality()
                .equals(other._replyItems, _replyItems) &&
            (identical(other.manifest, manifest) ||
                other.manifest == manifest));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account,
      const DeepCollectionEquality().hash(_replyItems), manifest);

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectResultSuccessImplCopyWith<_$ConnectResultSuccessImpl>
      get copyWith =>
          __$$ConnectResultSuccessImplCopyWithImpl<_$ConnectResultSuccessImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KeyAccount account,
            List<ConnectItemReply> replyItems, DappManifest manifest)
        success,
    required TResult Function(TonConnectError error) error,
  }) {
    return success(account, replyItems, manifest);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KeyAccount account, List<ConnectItemReply> replyItems,
            DappManifest manifest)?
        success,
    TResult? Function(TonConnectError error)? error,
  }) {
    return success?.call(account, replyItems, manifest);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KeyAccount account, List<ConnectItemReply> replyItems,
            DappManifest manifest)?
        success,
    TResult Function(TonConnectError error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(account, replyItems, manifest);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectResultSuccess value) success,
    required TResult Function(ConnectResultError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectResultSuccess value)? success,
    TResult? Function(ConnectResultError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectResultSuccess value)? success,
    TResult Function(ConnectResultError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ConnectResultSuccess implements ConnectResult {
  factory ConnectResultSuccess(
      {required final KeyAccount account,
      required final List<ConnectItemReply> replyItems,
      required final DappManifest manifest}) = _$ConnectResultSuccessImpl;

  KeyAccount get account;
  List<ConnectItemReply> get replyItems;
  DappManifest get manifest;

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectResultSuccessImplCopyWith<_$ConnectResultSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectResultErrorImplCopyWith<$Res> {
  factory _$$ConnectResultErrorImplCopyWith(_$ConnectResultErrorImpl value,
          $Res Function(_$ConnectResultErrorImpl) then) =
      __$$ConnectResultErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TonConnectError error});

  $TonConnectErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$ConnectResultErrorImplCopyWithImpl<$Res>
    extends _$ConnectResultCopyWithImpl<$Res, _$ConnectResultErrorImpl>
    implements _$$ConnectResultErrorImplCopyWith<$Res> {
  __$$ConnectResultErrorImplCopyWithImpl(_$ConnectResultErrorImpl _value,
      $Res Function(_$ConnectResultErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ConnectResultErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as TonConnectError,
    ));
  }

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<$Res> get error {
    return $TonConnectErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$ConnectResultErrorImpl implements ConnectResultError {
  _$ConnectResultErrorImpl({required this.error});

  @override
  final TonConnectError error;

  @override
  String toString() {
    return 'ConnectResult.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectResultErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectResultErrorImplCopyWith<_$ConnectResultErrorImpl> get copyWith =>
      __$$ConnectResultErrorImplCopyWithImpl<_$ConnectResultErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KeyAccount account,
            List<ConnectItemReply> replyItems, DappManifest manifest)
        success,
    required TResult Function(TonConnectError error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KeyAccount account, List<ConnectItemReply> replyItems,
            DappManifest manifest)?
        success,
    TResult? Function(TonConnectError error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KeyAccount account, List<ConnectItemReply> replyItems,
            DappManifest manifest)?
        success,
    TResult Function(TonConnectError error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectResultSuccess value) success,
    required TResult Function(ConnectResultError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectResultSuccess value)? success,
    TResult? Function(ConnectResultError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectResultSuccess value)? success,
    TResult Function(ConnectResultError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConnectResultError implements ConnectResult {
  factory ConnectResultError({required final TonConnectError error}) =
      _$ConnectResultErrorImpl;

  TonConnectError get error;

  /// Create a copy of ConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectResultErrorImplCopyWith<_$ConnectResultErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
