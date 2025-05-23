import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/request_permissions/request_permissions_model.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/request_permissions/request_permissions_widget.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

enum RequestPermissionsStep { account, confirm }

RequestPermissionsWidgetModel defaultRequestPermissionsWidgetModelFactory(
  BuildContext context,
) =>
    RequestPermissionsWidgetModel(
      RequestPermissionsModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class RequestPermissionsWidgetModel extends CustomWidgetModel<
    RequestPermissionsWidget, RequestPermissionsModel> {
  RequestPermissionsWidgetModel(super.model);

  late final Uri origin = widget.origin;
  late final ScrollController scrollController = widget.scrollController;

  late final searchController = createTextEditingController();
  late final _step = createValueNotifier(RequestPermissionsStep.account);
  late final _selected = createNotifier(_initialSelectedAccount);
  late final _accounts = createNotifier(model.accounts);
  late final _permissions = createNotifier(widget.permissions.toSet());
  late final _zeroBalance = Money.fromBigIntWithCurrency(
    BigInt.zero,
    Currencies()[model.symbol] ??
        Currency.create(model.symbol, 0, pattern: moneyPattern(0)),
  );
  final _balances = <Address, ListenableState<Money>>{};

  ValueListenable<RequestPermissionsStep> get step => _step;

  ListenableState<List<KeyAccount>> get accounts => _accounts;

  ListenableState<KeyAccount?> get selected => _selected;

  ListenableState<Set<Permission>> get permissions => _permissions;

  KeyAccount? get _initialSelectedAccount =>
      model.accounts.firstWhereOrNull(
        (a) => a.address == widget.previousSelectedAccount,
      ) ??
      model.currentAccount ??
      model.accounts.firstOrNull;

  void onNext() {
    if (_selected.value == null) return;
    _step.value = RequestPermissionsStep.confirm;
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

  void onPermissionSwitch({
    required Permission permission,
    required bool checked,
  }) {
    if (checked) {
      _permissions.accept(
        _permissions.value!.toSet()..add(permission),
      );
    } else {
      _permissions.accept(
        _permissions.value!.toSet()..remove(permission),
      );
    }
  }

  void onConfirm() {
    if (_selected.value == null || _permissions.value == null) return;

    final account = _selected.value!;
    var result = const Permissions();

    for (final permission in _permissions.value!) {
      switch (permission) {
        case Permission.basic:
          result = result.copyWith(basic: true);
        case Permission.accountInteraction:
          result = result.copyWith(
            accountInteraction: AccountInteraction(
              address: account.address,
              publicKey: account.publicKey,
              contractType: account.account.tonWallet.contract.toContractType(),
            ),
          );
      }
    }

    model.setPermissions(origin, result);
    Navigator.of(context).pop(result);
  }

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
}
