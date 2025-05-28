import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu.dart';
import 'package:flutter/cupertino.dart';

// ignore: one_member_abstracts
// abstract interface class BrowserGroupMenuUi {
//   Future<void> showMenu(BuildContext context);
// }

class BrowserGroupMenuDelegate // implements BrowserGroupMenuUi
{
  // @override
  Future<void> showMenu(BuildContext context) {
    return showBrowserTabMenu(context);
  }
}
