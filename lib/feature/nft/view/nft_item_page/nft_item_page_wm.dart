import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

NftItemPageWidgetModel defaultNftItemPageWidgetModelFactory(
  BuildContext context,
) =>
    NftItemPageWidgetModel(
      NftItemPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class NftItemPageWidgetModel
    extends CustomWidgetModel<NftItemPageWidget, NftItemPageModel> {
  NftItemPageWidgetModel(super.model);

  late final _item = createNotifier<NftItem>();
  late final _collection = createNotifier<NftCollection>();
  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _marketplaceUrl =
      createNotifierFromStream(model.marketplaceUrlStream);

  ListenableState<NftItem> get item => _item;

  ListenableState<NftCollection> get collection => _collection;

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<String?> get marketplaceUrl => _marketplaceUrl;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void onViewInExplorer(Address address) {
    openBrowserUrl(
      model.getAccountExplorerLink(widget.address),
    );
  }

  void onTransferNft() {
    final item = _item.value;
    final account = _currentAccount.value;
    if (item == null || account == null) return;

    contextSafe?.compassContinue(
      NftPrepareTransferRouteData(
        owner: account.address,
        address: item.nft.address,
        collection: item.nft.collection,
      ),
    );
  }

  void onTransferTokens() {
    final item = _item.value;
    final account = _currentAccount.value;
    if (item == null || account == null) return;

    contextSafe?.compassContinue(
      NftPrepareTransferRouteData(
        owner: account.address,
        address: item.nft.address,
        collection: item.nft.collection,
        tokenFlag: true,
      ),
    );
  }

  void onOpenInMarketplace() {
    final item = _item.value;
    final marketplaceUrl = _marketplaceUrl.value;
    if (item == null || marketplaceUrl == null) return;

    openBrowserUrl(
      '$marketplaceUrl/nft/${item.nft.address}',
    );
  }

  Future<void> _init() async {
    final (item, collection) = await FutureExt.wait2(
      model.getNftItem(widget.address),
      model.getCollection(widget.collection),
    );

    if (item == null || collection == null) {
      contextSafe?.compassBack();
      return;
    }

    _item.accept(item);
    _collection.accept(collection);
  }
}
