import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector.dart';
import 'package:app/runner.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [WorkchainSelector]
@injectable
class WorkchainSelectorModel extends ElementaryModel {
  WorkchainSelectorModel(ErrorHandler errorHandler, this._storageService)
    : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  bool get isDevelopment => currentAppBuildType.isDevelopment;

  Stream<Connection?> get currentConnectionStream =>
      _storageService.currentConnectionStream;

  Stream<ConnectionWorkchain?> get currentWorkchainStream =>
      _storageService.currentWorkchainStream;
}
