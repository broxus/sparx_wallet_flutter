part of 'contact_support_bloc.dart';

@freezed
sealed class ContactSupportEvent with _$ContactSupportEvent {
  const factory ContactSupportEvent.sendEmail(ContactSupportMode mode) =
      _SendEmail;
  const factory ContactSupportEvent.openQaScreen() = _OpenQaScreen;
}
