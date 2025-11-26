import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/navigation_panel/address_bar/address_bar.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BrowserAddressBar]
@injectable
class BrowserAddressBarModel extends ElementaryModel {
  BrowserAddressBarModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<String?> get activeTabIdState =>
      _browserService.tab.activeTabIdState;

  bool get isEmptyActiveTabUri =>
      _browserService.tab.activeTabUriState.value?.path.isEmpty ?? false;

  void requestUrlActiveTabSafe(String enteredText) =>
      _browserService.requestUrlActiveTabSafe(enteredText);
}
