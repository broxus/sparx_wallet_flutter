import 'dart:async';

import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [AccountSettingsChangeColorButton]
class AccountSettingsChangeColorButtonModel extends ElementaryModel {
  AccountSettingsChangeColorButtonModel(
    ErrorHandler errorHandler,
    this._identifyIconsService,
  ) : super(errorHandler: errorHandler);

  late final _colorState = StateNotifier<IdentifyIconData>(
    initValue: _identifyIconsService.initialColor,
  );

  final IIdentifyIconsService _identifyIconsService;

  StreamSubscription<AccountsColorsCollection>? _sc;

  ListenableState<IdentifyIconData> get colorState => _colorState;

  @override
  void dispose() {
    _sc?.cancel();
    super.dispose();
  }

  void initListener(String address) {
    _sc = _identifyIconsService.accountsColorsStream.listen(
      (AccountsColorsCollection collection) async =>
          _colorState.accept(await collection.getData(address)),
    );
  }
}
