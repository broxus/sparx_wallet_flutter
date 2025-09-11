import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/account_asset_tab.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/account_asset_tab_model.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountAssetsTabParams {
  AccountAssetsTabParams({
    required this.account,
    required this.isShowingNewTokens,
    required this.manifestUrl,
  });

  final KeyAccount account;
  final bool isShowingNewTokens;
  final String manifestUrl;
}

@injectable
class AccountAssetsTabWidgetModel extends CustomWidgetModelParametrized<
    AccountAssetsTab, AccountAssetsTabModel, AccountAssetsTabParams> {
  AccountAssetsTabWidgetModel(super.model);

  late final _assetsState = createNotifierFromStream(
    model.contractsForAccount(address),
  );
  late final _numberNewTokensState = createNotifierFromStream(
    wmParams
        .map((params) => params.isShowingNewTokens)
        .distinct()
        .switchMap(_searchTokenWallets),
  );

  ListenableState<List<TokenContractAsset>> get assetsState => _assetsState;
  ListenableState<int?> get numberNewTokensState => _numberNewTokensState;

  TonWalletAsset get tonWallet => wmParams.value.account.account.tonWallet;
  Address get address => tonWallet.address;
  bool get isShowingNewTokens => wmParams.value.isShowingNewTokens;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Stream<int> _searchTokenWallets(bool isShowingNewTokens) {
    if (!isShowingNewTokens) return Stream.value(0);

    return model
        .searchTokenWallets(address)
        .reduce((previous, element) => [...previous, ...element])
        .asStream()
        .map((e) => e.length);
  }
}
