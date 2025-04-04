// ignore_for_file: avoid_print

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/service/messenger_service.dart';
import 'package:test/test.dart';

void main() {
  Future<void> delay() {
    return Future.delayed(const Duration(milliseconds: 10), () {});
  }

  final message0 = Message(
    message: 'message0',
    type: MessageType.info,
  );
  final message1 = Message(
    message: 'message1',
    type: MessageType.info,
  );

  group('MessengerService', () {
    late MessengerService messengerService;

    setUp(() {
      messengerService = MessengerService();
    });

    tearDown(() {
      messengerService.dispose();
    });

    test('initial state is correct', () async {
      final events = <List<Message>>[];
      final sub = messengerService.messagesStream.listen(events.add);
      await delay();
      expect(
        events,
        equals([<Message>[]]),
      );
      await sub.cancel();
    });

    test('emits [message0] when one message is added', () async {
      final events = <List<Message>>[];
      final sub = messengerService.messagesStream.listen(events.add);
      await delay();
      messengerService.show(message0);
      await delay();
      expect(
        events,
        equals([
          <Message>[],
          [message0],
        ]),
      );
      await sub.cancel();
    });

    test('emits [message0, message0] when two identical messages are added',
        () async {
      final events = <List<Message>>[];
      final sub = messengerService.messagesStream.listen(events.add);
      await delay();
      messengerService
        ..show(message0)
        ..show(message0);
      await delay();
      expect(
        events,
        equals([
          <Message>[],
          [message0],
          [message0, message0],
        ]),
      );
      await sub.cancel();
    });

    test('emits [message0, message1] when message0 then message1 are added',
        () async {
      final events = <List<Message>>[];
      final sub = messengerService.messagesStream.listen(events.add);
      await delay();
      messengerService
        ..show(message0)
        ..show(message1);
      await delay();
      expect(
        events,
        equals([
          <Message>[],
          [message0],
          [message0, message1],
        ]),
      );
      await sub.cancel();
    });

    test(
        'emits [message0, message1, message0] when message0, message1, '
        'then message0 are added', () async {
      final events = <List<Message>>[];
      final sub = messengerService.messagesStream.listen(events.add);
      await delay();
      messengerService
        ..show(message0)
        ..show(message1)
        ..show(message0);
      await delay();
      expect(
        events,
        equals([
          <Message>[],
          [message0],
          [message0, message1],
          [message0, message1, message0],
        ]),
      );
      await sub.cancel();
    });

    test(
        'emits [message0, message0, message1] when message0, message0, '
        'then message1 are added', () async {
      final events = <List<Message>>[];
      final sub = messengerService.messagesStream.listen(events.add);
      await delay();
      messengerService
        ..show(message0)
        ..show(message0)
        ..show(message1);
      await delay();
      expect(
        events,
        equals([
          <Message>[],
          [message0],
          [message0, message0],
          [message0, message0, message1],
        ]),
      );
      await sub.cancel();
    });
  });
}
