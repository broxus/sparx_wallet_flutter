import 'package:app/generated/generated.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

extension PermissionResourceTypeExt on PermissionResourceType {
  String get name {
    return _permissionResourceNames[this] ?? '';
  }
}

Map<PermissionResourceType, String> get _permissionResourceNames => {
      PermissionResourceType.AUTOPLAY: LocaleKeys.autoplay.tr(),
      PermissionResourceType.CAMERA: LocaleKeys.camera.tr(),
      PermissionResourceType.CAMERA_AND_MICROPHONE:
          LocaleKeys.cameraAndMicrophone.tr(),
      PermissionResourceType.CLIPBOARD_READ: LocaleKeys.clipboardRead.tr(),
      PermissionResourceType.DEVICE_ORIENTATION_AND_MOTION:
          LocaleKeys.deviceOrientationAndMotion.tr(),
      PermissionResourceType.FILE_READ_WRITE: LocaleKeys.fileReadWrite.tr(),
      PermissionResourceType.GEOLOCATION: LocaleKeys.geolocation.tr(),
      PermissionResourceType.LOCAL_FONTS: LocaleKeys.localFonts.tr(),
      PermissionResourceType.MICROPHONE: LocaleKeys.microphone.tr(),
      PermissionResourceType.MIDI_SYSEX: LocaleKeys.midiSysEx.tr(),
      PermissionResourceType.MULTIPLE_AUTOMATIC_DOWNLOADS:
          LocaleKeys.multipleAutomaticDownloads.tr(),
      PermissionResourceType.NOTIFICATIONS: LocaleKeys.notifications.tr(),
      PermissionResourceType.OTHER_SENSORS: LocaleKeys.otherSensors.tr(),
      PermissionResourceType.PROTECTED_MEDIA_ID:
          LocaleKeys.protectedMediaId.tr(),
      PermissionResourceType.UNKNOWN: LocaleKeys.unknown.tr(),
      PermissionResourceType.WINDOW_MANAGEMENT:
          LocaleKeys.windowManagement.tr(),
    };
