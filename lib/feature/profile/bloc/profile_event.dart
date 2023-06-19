part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  /// Init all subscriptions
  const factory ProfileEvent.init() = _Initialize;

  /// Clear all sensitive data and navigate to onboarding screen
  const factory ProfileEvent.logOut() = _LogOut;

  /// This is internal event to update data reacting for some subscription
  const factory ProfileEvent.updateData(Seed? currentSeed) = _UpdateData;

  /// Export seed phrase with early entered password.
  /// This means, that user want to export current seed (from currentKey)
  const factory ProfileEvent.exportSeed(String password) = _ExportSeed;
}
