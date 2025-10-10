import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/ton_wallet_details/view/ton_wallet_details_page.dart';
import 'package:app/feature/wallet/ton_wallet_details/view/ton_wallet_details_page_model.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class TonWalletDetailsPageWidgetModel
    extends
        CustomWidgetModelParametrized<
          TonWalletDetailsPage,
          TonWalletDetailsPageModel,
          Address
        > {
  TonWalletDetailsPageWidgetModel(super.model);

  late final scrollController = createScrollController();

  late final _accountState = createNotifier<KeyAccount>();
  late final _tokenBalanceState = createNotifier<Money>();
  late final _fiatBalanceState = createNotifier<Money>();
  late final _errorState = createNotifier<Object>();
  late final _loadingErrorState = createNotifier(false);

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  ListenableState<KeyAccount> get accountState => _accountState;
  ListenableState<Money> get tokenBalanceState => _tokenBalanceState;
  ListenableState<Money> get fiatBalanceState => _fiatBalanceState;
  ListenableState<Object> get errorState => _errorState;
  ListenableState<bool> get loadingErrorState => _loadingErrorState;

  String get symbol => model.symbol;
  ThemeStyleV2 get theme => context.themeStyleV2;
  Address get address => wmParams.value;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    final acc = model.findAccountByAddress(address);
    if (acc == null) return;

    _accountState.accept(acc);
    _fiatBalanceState.accept(model.convertCurrency(Fixed.zero));
    _tokenBalanceState.accept(
      Money.fromBigIntWithCurrency(BigInt.zero, Currencies()[symbol]!),
    );

    _walletsSubscription = model.walletsMapStream.listen((wallets) {
      final walletState = wallets[address];
      if (walletState != null) {
        _walletsSubscription?.cancel();

        if (walletState.hasError) {
          _errorState.accept(walletState.error);
          _loadingErrorState.accept(false);
        } else {
          final wallet = walletState.wallet!;

          _thisWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
            _tokenBalanceState.accept(
              Money.fromBigIntWithCurrency(
                wallet.contractState.balance,
                Currencies()[symbol]!,
              ),
            );
          });

          _balanceSubscription = model
              .getTonWalletBalanceStream(address)
              .listen((balance) {
                _fiatBalanceState.accept(model.convertCurrency(balance));
              });
        }
      }
    });
  }

  Future<void> retry() async {
    final addr = wmParams.value;

    try {
      _loadingErrorState.accept(true);
      await model.retrySubscriptions(addr);
    } finally {
      _loadingErrorState.accept(false);
    }
  }

  @override
  void dispose() {
    _walletsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();
    super.dispose();
  }
}
