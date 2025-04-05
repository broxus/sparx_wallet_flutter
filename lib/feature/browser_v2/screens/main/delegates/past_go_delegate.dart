import 'package:app/utils/clipboard_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class BrowserPastGoDelegate {
  late final _showPastGoState = StateNotifier<bool>(initValue: true);

  ListenableState<bool> get showPastGoState => _showPastGoState;

  void dispose() {
    _showPastGoState.dispose();
  }

  Future<void> onPastGoPressed({
    required ValueChanged<String> onSuccess,
  }) async {
    final text = await getClipBoardText();
    if (text == null) {
      return;
    }

    onSuccess(text);
  }

  void updateVisible(bool isView) {
    _showPastGoState.accept(isView);
  }
}
