import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/app/service/ton_connect/session_crypto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class TonConnectService {
  final _client = http.Client();
  final _bridgeUrl = 'https://bridge.tonapi.io/bridge';
  final _sessionCrypto = SessionCrypto();

  var _eventId = 1;
  num get eventId => _eventId++;

  void connect(ConnectQuery query) {
    final uri = Uri.parse(
      '$_bridgeUrl/events?client_id=${query.id}',
    );
    final request = http.Request('GET', uri)
      ..headers['Accept'] = 'text/event-stream';

    _client
        .send(request)
        .then((response) => response.stream.transform(EventSourceTransformer()))
        .then((stream) {
      stream.listen((event) {
        if (event.event == 'heartbeat') return;
        print(event);
      });
    });

    // final response = {
    //   'id': eventId,
    //   'event': 'connect',
    //   'payload':
    // };
    http.post(
      Uri.parse(
        '$_bridgeUrl/message?client_id=${_sessionCrypto.sessionId}&to=${query.id}&ttl=300',
      ),
      // body:
    );
  }

  void send({
    required String clientId,
    required String method,
    required Map<String, dynamic> params,
    num? ttl = 300,
  }) {
    final uri = Uri.parse(
      '$_bridgeUrl/message?client_id=${_sessionCrypto.sessionId}&to=$clientId&ttl=$ttl',
    );
    final request = http.Request('POST', uri)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'method': method,
        'params': params,
      });

    _client.send(request).then((response) {
      if (response.statusCode != 200) {
        throw Exception('Failed to send request');
      }
    });
  }

  String _getLastEventId() => throw UnimplementedError();

  String _saveLastEventId() => throw UnimplementedError();
}

class EventSourceTransformer
    implements StreamTransformer<List<int>, SseMessage> {
  @override
  Stream<SseMessage> bind(Stream<List<int>> stream) {
    late StreamController<SseMessage> controller;
    controller = StreamController(
      onListen: () {
        // the event we are currently building
        var currentEvent = SseMessage();
        // the regexes we will use later
        final lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
        final removeEndingNewlineRegex = RegExp(r'^((?:.|\n)*)\n$');
        // This stream will receive chunks of data that is not necessarily a
        // single event. So we build events on the fly and broadcast the event as
        // soon as we encounter a double newline, then we start a new one.
        stream
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .listen((String line) {
          if (line.isEmpty) {
            // event is done
            // strip ending newline from data
            if (currentEvent.data != null) {
              final match =
                  removeEndingNewlineRegex.firstMatch(currentEvent.data!)!;
              currentEvent.data = match.group(1);
            }
            controller.add(currentEvent);
            currentEvent = SseMessage();
            return;
          }
          // match the line prefix and the value using the regex
          final match = lineRegex.firstMatch(line)!;
          final field = match.group(1)!;
          final value = match.group(2) ?? '';

          if (field.isEmpty) {
            // lines starting with a colon are to be ignored
            return;
          }

          switch (field) {
            case 'event':
              currentEvent.event = value;
              break;
            case 'data':
              currentEvent.data = '${currentEvent.data ?? ''}$value\n';
              break;
            case 'id':
              currentEvent.id = value;
              break;
          }
        });
      },
    );
    return controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() =>
      StreamTransformer.castFrom<List<int>, SseMessage, RS, RT>(this);
}
