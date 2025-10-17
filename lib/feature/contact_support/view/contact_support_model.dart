import 'package:app/core/app_build_type.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/runner.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_logger/the_logger.dart';

@injectable
class ContactSupportModel extends ElementaryModel {
  ContactSupportModel(ErrorHandler errorHandler, this._messengerService)
    : super(errorHandler: errorHandler);

  static final _logger = Logger('ContactSupportModel');

  final MessengerService _messengerService;

  bool get isQaEnabled => currentAppBuildType != AppBuildType.production;

  Future<void> sendEmail(ContactSupportMode mode) async {
    late final String logFilePath;
    try {
      logFilePath = await _contactSupportCreateLogfile();
    } catch (e, s) {
      _logger.severe(e, null, s);
      _messengerService.show(
        Message.error(message: LocaleKeys.contactSupportCantCreateFile.tr()),
      );
      return;
    }

    try {
      await _contactSupportEmailSend(mode, logFilePath);
    } catch (e, s) {
      _logger.severe(e, null, s);
      _messengerService.show(
        Message.error(
          message: LocaleKeys.contactSupportCantFindEmailClient.tr(),
          actionText: LocaleKeys.contactSupportCantFindEmailClientShare.tr(),
          onAction: () => _contactSupportShareFile(logFilePath),
        ),
      );
    }
  }

  Future<String> _contactSupportCreateLogfile() async {
    final now = NtpTime.now().toLocal().toString().replaceAll(
      RegExp(r'\s'),
      '_',
    );

    return TheLogger.i().writeAllLogsToJson('sparx_logs_$now.json');
  }

  Future<void> _contactSupportEmailSend(
    ContactSupportMode mode,
    String logFilePath,
  ) async {
    final to = switch (mode) {
      ContactSupportMode.initiatedByUser =>
        LocaleKeys.contactSupportEmailToInitiatedByUser.tr(),
      ContactSupportMode.initiatedByCrash =>
        LocaleKeys.contactSupportEmailToInitiatedByUser.tr(),
    };

    final subject = switch (mode) {
      ContactSupportMode.initiatedByUser =>
        LocaleKeys.contactSupportEmailSubjectInitiatedByUser.tr(),
      ContactSupportMode.initiatedByCrash =>
        LocaleKeys.contactSupportEmailSubjectInitiatedByUser.tr(),
    };

    final body = switch (mode) {
      ContactSupportMode.initiatedByUser =>
        LocaleKeys.contactSupportEmailBodyInitiatedByUser.tr(),
      ContactSupportMode.initiatedByCrash =>
        LocaleKeys.contactSupportEmailBodyInitiatedByUser.tr(),
    };

    final email = Email(
      subject: subject,
      recipients: [to],
      body: body,
      attachmentPaths: [logFilePath],
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> _contactSupportShareFile(String logFilePath) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(logFilePath)]));
  }
}
