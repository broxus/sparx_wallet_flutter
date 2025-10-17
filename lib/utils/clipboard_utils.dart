import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

final _clipboardLogger = Logger('UtilsLogger');

Future<ClipboardData?> getClipBoardData() async {
  try {
    return await Clipboard.getData(Clipboard.kTextPlain);
  } catch (e, s) {
    _clipboardLogger.finest('ClipboardUtils error', e, s);
    return null;
  }
}

Future<String?> getClipBoardText() async {
  return (await getClipBoardData())?.text;
}

Future<void> setClipBoardData(String text) async {
  try {
    await Clipboard.setData(ClipboardData(text: text));
  } catch (_) {}
}

Future<bool> checkExistClipBoardData() async {
  try {
    return await Clipboard.hasStrings();
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
    return false;
  }
}
