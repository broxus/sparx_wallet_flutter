import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';

abstract interface class BrowserPastGoUi {
  ListenableState<bool> get showPastGoState;

  Future<void> onPastGoPressed();
}

class BrowserPastGoUiDelegate implements BrowserPastGoUi {
  BrowserPastGoUiDelegate(this._model);

  final BrowserMainScreenModel _model;

  late final _showPastGoState = StateNotifier<bool>(initValue: true);

  @override
  ListenableState<bool> get showPastGoState => _showPastGoState;

  void dispose() {
    _showPastGoState.dispose();
  }

  @override
  Future<void> onPastGoPressed() async {
    final text = await getClipBoardText();
    if (text == null) {
      return;
    }

    _model.requestUrl(_model.activeTabId, text);
  }

  //activeTabUrlHostState

  // ignore: avoid_positional_boolean_parameters
  void updateVisible(bool isView) {
    _showPastGoState.accept(isView);
  }
}
