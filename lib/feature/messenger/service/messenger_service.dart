import 'dart:async';

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

/// Service that shows messages to the user. Keep it simple and stupid, use only
/// as stream sources for blocs and cubits that actual provide messages to the
/// user.
@singleton
class MessengerService {
  final _messagesSubject = BehaviorSubject<List<Message>>.seeded([]);

  Stream<List<Message>> get messagesStream => _messagesSubject.stream;

  List<Message> get _messages => _messagesSubject.value;

  @disposeMethod
  void dispose() {
    _messagesSubject.close();
  }

  void show(Message message) {
    _messagesSubject.add([..._messages, message]);
  }

  void showError(BuildContext context, String message) {
    return show(
      Message.error(
        message: message,
      ),
    );
  }

  void showConnectionError(BuildContext? context) {
    show(
      Message.error(
        message: LocaleKeys.connectingNetworkFailed.tr(),
      ),
    );
  }

  void clearQueue() {
    if (_messages.isEmpty) {
      return;
    }
    _messagesSubject.add([]);
  }
}
