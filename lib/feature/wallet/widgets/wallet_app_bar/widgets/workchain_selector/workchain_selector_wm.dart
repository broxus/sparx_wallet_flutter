import 'package:app/app/service/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/bottom_sheets/select_workchain_bottom_sheet.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] for [WorkchainSelector]
@injectable
class WorkchainSelectorWidgetModel
    extends CustomWidgetModel<WorkchainSelector, WorkchainSelectorModel> {
  WorkchainSelectorWidgetModel(super.model);

  late final _currentConnectionState = createNotifierFromStream(
    model.currentConnectionStream,
  );

  late final _currentWorkchainState = createNotifierFromStream(
    model.currentWorkchainStream,
  );

  ListenableState<Connection?> get currentConnectionState =>
      _currentConnectionState;

  ListenableState<ConnectionWorkchain?> get currentWorkchainState =>
      _currentWorkchainState;

  bool get isShowWorkchainSelector => model.isDevelopment;

  void onPressed() {
    showSelectWorkchainSheet(context: context);
  }
}
