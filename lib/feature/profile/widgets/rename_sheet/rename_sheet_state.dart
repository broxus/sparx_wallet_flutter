part of 'rename_sheet_cubit.dart';

@freezed
sealed class RenameSheetState with _$RenameSheetState {
  /// State displays loading indicator
  const factory RenameSheetState.loading() = RenameSheetStateLoading;

  /// State displays nothing, default state
  const factory RenameSheetState.init() = RenameSheetStateInit;

  /// State displays nothing, should be closed sheet and display snackbar.
  /// [isSeed] means snackbar should contains text 'Seed renamed'.
  const factory RenameSheetState.completed({
    required bool isSeed,
  }) = RenameSheetStateCompleted;
}
