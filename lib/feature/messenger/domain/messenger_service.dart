import 'dart:async';
import 'dart:collection';

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

/// Service that shows messages to the user. Keep it simple and stupid, use only
/// as stream sources for blocs and cubits that actual provide messages to the
/// user.
@lazySingleton
class MessengerService {
  final _messages = ListQueue<Message>();

  final _messagesExistSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get messagesExistStream => _messagesExistSubject.stream;

  @disposeMethod
  void dispose() {
    _messagesExistSubject.close();
  }

  void show(Message message) {
    _messages.add(message);
    _messagesExistSubject.add(true);
  }

  void showError(String message) {
    return show(Message.error(message: message));
  }

  void showConnectionError() {
    show(Message.error(message: LocaleKeys.connectingNetworkFailed.tr()));
  }

  Message? takeMessage() {
    final message = _removeFirstSafe();

    if (_messages.isEmpty) {
      _messagesExistSubject.add(false);
    }

    return message;
  }

  Message? _removeFirstSafe() {
    return _messages.isEmpty ? null : _messages.removeFirst();
  }
}
