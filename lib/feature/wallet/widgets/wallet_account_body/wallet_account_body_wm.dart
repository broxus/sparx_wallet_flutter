import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/utils/common_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

enum NotificationType {
  backup,
  unsupportedWalletType,
}

WalletAccountBodyWidgetModel defaultWalletAccountBodyWidgetModelFactory(
  BuildContext context,
) {
  return WalletAccountBodyWidgetModel(
    WalletAccountBodyModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

class WalletAccountBodyWidgetModel
    extends CustomWidgetModel<WalletAccountBodyWidget, WalletAccountBodyModel> {
  WalletAccountBodyWidgetModel(super.model);

  late final ListenableState<KeyAccount> keyAccount = createWidgetProperty(
    (w) => w.account,
  );

  late final _notifications = createNotifierFromStream(_notificationsStream);

  late final _carouselPage = createValueNotifier(0);

  ListenableState<List<NotificationType>> get notifications => _notifications;

  ValueListenable<int> get carouselPage => _carouselPage;

  Stream<List<NotificationType>> get _notificationsStream {
    return keyAccount.asStream().whereNotNull().flatMap((account) {
      return Rx.combineLatest2(
        model.getIsUnsupportedWalletTypeStram(account),
        model.getShowingManualBackupBadgeStream(account),
        (bool isUnsupportedWalletType, bool isShowingBackup) =>
            <NotificationType>[
          if (isUnsupportedWalletType) NotificationType.unsupportedWalletType,
          if (isShowingBackup) NotificationType.backup,
        ],
      );
    });
  }

  // ignore: avoid_positional_boolean_parameters
  void onFinishedBackup(bool isCompleted) {
    keyAccount.value?.let(
      (KeyAccount account) => model.hideBackupNotification(
        account,
        isCompleted: isCompleted,
      ),
    );
  }

  void onSwitchAccount() => showSelectAccountSheet(context);

  void onPageChanged(int index, CarouselPageChangedReason _) =>
      _carouselPage.value = index;
}
