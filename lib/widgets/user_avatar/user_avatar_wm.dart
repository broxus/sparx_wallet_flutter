import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:app/widgets/user_avatar/user_avatar_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

/// [WidgetModel] для [UserAvatar]
@injectable
class UserAvatarWidgetModel
    extends CustomWidgetModel<UserAvatar, UserAvatarModel> {
  UserAvatarWidgetModel(
    super.model,
    @factoryParam this._address,
  );

  final String? _address;

  late final _avatarState = createNotifierFromStream(
    model
        .getDataStream(_address)
        .map((identify) => _getAvatarData(_address, identify)),
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
