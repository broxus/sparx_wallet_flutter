import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/request_permissions_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/request_permissions_widget.dart';
import 'package:app/feature/browser/approvals_listener/actions/wallet_type_to_contract.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

enum RequestPermissionsStep { account, confirm }

class RequestPermissionsWmParams {
  const RequestPermissionsWmParams({
    required this.origin,
    required this.permissions,
    required this.previousSelectedAccount,
  });

  final Uri origin;
  final List<Permission> permissions;
  final Address? previousSelectedAccount;
}

@injectable
class RequestPermissionsWidgetModel
    extends
        CustomWidgetModelParametrized<
          RequestPermissionsWidget,
          RequestPermissionsModel,
          RequestPermissionsWmParams
        > {
  RequestPermissionsWidgetModel(super.model);

  late final ValueListenable<Uri> originState = createWmParamsNotifier(
    (it) => it.origin,
  );

  late final searchController = createTextEditingController();
  late final _stepState = createValueNotifier(RequestPermissionsStep.account);
  late final _selectedState = createNotifier(_initialSelectedAccount);
  late final _permissionsState = createWmParamsNotifier(
    (it) => it.permissions.toSet(),
  );

  ValueListenable<RequestPermissionsStep> get stepState => _stepState;

  ListenableState<KeyAccount?> get selectedState => _selectedState;

  ValueListenable<Set<Permission>> get permissionsState => _permissionsState;

  KeyAccount? get _initialSelectedAccount =>
      model.accounts.firstWhereOrNull(
        (a) => a.address == wmParams.value.previousSelectedAccount,
      ) ??
      model.currentAccount ??
      model.accounts.firstOrNull;

  void onNext() {
    if (_selectedState.value == null) return;
    _stepState.value = RequestPermissionsStep.confirm;
  }

  void onSelectedChanged(KeyAccount? account) {
    _selectedState.accept(account);
  }

  void onPermissionSwitch({
    required Permission permission,
    required bool checked,
  }) {
    if (checked) {
      _permissionsState.value = _permissionsState.value.toSet()
        ..add(permission);
    } else {
      _permissionsState.value = _permissionsState.value.toSet()
        ..remove(permission);
    }
  }

  void onConfirm() {
    if (_selectedState.value == null) return;

    final account = _selectedState.value!;
    var result = const Permissions();

    for (final permission in _permissionsState.value) {
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

    model.setPermissions(wmParams.value.origin, result);
    Navigator.of(context).pop(result);
  }
}
