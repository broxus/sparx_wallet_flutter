import 'dart:async';

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/widget/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class MessageViewer {
  MessageViewer({
    required this.messagesStream,
    required this.getRootContext,
    required this.dismissMessage,
  });

  Stream<List<Message>> messagesStream;
  BuildContext? Function() getRootContext;
  VoidCallback dismissMessage;

  StreamSubscription<List<Message>>? _messagesSubscription;

  String? _activeMessageId;

  void init() {
    _messagesSubscription = messagesStream.listen(_handleMessages);
  }

  void dispose() {
    _messagesSubscription?.cancel();
  }

  Future<void> _handleMessages(List<Message> messages) async {
    if (messages.isEmpty) {
      await _dismiss();
      return;
    }

    final message = messages.firstOrNull;

    if (message == null || _activeMessageId == message.id) {
      return;
    }

    await _dismiss();
    _show(message);
  }

  void _show(Message message) {
    final rootContext = getRootContext();
    if (rootContext == null) {
      return;
    }

    _activeMessageId = message.id;

    Future.delayed(const Duration(milliseconds: 200), () {
      InAppNotification.show(
        child: ToastMessage.fromMessage(
          message,
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          onPressedAction: () {
            message.onAction?.call();
            _dismiss();
          },
          onTapClosed: _dismiss,
        ),
        // ignore: use_build_context_synchronously
        context: rootContext,
        onTap: _dismiss,
        duration: message.duration,
      );
    });
  }

  Future<void> _dismiss() async {
    final rootContext = getRootContext();
    if (rootContext == null) {
      return;
    }

    _activeMessageId = null;

    try {
      await InAppNotification.dismiss(context: rootContext);
      dismissMessage();
    } catch (_) {
      return;
    }
  }
}
