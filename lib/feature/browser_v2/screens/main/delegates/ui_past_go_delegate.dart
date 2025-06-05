import 'package:app/utils/clipboard_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

abstract interface class BrowserPastGoUi {
  ListenableState<bool> get showPastGoState;
}

class BrowserPastGoUiDelegate implements BrowserPastGoUi {
  late final _showPastGoState = StateNotifier<bool>(initValue: true);

  @override
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

  // ignore: avoid_positional_boolean_parameters
  void updateVisible(bool isView) {
    _showPastGoState.accept(isView);
  }
}
