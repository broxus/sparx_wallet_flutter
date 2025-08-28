import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'derive_keys_cubit.freezed.dart';
part 'derive_keys_state.dart';

/// How many keys should be displayed on one page
const derivedKeysPerPage = 5;

/// Number of pages that we be able to select.
const derivePageCount = 20;

const _initial = DeriveKeysState(
  canNextPage: false,
  canPrevPage: false,
  currentPageIndex: 0,
  pageCount: derivePageCount,
  keyNames: {},
  displayDerivedKeys: [],
  selectedKeys: {},
  isLoading: true,
  isCompleted: false,
);

class DerivedKeyWithIndex {
  const DerivedKeyWithIndex(this.index, this.publicKey);

  final int index;
  final PublicKey publicKey;
}

/// Cubit that contains logic to derive keys from seed.
/// UI displays keys by pages,
/// every page contains up to [derivedKeysPerPage] keys.
class DeriveKeysCubit extends Cubit<DeriveKeysState> with BlocBaseMixin {
  DeriveKeysCubit(
    this._nekotonRepository,
    this._ledgerService,
    this._publicKey,
    this._password,
  ) : super(_initial) {
    final seed = _nekotonRepository.seedList.findSeed(_publicKey);
    if (seed == null) {
      throw StateError('Seed with public key $_publicKey not found');
    }
    _seed = seed;
  }

  final NekotonRepository _nekotonRepository;
  final LedgerService _ledgerService;
  final PublicKey _publicKey;
  final String? _password;
  late final Seed _seed;

  /// Keys that were added before this deriving
  List<PublicKey> addedKeys = [];

  /// Key - public key, value - name of key
  Map<PublicKey, String> addedKeysNames = {};

  /// Index of page that should contains paginated keys from
  /// [_pages], page can be up to [derivePageCount].
  int _currentPageIndex = 0;

  /// Keys that were added during this deriving and this keys should be derived
  Set<DerivedKeyWithIndex> newKeysToAdd = {};

  /// Keys that were added before this deriving and must be removed
  Set<DerivedKeyWithIndex> keysToRemove = {};

  /// Keys that should contains check mark in UI (like they are added)
  Set<PublicKey> checkedKeys = {};

  /// List of keys by pages that should be displayed in UI as all possible keys.
  final _pages = <int, List<DerivedKeyWithIndex>>{};

  Future<void> init() async {
    for (final key in _seed.allKeys) {
      addedKeys.add(key.publicKey);
      addedKeysNames[key.publicKey] = key.name;
    }
    checkedKeys.addAll(addedKeys);

    await _getPage(_currentPageIndex);

    _emitDataState();
  }

  /// Set check mark to key.
  /// Add new key to [newKeysToAdd] if it was not added before or do nothing if
  /// it is in [addedKeys].
  void checkKey(DerivedKeyWithIndex item) {
    if (!addedKeys.contains(item.publicKey)) {
      newKeysToAdd.add(item);
    } else {
      keysToRemove.remove(item);
    }

    checkedKeys.add(item.publicKey);
    _emitDataState();
  }

  /// Remove check mark from key.
  /// Add key to [keysToRemove] if it is in [addedKeys] or do nothing if it is
  /// in [newKeysToAdd].
  void uncheckKey(DerivedKeyWithIndex item) {
    if (addedKeys.contains(item.publicKey)) {
      keysToRemove.add(item);
    } else {
      newKeysToAdd.remove(item);
    }
    checkedKeys.remove(item.publicKey);
    _emitDataState();
  }

  bool _canPrevPage() => _currentPageIndex > 0;

  bool _canNextPage() => _currentPageIndex < derivePageCount - 1;

  bool _canSelectPage(int page) => page >= 0 && page <= derivePageCount - 1;

  void prevPage() => selectPage(_currentPageIndex - 1);

  void nextPage() => selectPage(_currentPageIndex + 1);

  Future<void> selectPage(int pageIndex) async {
    if (!_canSelectPage(pageIndex)) return;

    _currentPageIndex = pageIndex;

    if (!_pages.containsKey(_currentPageIndex)) {
      _emitDataState(isLoading: true);
    }
    await _getPage(_currentPageIndex);
    _emitDataState();
  }

  void _emitDataState({
    bool isLoading = false,
  }) {
    emitSafe(
      DeriveKeysState(
        canNextPage: _canNextPage(),
        canPrevPage: _canPrevPage(),
        currentPageIndex: _currentPageIndex,
        pageCount: derivePageCount,
        keyNames: addedKeysNames,
        displayDerivedKeys: _pages[_currentPageIndex] ?? [],
        selectedKeys: checkedKeys,
        isLoading: isLoading,
        isCompleted: false,
      ),
    );
  }

  Future<void> select() async {
    emitSafe(
      DeriveKeysState(
        canNextPage: false,
        canPrevPage: false,
        currentPageIndex: _currentPageIndex,
        pageCount: derivePageCount,
        keyNames: addedKeysNames,
        displayDerivedKeys: _pages[_currentPageIndex] ?? [],
        selectedKeys: checkedKeys,
        isLoading: true,
        isCompleted: false,
      ),
    );

    if (keysToRemove.isNotEmpty) {
      final toRemove = _seed.subKeys
          .where((key) => keysToRemove.any((e) => e.publicKey == key.publicKey))
          .toList();

      await _nekotonRepository.removeKeys(toRemove);
    }

    if (newKeysToAdd.isNotEmpty) {
      final accountIds = newKeysToAdd.map((e) => e.index).toList();

      final params = accountIds.map(
        (id) => _password != null
            ? DeriveKeysParams.derived(
                accountId: id,
                masterKey: _seed.masterPublicKey,
                password: _password,
              )
            : DeriveKeysParams.ledger(accountId: id),
      );

      await _nekotonRepository.deriveKeys(params: params);
    }

    emitSafe(
      DeriveKeysState(
        canNextPage: false,
        canPrevPage: false,
        currentPageIndex: _currentPageIndex,
        pageCount: derivePageCount,
        keyNames: addedKeysNames,
        displayDerivedKeys: _pages[_currentPageIndex] ?? [],
        selectedKeys: checkedKeys,
        isLoading: false,
        isCompleted: true,
      ),
    );
  }

  Future<void> _getPage(int pageIndex) async {
    if (_pages.containsKey(pageIndex)) return;

    final offset = pageIndex * derivedKeysPerPage;
    final params = _password != null
        ? GetPublicKeysParams.derived(
            masterKey: _seed.masterPublicKey,
            password: _password,
            limit: derivedKeysPerPage,
            offset: offset,
          )
        : GetPublicKeysParams.ledger(
            limit: derivedKeysPerPage,
            offset: offset,
          );

    try {
      final keys = await _ledgerService.runWithLedgerIfKeyIsLedger(
        interactionType: LedgerInteractionType.getPublicKey,
        publicKey: _seed.masterPublicKey,
        action: () => _nekotonRepository.getKeysToDerive(params),
      );

      _pages[pageIndex] = keys
          .mapIndexed((index, key) => DerivedKeyWithIndex(offset + index, key))
          .toList();
    } on OperationCanceledException {
      // User canceled the operation, close the sheet
      emitSafe(state.copyWith(isCompleted: true));
    }
  }
}
