import 'dart:async';

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/widget/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class MessageViewer {
  MessageViewer({
    required this.messagesExistStream,
    required this.getRootContext,
    required this.getMessage,
  });

  Stream<bool> messagesExistStream;
  BuildContext? Function() getRootContext;
  Message? Function() getMessage;
  Timer? _messageTimer;

  StreamSubscription<bool>? _messagesSubscription;

  bool _isRunShowMessages = false;

  void init() {
    _messagesSubscription = messagesExistStream.listen(_handleMessages);
  }

  void dispose() {
    _messagesSubscription?.cancel();
  }

  Future<void> _handleMessages(bool isReadyMessage) async {
    if (!isReadyMessage || _isRunShowMessages) {
      return;
    }
    _isRunShowMessages = true;
    _show();
  }

  void _show() {
    final rootContext = getRootContext();
    if (rootContext == null) {
      _stop();
      return;
    }

    final message = getMessage();

    if (message == null) {
      _isRunShowMessages = false;
      return;
    }

    Future.delayed(const Duration(milliseconds: 200), () async {
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
      _messageTimer = Timer(message.duration, () {
        _messageTimer?.cancel();
        _show();
      });
    });
  }

  Future<void> _dismiss() async {
    _messageTimer?.cancel();
    final rootContext = getRootContext();
    if (rootContext == null) {
      return;
    }

    try {
      await InAppNotification.dismiss(context: rootContext);
    } catch (_) {}
    _show();
  }

  void _stop() {
    _messageTimer?.cancel();
    _isRunShowMessages = false;
  }
}
