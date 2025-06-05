import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu.dart';
import 'package:flutter/cupertino.dart';

class BrowserGroupMenuUiDelegate {
  Future<void> showMenu(BuildContext context) {
    return showBrowserTabMenu(context);
  }
}
