import 'dart:async';

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:test/test.dart';

void main() {
  final message0 = Message(
    message: 'message0',
    type: MessageType.info,
  );
  final message1 = Message(
    message: 'message1',
    type: MessageType.info,
  );

  Future<void> delay() => Future.delayed(const Duration(milliseconds: 10));

  group('MessengerService - messagesExistStream', () {
    late MessengerService messengerService;

    setUp(() {
      messengerService = MessengerService();
    });

    tearDown(() {
      messengerService.dispose();
    });

    test('initial state is false', () async {
      final events = <bool>[];
      final sub = messengerService.messagesExistStream.listen(events.add);
      await delay();
      expect(events, equals([false]));
      await sub.cancel();
    });

    test('emits false then true when one message is added', () async {
      final events = <bool>[];
      final sub = messengerService.messagesExistStream.listen(events.add);
      await delay();
      messengerService.show(message0);
      await delay();
      expect(events, equals([false, true]));
      await sub.cancel();
    });

    test('emits false, true, then false when message is taken', () async {
      final events = <bool>[];
      final sub = messengerService.messagesExistStream.listen(events.add);
      await delay();
      messengerService.show(message0);
      await delay();
      expect(events.last, true);
      messengerService.takeMessage();
      await delay();
      expect(events, equals([false, true, false]));
      await sub.cancel();
    });
  });

  group('MessengerService - queue (takeMessage)', () {
    late MessengerService messengerService;

    setUp(() {
      messengerService = MessengerService();
    });

    tearDown(() {
      messengerService.dispose();
    });

    test('queue is empty initially', () {
      expect(messengerService.takeMessage(), isNull);
    });

    test('queue contains [message0] when one message is added', () {
      messengerService.show(message0);
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), isNull);
    });

    test(
        'queue contains [message0, message0] '
        'when two identical messages are added', () {
      messengerService
        ..show(message0)
        ..show(message0);
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), isNull);
    });

    test(
        'queue contains [message0, message1] '
        'when message0 then message1 are added', () {
      messengerService
        ..show(message0)
        ..show(message1);
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), equals(message1));
      expect(messengerService.takeMessage(), isNull);
    });

    test(
        'queue contains [message0, message1, message0] '
        'when message0, message1, then message0 are added', () {
      messengerService
        ..show(message0)
        ..show(message1)
        ..show(message0);
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), equals(message1));
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), isNull);
    });

    test(
        'queue contains [message0, message0, message1] '
        'when message0, message0, then message1 are added', () {
      messengerService
        ..show(message0)
        ..show(message0)
        ..show(message1);
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), equals(message0));
      expect(messengerService.takeMessage(), equals(message1));
      expect(messengerService.takeMessage(), isNull);
    });
  });
}
