import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

enum NotificationType {
  backup,
  unsupportedWalletType,
}

@injectable
class WalletAccountBodyWidgetModel extends CustomWidgetModelParametrized<
    WalletAccountBodyWidget, WalletAccountBodyModel, KeyAccount> {
  WalletAccountBodyWidgetModel(
    super.model,
  );

  late final _notifications = createNotifierFromStream(_notificationsStream);

  late final _carouselPage = createValueNotifier(0);

  late final ValueListenable<KeyAccount> currentAccountState =
      createWmParamsNotifier((it) => it);

  ListenableState<List<NotificationType>> get notifications => _notifications;

  ValueListenable<int> get carouselPage => _carouselPage;

  Stream<List<NotificationType>> get _notificationsStream {
    return Rx.combineLatest2(
      model.getIsUnsupportedWalletTypeStram(wmParams.value),
      model.getShowingManualBackupBadgeStream(wmParams.value),
      (bool isUnsupportedWalletType, bool isShowingBackup) =>
          <NotificationType>[
        if (isUnsupportedWalletType) NotificationType.unsupportedWalletType,
        if (isShowingBackup) NotificationType.backup,
      ],
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void onFinishedBackup(bool isCompleted) {
    model.hideBackupNotification(
      wmParams.value,
      isCompleted: isCompleted,
    );
  }

  void onSwitchAccount() => showSelectAccountSheet(context);

  void onPageChanged(int index, CarouselPageChangedReason _) =>
      _carouselPage.value = index;
}
