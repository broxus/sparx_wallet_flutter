import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

enum NotificationType { backup, unsupportedWalletType, invalidExternalAccount }

@injectable
class WalletAccountBodyWidgetModel
    extends
        CustomWidgetModelParametrized<
          WalletAccountBodyWidget,
          WalletAccountBodyModel,
          KeyAccount
        > {
  WalletAccountBodyWidgetModel(super.model);

  late final _notificationsState = createNotifierFromStream(
    _notificationsStream,
  );

  late final _carouselPageState = createValueNotifier(0);

  late final ValueListenable<KeyAccount> currentAccountState =
      createWmParamsNotifier((it) => it);

  ListenableState<List<NotificationType>> get notificationsState =>
      _notificationsState;

  ValueListenable<int> get carouselPageState => _carouselPageState;

  Stream<List<NotificationType>> get _notificationsStream {
    return Rx.combineLatest3(
      model.getIsUnsupportedWalletTypeStream(wmParams.value),
      model.getShowingManualBackupBadgeStream(wmParams.value),
      model.getIsInvalidExternalAccountStream(wmParams.value),
      (
        bool isUnsupportedWalletType,
        bool isShowingBackup,
        bool isInvalidExternalAccount,
      ) => <NotificationType>[
        if (isInvalidExternalAccount) .invalidExternalAccount,
        if (isUnsupportedWalletType) .unsupportedWalletType,
        if (isShowingBackup) .backup,
      ],
    );
  }

  void onSwitchAccount() => showSelectAccountSheet(context);

  void onPageChanged(int index, CarouselPageChangedReason _) =>
      _carouselPageState.value = index;
}
