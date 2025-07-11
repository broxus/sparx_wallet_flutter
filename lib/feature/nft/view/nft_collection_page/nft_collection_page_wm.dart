import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class NftCollectionPageWidgetModel
    extends CustomWidgetModel<NftCollectionPageWidget, NftCollectionPageModel> {
  NftCollectionPageWidgetModel(
    super.model,
    @factoryParam this._collection,
  );

  final Address _collection;

  late final _displayModeState =
      createNotifierFromStream(model.displayModeStream);
  late final _collectionState = createNotifier<NftCollection>();

  late final PagingController<String, NftItem> controller = PagingController(
    getNextPageKey: (_) => _current == null
        // first page, use empty continuation
        ? ''
        // if continuation is null the list is finished
        : _current!.continuation,
    fetchPage: _fetchPage,
  );

  Set<String> pending = const {};

  NftList? _current;
  StreamSubscription<NftTransferEvent>? _transferEventSubscription;

  ListenableState<NftDisplayMode?> get displayModeState => _displayModeState;

  ListenableState<NftCollection> get collectionState => _collectionState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void dispose() {
    _transferEventSubscription?.cancel();
    super.dispose();
  }

  void setDisplayMode(NftDisplayMode mode) => model.setDisplayMode(mode);

  void onSettings() => showNftCollectionSettionsSheet(
        context: context,
        onViewInExplorer: _onViewInExplorer,
        onHideCollection: _onHideCollection,
      );

  void onNftPressed(NftItem item) {
    context.compassContinue(
      NftItemRouteData(
        address: item.nft.address,
        collection: item.nft.collection,
      ),
    );
  }

  Future<void> _init() async {
    final collection = await model.getCollection(_collection);
    final pendingList = await model.removePendingNft(_collection);

    if (collection == null) {
      contextSafe?.compassBack();
      return;
    }

    pending = pendingList.map((e) => e.id).toSet();
    _collectionState.accept(collection);
    _transferEventSubscription = model
        .getNftTransferEventStream(collection.address)
        .listen((_) => _reset());
  }

  void _reset() {
    _current = null;
    controller.refresh();
  }

  void _onViewInExplorer() {
    openBrowserUrl(
      model.getAccountExplorerLink(_collection),
    );
  }

  Future<void> _onHideCollection() async {
    await model.hideCollection(_collection);
    contextSafe?.compassBack();
  }

  Future<List<NftItem>> _fetchPage(String continuation) async {
    final collection = await model.getCollection(_collection);
    if (collection == null) {
      return [];
    }

    final list = await model.getNtfList(
      collection: collection.address,
      continuation: continuation.isEmpty ? null : continuation,
    );

    return (_current = list).items;
  }
}
