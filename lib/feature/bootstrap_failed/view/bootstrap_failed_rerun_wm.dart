import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/bootstrap_failed/view/bootstrap_failed_rerun_model.dart';
import 'package:app/feature/bootstrap_failed/view/bootstrap_failed_rerun_view.dart';
import 'package:app/feature/contact_support/widgets/contact_support/contact_support_mode.dart';
import 'package:app/feature/contact_support/widgets/contact_support/contact_support_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class BootstrapFailedRerunWidgetModel extends CustomWidgetModel<
    BootstrapFailedRerunView, BootstrapFailedRerunModel> {
  BootstrapFailedRerunWidgetModel(super.model);

  late final _loadingState = createNotifier(false);

  ListenableState<bool> get loadingState => _loadingState;

  Future<void> onPressedTryAgain() async {
    _loadingState.accept(true);
    try {
      await model.rerunFailedSteps();
    } finally {
      _loadingState.accept(false);
    }
  }

  void onPressedContactSupport() {
    showContactSupportSheet(
      context: context,
      mode: ContactSupportMode.initiatedByCrash,
    );
  }
}
