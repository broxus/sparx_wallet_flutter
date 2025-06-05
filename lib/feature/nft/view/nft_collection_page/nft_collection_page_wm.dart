import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

NftCollectionPageWidgetModel defaultNftCollectionPageWidgetModelFactory(
  BuildContext context,
) =>
    NftCollectionPageWidgetModel(
      NftCollectionPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class NftCollectionPageWidgetModel
    extends CustomWidgetModel<NftCollectionPageWidget, NftCollectionPageModel> {
  NftCollectionPageWidgetModel(super.model);

  late final _displayMode = createNotifierFromStream(model.displayModeStream);
  late final _collection = createNotifier<NftCollection>();

  late final PagingController<String, NftItem> controller = PagingController(
    getNextPageKey: (_) => _current == null
        // first page, use empty continuation
        ? ''
        // if continuation is null the list is finished
        : _current!.continuation,
    fetchPage: _fetchPage,
  );

  NftList? _current;
  StreamSubscription<NftTransferEvent>? _transferEventSubscription;

  ListenableState<NftDisplayMode?> get displayMode => _displayMode;

  ListenableState<NftCollection> get collection => _collection;

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
    final collection = await model.getCollection(widget.collection);
    await model.removePendingNft(widget.collection);

    if (collection == null) {
      contextSafe?.compassBack();
      return;
    }

    _collection.accept(collection);
    _transferEventSubscription = model
        .getNftTransferEventStream(collection.address)
        .listen((_) => _reset());
  }

  void _reset() {
    _current = null;
    controller.refresh();
  }

  void _onViewInExplorer() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getAccountExplorerLink(widget.collection),
    );
  }

  Future<void> _onHideCollection() async {
    Navigator.of(context).pop();
    await model.hideCollection(widget.collection);
    contextSafe?.compassBack();
  }

  Future<List<NftItem>> _fetchPage(String continuation) async {
    final collection = await model.getCollection(widget.collection);
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
