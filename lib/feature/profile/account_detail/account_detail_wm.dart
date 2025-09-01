import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/account_detail/account_detail_model.dart';
import 'package:app/feature/profile/account_detail/account_detail_page.dart';
import 'package:app/feature/profile/key_detail/widgets/account_settings_sheet/account_settings_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AccountDetailWmParams {
  const AccountDetailWmParams(this.address);

  final Address address;
}

@injectable
class AccountDetailWidgetModel extends CustomWidgetModelParametrized<
    AccountDetailPage, AccountDetailModel, AccountDetailWmParams> {
  AccountDetailWidgetModel(super.model);

  late StreamSubscription<SeedList> _seedListSubscription;
  StreamSubscription<dynamic>? _balanceSub;
  List<PublicKey> _custodianKeys = [];
  List<SeedKey> _custodians = [];

  late final _accountState = createNotifier<KeyAccount?>();
  late final _balanceState = createNotifier<Money?>();
  late final _custodiansState = createNotifier<List<SeedKey>>([]);
  late final _isLoadingState = createNotifier<bool>(true);

  StateNotifier<KeyAccount?> get accountState => _accountState;
  StateNotifier<Money?> get balanceState => _balanceState;
  StateNotifier<List<SeedKey>> get custodiansState => _custodiansState;
  StateNotifier<bool> get isLoadingState => _isLoadingState;

  Address get address => wmParams.value.address;

  Transport? _lastTransport;
  KeyAccount? _cachedAccount;
  late Money _cachedBalance = model.convertBalance(Fixed.zero);

  bool _subCreatedManually = false;

  // ignore: unused_field
  TonWallet? _tonWallet;
  final List<TokenWalletState> _tokenWallets = [];

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void openSettings() {
    final context = contextSafe;
    final account = _accountState.value;
    if(context == null || account == null) return;

    showAccountSettingsSheet(
      context: context,
      address: account.address,
      showHiding: false,
    );
  }

  void _init() {
    _seedListSubscription = model.seedListStream.listen(_updateSeedState);
    _findCustodians();
  }

  void _updateSeedState(SeedList list) {
    final account = list.findAccountByAddress(address);

    if (_custodianKeys.isNotEmpty) {
      _custodians = _custodianKeys
          .map((e) => model.seedList.findSeedKey(e))
          .nonNulls
          .toList();
    }

    if (account == null) {
      _cachedAccount = null;
      _closeBalanceSubs();
      _accountState.accept(null);
      _balanceState.accept(null);
      _custodiansState.accept([]);
      _isLoadingState.accept(false);
      contextSafe?.compassBack();
    } else {
      _cachedAccount = account;
      _checkBalanceSub(account);
      _updateDataState();
    }
  }

  void _updateDataState() {
    _accountState.accept(_cachedAccount);
    _balanceState.accept(_cachedBalance);
    _custodiansState.accept(_custodians);
    _isLoadingState.accept(false);
  }

  void _checkBalanceSub(KeyAccount account) {
    // no transport or transport changed
    if (_lastTransport == null ||
        model.currentTransport.name != _lastTransport!.name) {
      _cachedBalance = model.convertBalance(Fixed.zero);
      _lastTransport = model.currentTransport;

      _balanceSub = model.accountOverallBalance(address).listen((balance) {
        if (balance == null) {
          return;
        }
        _cachedBalance = balance;
        _updateDataState();
      });

      // if we explore not current account for which subscriptions are created
      // automatically, create subs
      if (!model.containsWallet(address)) {
        _subCreatedManually = true;
        _subscribeNative();

        final networkGroup = _lastTransport!.group;
        final wallets = account.additionalAssets[networkGroup]?.tokenWallets;

        if (wallets != null) {
          for (final wallet in wallets) {
            _subscribeToken(wallet.rootTokenContract);
          }
        }
      }
    }
  }

  Future<void> _subscribeNative() async {
    final wallet = await model.subscribeByAddress(address);
    // for cases, when screen was closed before sub completed
    if (!isMounted) {
      await model.unsubscribe(address);
    } else {
      _tonWallet = wallet;
    }
  }

  Future<void> _subscribeToken(Address rootTokenContract) async {
    final token = await model.subscribeToken(
      owner: address,
      rootTokenContract: rootTokenContract,
    );

    if (token == null) return;

    // for cases, when screen was closed before sub completed
    if (!isMounted) {
      await model.unsubscribeToken(
        token.owner,
        token.rootTokenContract,
      );
    } else {
      _tokenWallets.add(token);
    }
  }

  Future<void> _closeBalanceSubs() async {
    await _balanceSub?.cancel();
    if (_subCreatedManually) {
      _tonWallet = null;
      await model.unsubscribe(address);
      _tokenWallets.removeWhere((token) {
        model.unsubscribeToken(
          token.owner,
          token.rootTokenContract,
        );

        return true;
      });
    }
  }

  @override
  void dispose() {
    _seedListSubscription.cancel();
    _balanceSub?.cancel();
    super.dispose();
  }

  Future<void> _findCustodians() async {
    final account = model.seedList.findAccountByAddress(address);
    final custodians = await model.getLocalCustodiansAsync(address);

    if (custodians != null && custodians.isNotEmpty) {
      _custodianKeys = custodians..removeWhere((k) => k == account?.publicKey);
      _updateSeedState(model.seedList);
    }
  }
}
