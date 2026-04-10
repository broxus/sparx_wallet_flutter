import 'package:app/app/service/storage_service/storage_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  NavigationService(this._storageService);

  final AppStorageService _storageService;

  String? getSavedState() =>
      _storageService.getValue<String>(StorageKey.navigationServiceState());

  void saveLastLocation(String location) =>
      _storageService.addValue(StorageKey.navigationServiceState(), location);
}
