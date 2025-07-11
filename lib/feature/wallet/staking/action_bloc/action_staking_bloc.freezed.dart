// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_staking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActionStakingBlocEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ActionStakingBlocEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActionStakingBlocEvent()';
  }
}

/// @nodoc
class $ActionStakingBlocEventCopyWith<$Res> {
  $ActionStakingBlocEventCopyWith(
      ActionStakingBlocEvent _, $Res Function(ActionStakingBlocEvent) __);
}

/// @nodoc

class _Init implements ActionStakingBlocEvent {
  const _Init();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Init);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActionStakingBlocEvent.init()';
  }
}

/// @nodoc

class _Stake implements ActionStakingBlocEvent {
  const _Stake({required this.amount, required this.accountKey});

// in native tokens
  final BigInt amount;
  final PublicKey accountKey;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StakeCopyWith<_Stake> get copyWith =>
      __$StakeCopyWithImpl<_Stake>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Stake &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, accountKey);

  @override
  String toString() {
    return 'ActionStakingBlocEvent.stake(amount: $amount, accountKey: $accountKey)';
  }
}

/// @nodoc
abstract mixin class _$StakeCopyWith<$Res>
    implements $ActionStakingBlocEventCopyWith<$Res> {
  factory _$StakeCopyWith(_Stake value, $Res Function(_Stake) _then) =
      __$StakeCopyWithImpl;
  @useResult
  $Res call({BigInt amount, PublicKey accountKey});

  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class __$StakeCopyWithImpl<$Res> implements _$StakeCopyWith<$Res> {
  __$StakeCopyWithImpl(this._self, this._then);

  final _Stake _self;
  final $Res Function(_Stake) _then;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? accountKey = null,
  }) {
    return _then(_Stake(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      accountKey: null == accountKey
          ? _self.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_self.accountKey, (value) {
      return _then(_self.copyWith(accountKey: value));
    });
  }
}

/// @nodoc

class _Unstake implements ActionStakingBlocEvent {
  const _Unstake(
      {required this.amount,
      required this.accountKey,
      required this.withdrawHours});

// in staking tokens
  final BigInt amount;
  final PublicKey accountKey;
  final int withdrawHours;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnstakeCopyWith<_Unstake> get copyWith =>
      __$UnstakeCopyWithImpl<_Unstake>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Unstake &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.withdrawHours, withdrawHours) ||
                other.withdrawHours == withdrawHours));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, accountKey, withdrawHours);

  @override
  String toString() {
    return 'ActionStakingBlocEvent.unstake(amount: $amount, accountKey: $accountKey, withdrawHours: $withdrawHours)';
  }
}

/// @nodoc
abstract mixin class _$UnstakeCopyWith<$Res>
    implements $ActionStakingBlocEventCopyWith<$Res> {
  factory _$UnstakeCopyWith(_Unstake value, $Res Function(_Unstake) _then) =
      __$UnstakeCopyWithImpl;
  @useResult
  $Res call({BigInt amount, PublicKey accountKey, int withdrawHours});

  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class __$UnstakeCopyWithImpl<$Res> implements _$UnstakeCopyWith<$Res> {
  __$UnstakeCopyWithImpl(this._self, this._then);

  final _Unstake _self;
  final $Res Function(_Unstake) _then;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? accountKey = null,
    Object? withdrawHours = null,
  }) {
    return _then(_Unstake(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      accountKey: null == accountKey
          ? _self.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      withdrawHours: null == withdrawHours
          ? _self.withdrawHours
          : withdrawHours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_self.accountKey, (value) {
      return _then(_self.copyWith(accountKey: value));
    });
  }
}

/// @nodoc
mixin _$ActionStakingBlocState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ActionStakingBlocState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActionStakingBlocState()';
  }
}

/// @nodoc
class $ActionStakingBlocStateCopyWith<$Res> {
  $ActionStakingBlocStateCopyWith(
      ActionStakingBlocState _, $Res Function(ActionStakingBlocState) __);
}

/// @nodoc

class ActionStakingBlocStateNothing implements ActionStakingBlocState {
  const ActionStakingBlocStateNothing();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionStakingBlocStateNothing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActionStakingBlocState.nothing()';
  }
}

/// @nodoc

class ActionStakingBlocStateInProgress implements ActionStakingBlocState {
  const ActionStakingBlocStateInProgress();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionStakingBlocStateInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActionStakingBlocState.inProgress()';
  }
}

/// @nodoc

class ActionStakingBlocStateShowHowItWorks implements ActionStakingBlocState {
  const ActionStakingBlocStateShowHowItWorks();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionStakingBlocStateShowHowItWorks);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActionStakingBlocState.showHowItWorksSheet()';
  }
}

/// @nodoc

class ActionStakingBlocStateGoStake implements ActionStakingBlocState {
  const ActionStakingBlocStateGoStake(
      {required this.payload,
      required this.amount,
      required this.destination,
      required this.sender,
      required this.accountKey,
      required this.attachedFee});

  final String payload;
// amount in native tokens
  final BigInt amount;
  final Address destination;
  final Address sender;
  final PublicKey accountKey;
  final BigInt attachedFee;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActionStakingBlocStateGoStakeCopyWith<ActionStakingBlocStateGoStake>
      get copyWith => _$ActionStakingBlocStateGoStakeCopyWithImpl<
          ActionStakingBlocStateGoStake>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionStakingBlocStateGoStake &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.attachedFee, attachedFee) ||
                other.attachedFee == attachedFee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payload, amount, destination,
      sender, accountKey, attachedFee);

  @override
  String toString() {
    return 'ActionStakingBlocState.goStake(payload: $payload, amount: $amount, destination: $destination, sender: $sender, accountKey: $accountKey, attachedFee: $attachedFee)';
  }
}

/// @nodoc
abstract mixin class $ActionStakingBlocStateGoStakeCopyWith<$Res>
    implements $ActionStakingBlocStateCopyWith<$Res> {
  factory $ActionStakingBlocStateGoStakeCopyWith(
          ActionStakingBlocStateGoStake value,
          $Res Function(ActionStakingBlocStateGoStake) _then) =
      _$ActionStakingBlocStateGoStakeCopyWithImpl;
  @useResult
  $Res call(
      {String payload,
      BigInt amount,
      Address destination,
      Address sender,
      PublicKey accountKey,
      BigInt attachedFee});

  $AddressCopyWith<$Res> get destination;
  $AddressCopyWith<$Res> get sender;
  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class _$ActionStakingBlocStateGoStakeCopyWithImpl<$Res>
    implements $ActionStakingBlocStateGoStakeCopyWith<$Res> {
  _$ActionStakingBlocStateGoStakeCopyWithImpl(this._self, this._then);

  final ActionStakingBlocStateGoStake _self;
  final $Res Function(ActionStakingBlocStateGoStake) _then;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? payload = null,
    Object? amount = null,
    Object? destination = null,
    Object? sender = null,
    Object? accountKey = null,
    Object? attachedFee = null,
  }) {
    return _then(ActionStakingBlocStateGoStake(
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Address,
      accountKey: null == accountKey
          ? _self.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      attachedFee: null == attachedFee
          ? _self.attachedFee
          : attachedFee // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_self.destination, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get sender {
    return $AddressCopyWith<$Res>(_self.sender, (value) {
      return _then(_self.copyWith(sender: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_self.accountKey, (value) {
      return _then(_self.copyWith(accountKey: value));
    });
  }
}

/// @nodoc

class ActionStakingBlocStateGoUnstake implements ActionStakingBlocState {
  const ActionStakingBlocStateGoUnstake(
      {required this.payload,
      required this.amount,
      required this.destination,
      required this.sender,
      required this.accountKey,
      required this.attachedFee,
      required this.withdrawHours,
      required this.stakeContractAddress});

  final String payload;
// amount in staking tokens
  final BigInt amount;
  final Address destination;
  final Address sender;
  final PublicKey accountKey;
  final BigInt attachedFee;
  final int withdrawHours;
  final Address stakeContractAddress;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActionStakingBlocStateGoUnstakeCopyWith<ActionStakingBlocStateGoUnstake>
      get copyWith => _$ActionStakingBlocStateGoUnstakeCopyWithImpl<
          ActionStakingBlocStateGoUnstake>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionStakingBlocStateGoUnstake &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.attachedFee, attachedFee) ||
                other.attachedFee == attachedFee) &&
            (identical(other.withdrawHours, withdrawHours) ||
                other.withdrawHours == withdrawHours) &&
            (identical(other.stakeContractAddress, stakeContractAddress) ||
                other.stakeContractAddress == stakeContractAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payload, amount, destination,
      sender, accountKey, attachedFee, withdrawHours, stakeContractAddress);

  @override
  String toString() {
    return 'ActionStakingBlocState.goUnstake(payload: $payload, amount: $amount, destination: $destination, sender: $sender, accountKey: $accountKey, attachedFee: $attachedFee, withdrawHours: $withdrawHours, stakeContractAddress: $stakeContractAddress)';
  }
}

/// @nodoc
abstract mixin class $ActionStakingBlocStateGoUnstakeCopyWith<$Res>
    implements $ActionStakingBlocStateCopyWith<$Res> {
  factory $ActionStakingBlocStateGoUnstakeCopyWith(
          ActionStakingBlocStateGoUnstake value,
          $Res Function(ActionStakingBlocStateGoUnstake) _then) =
      _$ActionStakingBlocStateGoUnstakeCopyWithImpl;
  @useResult
  $Res call(
      {String payload,
      BigInt amount,
      Address destination,
      Address sender,
      PublicKey accountKey,
      BigInt attachedFee,
      int withdrawHours,
      Address stakeContractAddress});

  $AddressCopyWith<$Res> get destination;
  $AddressCopyWith<$Res> get sender;
  $PublicKeyCopyWith<$Res> get accountKey;
  $AddressCopyWith<$Res> get stakeContractAddress;
}

/// @nodoc
class _$ActionStakingBlocStateGoUnstakeCopyWithImpl<$Res>
    implements $ActionStakingBlocStateGoUnstakeCopyWith<$Res> {
  _$ActionStakingBlocStateGoUnstakeCopyWithImpl(this._self, this._then);

  final ActionStakingBlocStateGoUnstake _self;
  final $Res Function(ActionStakingBlocStateGoUnstake) _then;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? payload = null,
    Object? amount = null,
    Object? destination = null,
    Object? sender = null,
    Object? accountKey = null,
    Object? attachedFee = null,
    Object? withdrawHours = null,
    Object? stakeContractAddress = null,
  }) {
    return _then(ActionStakingBlocStateGoUnstake(
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Address,
      accountKey: null == accountKey
          ? _self.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      attachedFee: null == attachedFee
          ? _self.attachedFee
          : attachedFee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      withdrawHours: null == withdrawHours
          ? _self.withdrawHours
          : withdrawHours // ignore: cast_nullable_to_non_nullable
              as int,
      stakeContractAddress: null == stakeContractAddress
          ? _self.stakeContractAddress
          : stakeContractAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_self.destination, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get sender {
    return $AddressCopyWith<$Res>(_self.sender, (value) {
      return _then(_self.copyWith(sender: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_self.accountKey, (value) {
      return _then(_self.copyWith(accountKey: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get stakeContractAddress {
    return $AddressCopyWith<$Res>(_self.stakeContractAddress, (value) {
      return _then(_self.copyWith(stakeContractAddress: value));
    });
  }
}

// dart format on
