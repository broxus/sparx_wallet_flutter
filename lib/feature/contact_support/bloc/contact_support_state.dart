part of 'contact_support_bloc.dart';

@freezed
abstract class ContactSupportState with _$ContactSupportState {
  const factory ContactSupportState({
    required bool isBusy,
    required bool isQaEnabled,
  }) = _ContactSupportState;
}
