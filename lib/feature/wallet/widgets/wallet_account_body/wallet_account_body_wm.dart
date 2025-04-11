import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum NotificationType {
  backup,
  unsupportedWalletType,
}

WalletAccountBodyWidgetModel defaultWalletAccountBodyWidgetModelFactory(
  BuildContext context,
) =>
    WalletAccountBodyWidgetModel(
      WalletAccountBodyModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class WalletAccountBodyWidgetModel
    extends CustomWidgetModel<WalletAccountBodyWidget, WalletAccountBodyModel> {
  WalletAccountBodyWidgetModel(super.model);

  late final _notifications = createNotifierFromStream(_notificationsStream);

  late final _carouselPage = createValueNotifier(0);

  ListenableState<List<NotificationType>> get notifications => _notifications;

  ValueListenable<int> get carouselPage => _carouselPage;

  Stream<List<NotificationType>> get _notificationsStream => Rx.combineLatest2(
        model.getIsUnsupportedWalletTypeStram(widget.account),
        model.getShowingManualBackupBadgeStream(widget.account),
        (bool isUnsupportedWalletType, bool isShowingBackup) =>
            <NotificationType>[
          if (isUnsupportedWalletType) NotificationType.unsupportedWalletType,
          if (isShowingBackup) NotificationType.backup,
        ],
      );

  void onFinishedBackup() => model.hideBackupNotification(widget.account);

  void onSwitchAccount() => showSelectAccountSheet(context);

  void onPageChanged(int index, CarouselPageChangedReason _) =>
      _carouselPage.value = index;
}
