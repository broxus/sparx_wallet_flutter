import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
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

const _walletV5R1 = WalletType.walletV5R1();

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

  late final _isUnsupportedWalletTypeStram = model.transport.map(
    (transport) =>
        (transport.isEverscale || transport.isVenom) &&
        widget.account.account.tonWallet.contract == _walletV5R1,
  );

  late final _isShowingBackupStream = model
      .getValueStream<bool>(
        StorageKey.showingManualBackupBadge(
          model.getMasterPublicKey(widget.account).publicKey,
        ),
      )
      .map((isShowingBackup) => isShowingBackup ?? true);

  late final _notificationsStream = Rx.combineLatest2(
    _isUnsupportedWalletTypeStram,
    _isShowingBackupStream,
    (bool isUnsupportedWalletType, bool isShowingBackup) => <NotificationType>[
      if (isUnsupportedWalletType) NotificationType.unsupportedWalletType,
      if (isShowingBackup) NotificationType.backup,
    ],
  );

  late final _notifications = createNotifierFromStream(_notificationsStream);

  late final _carouselPage = createValueNotifier(0);

  ListenableState<List<NotificationType>> get notifications => _notifications;

  ValueListenable<int> get carouselPage => _carouselPage;

  void onFinishedBackup() => model.hideBackupNotification(widget.account);

  void onSwitchAccount() => showSelectAccountSheet(context);

  void onPageChanged(int index, CarouselPageChangedReason _) =>
      _carouselPage.value = index;
}
