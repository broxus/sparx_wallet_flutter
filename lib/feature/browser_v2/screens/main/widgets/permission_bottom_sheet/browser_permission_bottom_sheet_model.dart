import 'package:app/app/service/app_permissions_service.dart';
import 'package:app/app/service/permissions_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/permission_bottom_sheet/browser_permission_bottom_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BrowserPermissionBottomSheet]
@injectable
class BrowserPermissionBottomSheetModel extends ElementaryModel {
  BrowserPermissionBottomSheetModel(
    ErrorHandler errorHandler,
    this._appPermissionsService,
    this._permissionsService,
  ) : super(errorHandler: errorHandler);

  final AppPermissionsService _appPermissionsService;
  final PermissionsService _permissionsService;

  void saveBrowserCameraPermission(
    Uri uri,
    List<PermissionResourceType> resources,
  ) {
    _permissionsService.setPagePermissions(uri, [
      for (final r in resources) r.toValue(),
    ]);
  }

  void requestCameraPermission() => _appPermissionsService.requestCamera();
}
