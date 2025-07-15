import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:app/widgets/user_avatar/user_avatar_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:rxdart/rxdart.dart';

/// Factory method for creating [UserAvatarWidgetModel]
UserAvatarWidgetModel defaultUserAvatarWidgetModelFactory(
  BuildContext context,
) {
  return UserAvatarWidgetModel(
    UserAvatarModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [UserAvatar]
class UserAvatarWidgetModel
    extends CustomWidgetModel<UserAvatar, UserAvatarModel> {
  UserAvatarWidgetModel(super.model);

  late final _address = createWidgetProperty((w) => w.address);
  late final _avatarState = createNotifierFromStream(
    _address.asStream().switchMap(
          (address) => model
              .getDataStream(address)
              .map((identify) => _getAvatarData(address, identify)),
        ),
  );

  ListenableState<AvatarData?> get avatarState => _avatarState;

  AvatarData _getAvatarData(String? address, IdentifyIconData? identify) {
    try {
      if (address != null) {
        final result = identify == null
            ? Jdenticon.toSvg(address)
            : Jdenticon.toSvg(
                address,
                colorLightnessMinValue: identify.lightness.colorMin,
                colorLightnessMaxValue: identify.lightness.colorMax,
                grayscaleLightnessMinValue: identify.lightness.grayscale.min,
                grayscaleLightnessMaxValue: identify.lightness.grayscale.max,
                colorSaturation: identify.saturation.color,
                grayscaleSaturation: identify.saturation.grayscale,
                backColor: identify.bacColor,
                hues: identify.hues,
              );

        return AvatarData(
          type: AvatarType.raw,
          path: result,
          color: identify?.color,
        );
      }
    } catch (_) {}

    return AvatarData(
      type: AvatarType.asset,
      path: Assets.images.userAvatar.userAvatar.path,
      color: identify?.color,
    );
  }
}

class AvatarData {
  AvatarData({
    required this.type,
    required this.path,
    this.color,
  });

  final AvatarType type;
  final String path;
  final Color? color;
}

enum AvatarType {
  asset,
  raw,
}
