import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class VerifyLedgerWmParams {
  const VerifyLedgerWmParams({required this.account});

  final KeyAccount account;
}

@injectable
class VerifyLedgerWidgetModel
    extends
        CustomWidgetModelParametrized<
          VerifyLedgerWidget,
          VerifyLedgerModel,
          VerifyLedgerWmParams
        >
    with BleAvailabilityWmMixin {
  VerifyLedgerWidgetModel(super.model);

  late final _isVerifyingState = createNotifier(false);
  late final _interactionState = createNotifierFromStream(
    model.interactionStream.switchMap((e) => e.stateStream),
  );

  Address get address => _account.address;

  KeyAccount get _account => wmParams.value.account;

  ListenableState<bool> get isVerifyingState => _isVerifyingState;

  ListenableState<LedgerInteractionState> get interactionState =>
      _interactionState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onCopy() {
    setClipBoardData(_account.address.address);
    model.showMessage(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [_account.address.toEllipseString()],
        ),
      ),
    );
  }

  Future<void> onVerify() async {
    final isAvailable = await checkBluetoothAvailability();
    if (!isAvailable) return;

    try {
      _isVerifyingState.accept(true);

      await model.verify(_account);
    } catch (_) {
      _isVerifyingState.accept(false);
    }
  }
}
