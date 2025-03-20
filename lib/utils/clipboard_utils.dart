import 'package:flutter/services.dart';

Future<ClipboardData?> getClipBoardData() async {
  return Clipboard.getData(Clipboard.kTextPlain);
}

Future<String?> getClipBoardText() async {
  return (await getClipBoardData())?.text;
}

Future<void> setClipBoardData(String text) async {
  try {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  } catch (_) {}
}
