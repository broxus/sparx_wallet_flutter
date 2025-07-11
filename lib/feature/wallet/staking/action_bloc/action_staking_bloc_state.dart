part of 'action_staking_bloc.dart';

@freezed
sealed class ActionStakingBlocState with _$ActionStakingBlocState {
  /// no any action in progress
  const factory ActionStakingBlocState.nothing() =
      ActionStakingBlocStateNothing;

  /// Means loading indicator should be displayed
  const factory ActionStakingBlocState.inProgress() =
      ActionStakingBlocStateInProgress;

  /// Show sheet describing staking mechanism
  const factory ActionStakingBlocState.showHowItWorksSheet() =
      ActionStakingBlocStateShowHowItWorks;

  /// Navigate to stake confirm transaction in ui
  const factory ActionStakingBlocState.goStake({
    required String payload,
    // amount in native tokens
    required BigInt amount,
    required Address destination,
    required Address sender,
    required PublicKey accountKey,
    required BigInt attachedFee,
  }) = ActionStakingBlocStateGoStake;

  /// Navigate to stake confirm transaction in ui
  const factory ActionStakingBlocState.goUnstake({
    required String payload,
    // amount in staking tokens
    required BigInt amount,
    required Address destination,
    required Address sender,
    required PublicKey accountKey,
    required BigInt attachedFee,
    required int withdrawHours,
    required Address stakeContractAddress,
  }) = ActionStakingBlocStateGoUnstake;
}
