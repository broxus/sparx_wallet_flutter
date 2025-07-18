// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_removed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountRemovedEvent {
  AssetsList get account;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountRemovedEventCopyWith<AccountRemovedEvent> get copyWith =>
      _$AccountRemovedEventCopyWithImpl<AccountRemovedEvent>(
          this as AccountRemovedEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountRemovedEvent &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  @override
  String toString() {
    return 'AccountRemovedEvent(account: $account)';
  }
}

/// @nodoc
abstract mixin class $AccountRemovedEventCopyWith<$Res> {
  factory $AccountRemovedEventCopyWith(
          AccountRemovedEvent value, $Res Function(AccountRemovedEvent) _then) =
      _$AccountRemovedEventCopyWithImpl;
  @useResult
  $Res call({AssetsList account});

  $AssetsListCopyWith<$Res> get account;
}

/// @nodoc
class _$AccountRemovedEventCopyWithImpl<$Res>
    implements $AccountRemovedEventCopyWith<$Res> {
  _$AccountRemovedEventCopyWithImpl(this._self, this._then);

  final AccountRemovedEvent _self;
  final $Res Function(AccountRemovedEvent) _then;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
  }) {
    return _then(_self.copyWith(
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as AssetsList,
    ));
  }

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssetsListCopyWith<$Res> get account {
    return $AssetsListCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }
}

/// @nodoc

class _AccountRemovedEvent implements AccountRemovedEvent {
  const _AccountRemovedEvent(this.account);

  @override
  final AssetsList account;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccountRemovedEventCopyWith<_AccountRemovedEvent> get copyWith =>
      __$AccountRemovedEventCopyWithImpl<_AccountRemovedEvent>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccountRemovedEvent &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  @override
  String toString() {
    return 'AccountRemovedEvent(account: $account)';
  }
}

/// @nodoc
abstract mixin class _$AccountRemovedEventCopyWith<$Res>
    implements $AccountRemovedEventCopyWith<$Res> {
  factory _$AccountRemovedEventCopyWith(_AccountRemovedEvent value,
          $Res Function(_AccountRemovedEvent) _then) =
      __$AccountRemovedEventCopyWithImpl;
  @override
  @useResult
  $Res call({AssetsList account});

  @override
  $AssetsListCopyWith<$Res> get account;
}

/// @nodoc
class __$AccountRemovedEventCopyWithImpl<$Res>
    implements _$AccountRemovedEventCopyWith<$Res> {
  __$AccountRemovedEventCopyWithImpl(this._self, this._then);

  final _AccountRemovedEvent _self;
  final $Res Function(_AccountRemovedEvent) _then;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? account = null,
  }) {
    return _then(_AccountRemovedEvent(
      null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as AssetsList,
    ));
  }

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssetsListCopyWith<$Res> get account {
    return $AssetsListCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }
}

// dart format on
