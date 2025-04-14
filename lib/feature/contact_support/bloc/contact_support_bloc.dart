//iignore_for_file: use_build_context_synchronously

import 'package:app/app/service/messenger/messenger.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/feature/qa/view/qa_page.dart';
import 'package:app/generated/generated.dart';
import 'package:app/runner.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'contact_support_bloc.freezed.dart';

part 'contact_support_event.dart';

part 'contact_support_state.dart';

class ContactSupportBloc extends Bloc<ContactSupportEvent, ContactSupportState>
    with BlocBaseMixin {
  ContactSupportBloc(this.context)
      : super(
          ContactSupportState(
            isBusy: false,
            isQaEnabled: currentAppBuildType == AppBuildType.development,
          ),
        ) {
    on<ContactSupportEvent>((event, emit) async {
      await event.map(
        sendEmail: (event) async {
          emitSafe(state.copyWith(isBusy: true));
          String? logFilePath;
          try {
            logFilePath = await contactSupportCreateLogfile();
          } catch (e, s) {
            _log.severe(e, null, s);
            emitSafe(state.copyWith(isBusy: false));
            inject<MessengerService>().show(
              Message.error(
                message: LocaleKeys.contactSupportCantCreateFile.tr(),
              ),
            );
          }

          if (logFilePath != null) {
            try {
              await contactSupportEmailSend(event.mode, logFilePath);
            } catch (e, s) {
              _log.severe(e, null, s);
              emitSafe(state.copyWith(isBusy: false));
              inject<MessengerService>().show(
                Message.error(
                  message: LocaleKeys.contactSupportCantFindEmailClient.tr(),
                  actionText:
                      LocaleKeys.contactSupportCantFindEmailClientShare.tr(),
                  onAction: () => contactSupportShareFile(logFilePath!),
                ),
              );
            }
          }

          emitSafe(state.copyWith(isBusy: false));
        },
        openQaScreen: (event) async {
          await showQaSheet(context: context);
        },
      );
    });
  }

  final BuildContext context;
  final _log = Logger('ContactSupportBloc');
}
