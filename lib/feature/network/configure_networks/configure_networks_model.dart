import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfigureNetworksModel extends ElementaryModel {
  ConfigureNetworksModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  Stream<List<ConnectionData>> get connections =>
      _storageService.connectionsStream;
}
