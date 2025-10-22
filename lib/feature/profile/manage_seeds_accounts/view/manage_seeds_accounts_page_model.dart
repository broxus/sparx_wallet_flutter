import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class ManageSeedsAccountsPageModel extends ElementaryModel {
  ManageSeedsAccountsPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentSeedService,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentSeedService _currentSeedService;
  final AppStorageService _storageService;

  StreamSubscription<SeedList>? _seedListSub;

  Stream<Seed?> get currentSeedStream => _currentSeedService.currentSeedStream;

  Stream<List<Seed>> get seedsStream =>
      _nekotonRepository.seedListStream.map(_mapSeedList);

  @override
  void init() {
    super.init();

    // Mirror previous Cubit's side-effect when seed list changes
    _seedListSub = _nekotonRepository.seedListStream.skip(1).listen((seeds) {
      final list = List<Seed>.from(seeds.seeds)
        ..sort((a, b) => a.addedAt.compareTo(b.addedAt));
      if (list.isNotEmpty && list.first.addedAt != 0) {
        final seed = list.last;
        final key = StorageKey.showingManualBackupBadge(
          seed.masterKey.publicKey.publicKey,
        );
        final isShowBackup = _storageService.getValue<bool>(key);

        if (isShowBackup == null) {
          _storageService.addValue(key, seed.addType == SeedAddType.create);
        }
      }
    }, onError: (Object e, StackTrace s) => handleError(e, stackTrace: s));
  }

  @override
  void dispose() {
    _seedListSub?.cancel();
    super.dispose();
  }

  static List<Seed> _mapSeedList(SeedList list) {
    return List<Seed>.from(list.seeds)
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
