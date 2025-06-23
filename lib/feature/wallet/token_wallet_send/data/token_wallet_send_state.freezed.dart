// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenWalletSendState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenWalletSendState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletSendState()';
  }
}

/// @nodoc
class $TokenWalletSendStateCopyWith<$Res> {
  $TokenWalletSendStateCopyWith(
      TokenWalletSendState _, $Res Function(TokenWalletSendState) __);
}

/// @nodoc

class TokenWalletSendStateError implements TokenWalletSendState {
  const TokenWalletSendStateError({required this.error});

  final Object error;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletSendStateErrorCopyWith<TokenWalletSendStateError> get copyWith =>
      _$TokenWalletSendStateErrorCopyWithImpl<TokenWalletSendStateError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletSendStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'TokenWalletSendState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletSendStateErrorCopyWith<$Res>
    implements $TokenWalletSendStateCopyWith<$Res> {
  factory $TokenWalletSendStateErrorCopyWith(TokenWalletSendStateError value,
          $Res Function(TokenWalletSendStateError) _then) =
      _$TokenWalletSendStateErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$TokenWalletSendStateErrorCopyWithImpl<$Res>
    implements $TokenWalletSendStateErrorCopyWith<$Res> {
  _$TokenWalletSendStateErrorCopyWithImpl(this._self, this._then);

  final TokenWalletSendStateError _self;
  final $Res Function(TokenWalletSendStateError) _then;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(TokenWalletSendStateError(
      error: null == error ? _self.error : error,
    ));
  }
}

/// @nodoc

class TokenWalletSendStateReady implements TokenWalletSendState {
  const TokenWalletSendStateReady();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletSendStateReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletSendState.ready()';
  }
}

/// @nodoc

class TokenWalletSendStateSending implements TokenWalletSendState {
  const TokenWalletSendStateSending({required this.canClose});

  final bool canClose;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletSendStateSendingCopyWith<TokenWalletSendStateSending>
      get copyWith => _$TokenWalletSendStateSendingCopyWithImpl<
          TokenWalletSendStateSending>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletSendStateSending &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  @override
  String toString() {
    return 'TokenWalletSendState.sending(canClose: $canClose)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletSendStateSendingCopyWith<$Res>
    implements $TokenWalletSendStateCopyWith<$Res> {
  factory $TokenWalletSendStateSendingCopyWith(
          TokenWalletSendStateSending value,
          $Res Function(TokenWalletSendStateSending) _then) =
      _$TokenWalletSendStateSendingCopyWithImpl;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class _$TokenWalletSendStateSendingCopyWithImpl<$Res>
    implements $TokenWalletSendStateSendingCopyWith<$Res> {
  _$TokenWalletSendStateSendingCopyWithImpl(this._self, this._then);

  final TokenWalletSendStateSending _self;
  final $Res Function(TokenWalletSendStateSending) _then;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canClose = null,
  }) {
    return _then(TokenWalletSendStateSending(
      canClose: null == canClose
          ? _self.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
