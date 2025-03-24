import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

enum TonConnectStep { account, confirm }

TCConnectWidgetModel defaultTCConnectWidgetModelFactory(
  BuildContext context,
) =>
    TCConnectWidgetModel(
      TCConnectModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class TCConnectWidgetModel
    extends CustomWidgetModel<TCConnectWidget, TCConnectModel> {
  TCConnectWidgetModel(super.model);

  late final ScrollController scrollController = widget.scrollController;

  late final searchController = createTextEditingController();
  late final _step = createValueNotifier(TonConnectStep.account);
  late final _selected = createNotifier(_initialSelectedAccount);
  late final _accounts = createNotifier(model.accounts);
  late final _manifest = createNotifier<DappManifest>();
  late final _zeroBalance = Money.fromBigIntWithCurrency(
    BigInt.zero,
    Currencies()[model.symbol] ??
        Currency.create(model.symbol, 0, pattern: moneyPattern(0)),
  );
  final _balances = <Address, ListenableState<Money>>{};

  ValueListenable<TonConnectStep> get step => _step;

  ListenableState<List<KeyAccount>> get accounts => _accounts;

  ListenableState<KeyAccount?> get selected => _selected;

  ListenableState<DappManifest> get manifest => _manifest;

  KeyAccount? get _initialSelectedAccount =>
      model.currentAccount ?? model.accounts.firstOrNull;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _getManifest();
  }

  void onNext() {
    if (_selected.value == null) return;
    _step.value = TonConnectStep.confirm;
  }

  void onSearch() {
    final value = searchController.value.text.trim().toLowerCase();

    if (value.isEmpty) {
      _accounts.accept(model.accounts);
    } else {
      _accounts.accept(
        model.accounts
            .where(
              (account) =>
                  account.name.toLowerCase().contains(value) ||
                  account.address.address.toLowerCase().contains(value),
            )
            .toList(),
      );
    }
  }

  void onSelectedChanged(KeyAccount? account) {
    _selected.accept(account);
  }

  Future<void> onConfirm(String password) async {
    if (_selected.value == null) return;

    final account = _selected.value!;
    final replyItems = await model.createReplyItems(
      password: password,
      account: account,
      request: widget.request,
      manifest: _manifest.value!,
    );

    if (contextSafe != null) {
      Navigator.of(contextSafe!).pop((account, replyItems));
    }
  }

  // TODO(komarov): generic account list / account loader / etc.
  ListenableState<Money> getBalanceEntity(KeyAccount account) {
    var entity = _balances[account.address];

    if (entity == null) {
      final notifier = createNotifier<Money>();
      entity = _balances[account.address] = notifier;

      model
          .getBalance(account)
          .then((value) => notifier.accept(value ?? _zeroBalance));
    }

    return entity;
  }

  Future<void> _getManifest() async {
    final manifest = await model.getManifest(widget.request.manifestUrl);
    _manifest.accept(manifest);
  }
}
