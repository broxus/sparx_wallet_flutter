import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [WorkchainSelector]
@injectable
class WorkchainSelectorModel extends ElementaryModel {
  WorkchainSelectorModel(
    ErrorHandler errorHandler,
    this._storageService,
    this._appBuildType,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;
  final AppBuildType _appBuildType;

  bool get isDevelopment => _appBuildType.isDevelopment;

  Stream<Connection?> get currentConnectionStream =>
      _storageService.currentConnectionStream;

  Stream<ConnectionWorkchain?> get currentWorkchainStream =>
      _storageService.currentWorkchainStream;
}
