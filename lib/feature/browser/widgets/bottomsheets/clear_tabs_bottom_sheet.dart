import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

Future<bool?> showBrowserClearTabsSheet({required BuildContext context}) =>
    showConfirmationSheet(
      context: context,
      confirmationText: LocaleKeys.browserCloseAllTabsDescription.tr(),
      confirmButtonTitle: LocaleKeys.clearAll.tr(),
    );
