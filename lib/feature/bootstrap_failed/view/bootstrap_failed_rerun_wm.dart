import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/bootstrap_failed/bootstrap_failed.dart';
import 'package:app/feature/contact_support/contact_support.dart';
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
