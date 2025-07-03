import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

NftPageWidgetModel defaultNftPageWidgetModelFactory(
  BuildContext context,
) =>
    NftPageWidgetModel(
      NftPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class NftPageWidgetModel
    extends CustomWidgetModel<NftPageWidget, NftPageModel> {
  NftPageWidgetModel(super.model);

  late final _loadingState = createNotifier(true);
  late final _collectionsState = createNotifierFromStream(
    model.getCollectionsStream(),
  );
  late final _pendingState = createNotifierFromStream(
    model.getPendingNftStream().map(
          (pending) => pending.groupListsBy((e) => e.collection),
        ),
  );
  late final _displayModeState =
      createNotifierFromStream(model.displayModeStream);
  late final _marketplaceUrlState = createNotifierFromStream(
    model.marketplaceUrlStream,
  );

  StreamSubscription<Address?>? _subscription;
  StreamSubscription<NftTransferEvent>? _transferEventSubscription;

  ListenableState<bool> get loadingState => _loadingState;

  ListenableState<List<NftCollection>> get collectionsState =>
      _collectionsState;

  ListenableState<Map<Address, List<PendingNft>>> get pendingState =>
      _pendingState;

  ListenableState<NftDisplayMode?> get displayModeState => _displayModeState;

  ListenableState<String?> get marketplaceUrlState => _marketplaceUrlState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _subscription = Rx.combineLatest2(
      model.currentTransportStream.map((e) => e.networkGroup).distinct(),
      model.currentAccountStream.mapNotNull((e) => e?.address).distinct(),
      (_, owner) => owner,
    ).listen(
      (owner) => model.scanNftCollections(owner).then(
            (_) => _loadingState.accept(false),
          ),
    );

    _transferEventSubscription =
        model.getNftTransferEventStream().listen((_) => _reload());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _transferEventSubscription?.cancel();
    super.dispose();
  }

  void setDisplayMode(NftDisplayMode mode) => model.setDisplayMode(mode);

  Future<void> onAddNftPressed() async {
    final collection = await context.compassPush<NftCollection>(
      const AddNftRouteRouteData(),
    );

    if (collection != null) {
      final owner = await model.currentAccountStream.whereNotNull().first;
      model.addCollection(
        account: owner.address,
        collection: collection.address,
      );
      await _reload(owner);
    }
  }

  void onNftCollectionPressed(NftCollection collection) {
    context.compassContinue(
      NftCollectionRouteData(
        collection: collection.address,
      ),
    );
  }

  Future<void> _reload([KeyAccount? owner]) async {
    owner ??= await model.currentAccountStream.whereNotNull().first;
    await model.scanNftCollections(owner.address);
  }
}
