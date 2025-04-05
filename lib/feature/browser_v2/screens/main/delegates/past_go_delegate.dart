import 'package:app/utils/clipboard_utils.dart';
import 'package:flutter/cupertino.dart';

class BrowserPastGoDelegate {
  Future<void> onPastGoPressed({
    required ValueChanged<String> onSuccess,
  }) async {
    final text = await getClipBoardText();
    if (text == null) {
      return;
    }

    onSuccess(text);
  }
}
