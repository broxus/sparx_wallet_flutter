import 'dart:async';

import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [UserAvatar]
class UserAvatarModel extends ElementaryModel {
  UserAvatarModel(
    ErrorHandler errorHandler,
    this._identifyIconsService,
  ) : super(errorHandler: errorHandler);

  final IIdentifyIconsService _identifyIconsService;

  Stream<IdentifyIconData> getDataStream(String? address) => address != null
      ? _identifyIconsService.accountsColorsStream.asyncMap(
          (AccountsColorsCollection collection) => collection.getData(address),
        )
      : Stream.value(_identifyIconsService.initialColor);
}
