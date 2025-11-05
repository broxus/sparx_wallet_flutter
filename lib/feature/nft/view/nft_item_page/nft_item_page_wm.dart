import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NftItemWmParams {
  NftItemWmParams({required this.address, required this.collection});

  final Address address;
  final Address collection;
}

@injectable
class NftItemPageWidgetModel
    extends
        CustomWidgetModelParametrized<
          NftItemPageWidget,
          NftItemPageModel,
          NftItemWmParams
        > {
  NftItemPageWidgetModel(super.model);

  late final _itemState = createNotifier<NftItem>();
  late final _collectionState = createNotifier<NftCollection>();
  late final _currentAccountState = createNotifierFromStream(
    model.currentAccount,
  );
  late final _marketplaceUrlState = createNotifierFromStream(
    model.marketplaceUrlStream,
  );

  ListenableState<NftItem> get itemState => _itemState;

  ListenableState<NftCollection> get collectionState => _collectionState;

  ListenableState<KeyAccount?> get currentAccountState => _currentAccountState;

  ListenableState<String?> get marketplaceUrlState => _marketplaceUrlState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  double get topOffset => MediaQuery.viewPaddingOf(context).top;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void onBackPressed() {
    final ctx = contextSafe;

    if (ctx == null) {
      return;
    }

    Navigator.of(ctx).pop();
  }

  void onViewInExplorer(Address address) {
    model.openExplorerLinkByBrowser(address);
  }

  void onTransferNft() {
    final item = _itemState.value;
    final account = _currentAccountState.value;
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
    final item = _itemState.value;
    final account = _currentAccountState.value;
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
    final item = _itemState.value;
    final marketplaceUrl = _marketplaceUrlState.value;
    if (item == null || marketplaceUrl == null) return;

    model.openBrowserUrl('$marketplaceUrl/nft/${item.nft.address}');
  }

  void openImageView() => Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) => NftItemImageView(itemState.value!.nft.imageUrl),
    ),
  );

  Future<void> _init() async {
    final (item, collection) = await FutureExt.wait2(
      model.getNftItem(wmParams.value.address),
      model.getCollection(wmParams.value.collection),
    );

    if (item == null || collection == null) {
      await contextSafe?.compassBack();
      return;
    }

    _itemState.accept(item);
    _collectionState.accept(collection);
  }
}
