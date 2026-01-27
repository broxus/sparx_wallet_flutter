import 'dart:convert';
import 'dart:typed_data';

import 'package:app/feature/ton_connect/domain/response_body_to_sse_message_transformer.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseBodyToSseMessageTransformer', () {
    test('parses single SSE event with id, event, and data', () async {
      // Arrange
      final transformer = ResponseBodyToSseMessageTransformer();
      final raw = const Utf8Encoder().convert(
        'id: 1\n'
        'event: update\n'
        'data: hello world\n\n',
      );
      final stream = Stream<Uint8List>.fromIterable([Uint8List.fromList(raw)]);

      // Act
      final messages = await stream.transform(transformer).toList();

      // Assert
      expect(messages, hasLength(1));
      final message = messages.first;
      expect(message.id, '1');
      expect(message.event, 'update');
      expect(message.data, 'hello world');
    });

    test('ignores comment lines and emits multiple events', () async {
      // Arrange
      final transformer = ResponseBodyToSseMessageTransformer();
      final raw = const Utf8Encoder().convert(
        ':comment\n'
        'event: first\n'
        'data: payload 1\n\n'
        'id: 2\n'
        'data: payload 2\n\n',
      );
      final chunks = <Uint8List>[
        Uint8List.fromList(raw.sublist(0, 30)),
        Uint8List.fromList(raw.sublist(30)),
      ];
      final stream = Stream<Uint8List>.fromIterable(chunks);

      // Act
      final messages = await stream.transform(transformer).toList();

      // Assert
      expect(messages, hasLength(2));
      expect(messages[0].event, 'first');
      expect(messages[0].data, 'payload 1');
      expect(messages[1].id, '2');
      expect(messages[1].data, 'payload 2');
    });
  });
}
