import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] for [RootDeviceAlertScreen]
@injectable
class RootDeviceAlertScreenWidgetModel
    extends
        CustomWidgetModel<RootDeviceAlertScreen, RootDeviceAlertScreenModel> {
  RootDeviceAlertScreenWidgetModel(super.model);

  late final _understandState = createNotNullNotifier<bool>(false);

  NotNullListenableState<bool> get understandState => _understandState;

  void onChangedCheckBox() {
    _understandState.accept(!_understandState.value);
  }

  void onPressedNext() => model.next();
}
