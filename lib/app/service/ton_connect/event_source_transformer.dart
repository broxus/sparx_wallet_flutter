import 'dart:async';
import 'dart:convert';
import 'package:app/app/service/ton_connect/models/models.dart';

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
