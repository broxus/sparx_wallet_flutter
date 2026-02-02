import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen_model.dart';
import 'package:app/feature/root_device_alert/view/widgets/root_device_info_bs.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [RootDeviceAlertScreen]
@injectable
class RootDeviceAlertScreenWidgetModel
    extends
        CustomWidgetModel<RootDeviceAlertScreen, RootDeviceAlertScreenModel> {
  RootDeviceAlertScreenWidgetModel(super.model);

  late final titleStyle = _theme.textStyles.headingLarge.copyWith(
    letterSpacing: -.336,
  );

  late final descriptionStyle = _theme.textStyles.paragraphSmall;

  late final _theme = context.themeStyleV2;

  late final _acceptState = createNotNullNotifier<bool>(false);

  NotNullListenableState<bool> get acceptState => _acceptState;

  void onPressedInfo() {
    showRootInfo(context);
  }

  void onPressedAccept() {
    _acceptState.accept(!_acceptState.value);
  }

  void onPressedNext() => model.next();
}
