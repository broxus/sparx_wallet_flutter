import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/seed_detail/seed_detail.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class DerivedKeyWithIndex {
  const DerivedKeyWithIndex(this.index, this.publicKey);

  final int index;
  final PublicKey publicKey;
}

const DeriveKeysState _initialDeriveKeysState = DeriveKeysState(
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

class DeriveKeysSheetParams {
  const DeriveKeysSheetParams({
    required this.publicKey,
    required this.password,
  });

  final PublicKey publicKey;
  final String? password;
}

@injectable
class DeriveKeysSheetWidgetModel extends CustomWidgetModelParametrized<
    InjectedElementaryParametrizedWidget<WidgetModel, DeriveKeysSheetParams>,
    DeriveKeysSheetModel,
    DeriveKeysSheetParams> {
  DeriveKeysSheetWidgetModel(super.model);

  final ValueNotifier<DeriveKeysState> state =
      ValueNotifier<DeriveKeysState>(_initialDeriveKeysState);

  final List<PublicKey> _addedKeys = [];
  final Map<PublicKey, String> _addedKeysNames = {};
  int _currentPageIndex = 0;
  final Set<DerivedKeyWithIndex> _newKeysToAdd = {};
  final Set<DerivedKeyWithIndex> _keysToRemove = {};
  final Set<PublicKey> _checkedKeys = {};
  final Map<int, List<DerivedKeyWithIndex>> _pages = {};
  late Seed _seed;

  PublicKey get masterKey => wmParams.value.publicKey;
  String? get password => wmParams.value.password;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    final seed = model.findSeed(masterKey);
    if (seed == null) {
      state.value = state.value.copyWith(
        isLoading: false,
        isCompleted: true,
      );
      return;
    }

    _seed = seed;

    for (final key in _seed.allKeys) {
      _addedKeys.add(key.publicKey);
      _addedKeysNames[key.publicKey] = key.name;
    }

    _checkedKeys.addAll(_addedKeys);
    await _getPage(_currentPageIndex);

    _emitDataState();
  }

  void checkKey(DerivedKeyWithIndex item) {
    if (!_addedKeys.contains(item.publicKey)) {
      _newKeysToAdd.add(item);
    } else {
      _keysToRemove.remove(item);
    }
    _checkedKeys.add(item.publicKey);
    _emitDataState();
  }

  void uncheckKey(DerivedKeyWithIndex item) {
    if (_addedKeys.contains(item.publicKey)) {
      _keysToRemove.add(item);
    } else {
      _newKeysToAdd.remove(item);
    }
    _checkedKeys.remove(item.publicKey);
    _emitDataState();
  }

  bool _canPrevPage() => _currentPageIndex > 0;
  bool _canNextPage() => _currentPageIndex < derivePageCount - 1;
  bool _canSelectPage(int page) => page >= 0 && page <= derivePageCount - 1;

  Future<void> prevPage() => selectPage(_currentPageIndex - 1);
  Future<void> nextPage() => selectPage(_currentPageIndex + 1);

  Future<void> selectPage(int pageIndex) async {
    if (!_canSelectPage(pageIndex)) return;
    _currentPageIndex = pageIndex;
    if (!_pages.containsKey(_currentPageIndex)) {
      _emitDataState(isLoading: true);
    }
    await _getPage(_currentPageIndex);
    _emitDataState();
  }

  Future<void> select() async {
    state.value = state.value.copyWith(isLoading: true);
    try {
      if (_keysToRemove.isNotEmpty) {
        final toRemove = _seed.subKeys
            .where(
              (key) => _keysToRemove.any((e) => e.publicKey == key.publicKey),
            )
            .toList();
        await model.removeKeys(toRemove);
      }
      if (_newKeysToAdd.isNotEmpty) {
        final accountIds = _newKeysToAdd.map((e) => e.index).toList();
        final params = accountIds.map(
          (id) => password != null
              ? DeriveKeysParams.derived(
                  accountId: id,
                  masterKey: _seed.masterPublicKey,
                  password: password!,
                )
              : DeriveKeysParams.ledger(accountId: id),
        );
        await model.deriveKeys(params);
      }
      state.value = state.value.copyWith(
        isLoading: false,
        isCompleted: true,
      );
    } catch (e) {
      state.value = state.value.copyWith(isLoading: false);
    }
  }

  void _emitDataState({bool isLoading = false}) {
    state.value = DeriveKeysState(
      canNextPage: _canNextPage(),
      canPrevPage: _canPrevPage(),
      currentPageIndex: _currentPageIndex,
      pageCount: derivePageCount,
      keyNames: _addedKeysNames,
      displayDerivedKeys: _pages[_currentPageIndex] ?? [],
      selectedKeys: _checkedKeys,
      isLoading: isLoading,
      isCompleted: false,
    );
  }

  Future<void> _getPage(int pageIndex) async {
    if (_pages.containsKey(pageIndex)) return;
    final offset = pageIndex * derivedKeysPerPage;
    final params = password != null
        ? GetPublicKeysParams.derived(
            masterKey: _seed.masterPublicKey,
            password: password!,
            limit: derivedKeysPerPage,
            offset: offset,
          )
        : GetPublicKeysParams.ledger(
            limit: derivedKeysPerPage,
            offset: offset,
          );
    try {
      final keys = await model.getKeysToDerive(
        params: params,
        masterKey: _seed.masterPublicKey,
      );
      _pages[pageIndex] = List.generate(
        keys.length,
        (index) => DerivedKeyWithIndex(offset + index, keys[index]),
      );
    } on OperationCanceledException {
      state.value = state.value.copyWith(isCompleted: true);
    } catch (e) {
      // swallow error, state stays as is
    }
  }
}
