part of 'change_seed_password_cubit.dart';

@freezed
sealed class ChangeSeedPasswordState with _$ChangeSeedPasswordState {
  /// Default state
  const factory ChangeSeedPasswordState.initial() =
      ChangeSeedPasswordStateInitial;

  /// Show error to user
  const factory ChangeSeedPasswordState.error(String errorCode) =
      ChangeSeedPasswordStateError;

  /// Password changed, close sheet
  const factory ChangeSeedPasswordState.completed() =
      ChangeSeedPasswordStateCompleted;
}
