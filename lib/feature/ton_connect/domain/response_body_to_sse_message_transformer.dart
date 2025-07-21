import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:app/feature/ton_connect/ton_connect.dart';

StreamTransformer<Uint8List, List<int>> _unit8Transformer =
    StreamTransformer.fromHandlers(
  handleData: (data, sink) => sink.add(List<int>.from(data)),
);

class ResponseBodyToSseMessageTransformer
    implements StreamTransformer<Uint8List, SseMessage> {
  @override
  Stream<SseMessage> bind(Stream<Uint8List> stream) {
    late StreamController<SseMessage> controller;
    StreamSubscription<String>? subscription;

    controller = StreamController(
      onListen: () {
        final listener = _MessageListener(controller);
        // This stream will receive chunks of data that is not necessarily a
        // single event. So we build events on the fly and broadcast the event
        // as soon as we encounter a double newline, then we start a new one.
        subscription = stream
            .transform(_unit8Transformer)
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .listen(
              listener.onData,
              onError: (Object e, StackTrace s) => controller.addError(e, s),
              onDone: () => controller.close(),
            );
      },
      onCancel: () {
        subscription?.cancel();
      },
    );

    return controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() =>
      StreamTransformer.castFrom<Uint8List, SseMessage, RS, RT>(this);
}

class _MessageListener {
  _MessageListener(this._controller);

  final StreamController<SseMessage> _controller;

  final _lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
  final _removeEndingNewlineRegex = RegExp(r'^((?:.|\n)*)\n$');

  // the event we are currently building
  var _currentEvent = SseMessage();

  void onData(String line) {
    if (line.isEmpty) {
      // event is done
      // strip ending newline from data
      if (_currentEvent.data != null) {
        final match =
            _removeEndingNewlineRegex.firstMatch(_currentEvent.data!)!;
        _currentEvent.data = match.group(1);
      }

      if (!_currentEvent.isEmpty) {
        _controller.add(_currentEvent);
      }

      _currentEvent = SseMessage();
      return;
    }
    // match the line prefix and the value using the regex
    final match = _lineRegex.firstMatch(line)!;
    final field = match.group(1)!;
    final value = match.group(2) ?? '';

    if (field.isEmpty) {
      // lines starting with a colon are to be ignored
      return;
    }

    switch (field) {
      case 'event':
        _currentEvent.event = value;
      case 'data':
        _currentEvent.data = '${_currentEvent.data ?? ''}$value\n';
      case 'id':
        _currentEvent.id = value;
    }
  }
}
