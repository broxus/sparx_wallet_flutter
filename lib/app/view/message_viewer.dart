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
    required this.clearQueue,
  });

  Stream<List<Message>> messagesStream;
  BuildContext? Function() getRootContext;
  VoidCallback clearQueue;
  Timer? _messageTimer;

  StreamSubscription<List<Message>>? _messagesSubscription;

  var _messages = <Message>[];
  bool _isRunShowMessages = false;

  void init() {
    _messagesSubscription = messagesStream.listen(_handleMessages);
  }

  void dispose() {
    _messagesSubscription?.cancel();
  }

  Future<void> _handleMessages(List<Message> messages) async {
    _messages = messages;
    if (_messages.isEmpty) {
      _messageTimer?.cancel();
      _isRunShowMessages = false;
    } else if (_isRunShowMessages) {
      _messages = messages;
    } else {
      _isRunShowMessages = true;
      _show(0);
    }
  }

  void _show(int index) {
    final rootContext = getRootContext();
    if (rootContext == null || index >= _messages.length) {
      _clearQueue();
      return;
    }

    final message = _messages[index];

    Future.delayed(const Duration(milliseconds: 200), () async {
      InAppNotification.show(
        child: ToastMessage.fromMessage(
          message,
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          onPressedAction: () {
            message.onAction?.call();
            _dismiss(index);
          },
          onTapClosed: () => _dismiss(index),
        ),
        // ignore: use_build_context_synchronously
        context: rootContext,
        onTap: () => _dismiss(index),
        duration: message.duration,
      );
      _messageTimer = Timer(message.duration, () {
        _show(index + 1);
        _messageTimer?.cancel();
      });
    });
  }

  Future<void> _dismiss([int? index]) async {
    _messageTimer?.cancel();
    final rootContext = getRootContext();
    if (rootContext == null) {
      return;
    }

    try {
      await InAppNotification.dismiss(context: rootContext);
    } catch (_) {}
    if (index != null) {
      _show(index + 1);
    }
  }

  void _clearQueue() {
    _isRunShowMessages = false;
    clearQueue();
  }
}
