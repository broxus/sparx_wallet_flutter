// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

NftPrepareTransferWidgetModel defaultNftPrepareTransferWidgetModelFactory(
  BuildContext context,
) {
  return NftPrepareTransferWidgetModel(
    NftPrepareTransferModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [NftPrepareTransfer]
class NftPrepareTransferWidgetModel
    extends CustomWidgetModel<NftPrepareTransfer, NftPrepareTransferModel> {
  NftPrepareTransferWidgetModel(
    super.model,
  );

  late final _data = createEntityNotifier<NftPrepareTransferData>()..loading();

  final formKey = GlobalKey<FormState>();
  final addressFilterFormatter = FilteringTextInputFormatter.deny(
    RegExp(r'\s'),
  );
  final amountFilterFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'\d'),
  );

  late final receiverController =
      createTextEditingController(routeData.value?.destination?.address);
  late final receiverFocus = createFocusNode();

  late final amountController = createTextEditingController();
  late final amountFocus = createFocusNode();

  late final routeData = createWidgetProperty((w) => w.routeData);

  ValueNotifier<EntityState<NftPrepareTransferData>> get data => _data;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  String? getSeedName(PublicKey pk) => model.getSeedName(pk);

  String? validateAddressField(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.addressIsEmpty.tr();
    }

    final address = Address(address: value!.trim());
    if (!address.isValid) {
      return LocaleKeys.invalidAddressFormat.tr();
    }

    return null;
  }

  String? validateAmountField(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.amountIsEmpty.tr();
    }

    final amount = BigInt.tryParse(value!.trim());
    final balance = _data.value.data?.item.wallet?.balance;

    if (amount != null && balance != null && amount > balance) {
      return LocaleKeys.insufficientFunds.tr();
    }

    return null;
  }

  Future<void> onSubmit() async {
    final data = _data.value.data;
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid || data == null) return;

    final receiver = Address(address: receiverController.text.trim());
    if (!receiver.isValid) {
      model.showError(LocaleKeys.addressIsWrong.tr());
      return;
    }

    final amount = BigInt.tryParse(amountController.text.trim());
    if ((routeData.value?.tokenFlag ?? false) && amount == null) {
      model.showError(LocaleKeys.amountIsWrong.tr());
      return;
    }

    contextSafe?.compassContinue(
      NftSendRouteData(
        owner: data.account.address,
        publicKey: data.custodian,
        address: data.item.nft.address,
        collection: data.item.nft.collection,
        destination: receiver,
        amount: amount,
      ),
    );
  }

  void onChangedCustodian(PublicKey custodian) => _data.content(
        _data.value.data!.copyWith(custodian: custodian),
      );

  void onPressedReceiverClear() => receiverController.clear();

  void onPressedPasteAddress(String text) {
    if (text.isEmpty) {
      model.showError(LocaleKeys.addressIsWrong.tr());
      return;
    }

    if (validateAddress(Address(address: text))) {
      receiverController.text = text;
      receiverFocus.unfocus();
    } else {
      model.showError(LocaleKeys.addressIsWrong.tr());
    }
  }

  Future<void> onPressedScan() async {
    final result = await showQrScanner(context, types: [QrScanType.address]);

    if (!context.mounted) return;

    result?.whenOrNull(
      address: (value) {
        receiverController.text = value.address;
        receiverFocus.unfocus();
      },
    );
  }

  void onSubmittedReceiverAddress(_) => (routeData.value?.tokenFlag ?? false)
      ? amountFocus.requestFocus()
      : onSubmit();

  void onMaxBalance() {
    amountController.text =
        _data.value.data?.item.wallet?.balance.toString() ?? '0';
  }

  Future<void> _init() async {
    final routeData = this.routeData.value;

    if (routeData == null) return;

    final account = model.findAccountByAddress(routeData.owner);
    final (nftItem, nftCollection, localCustodians) = await FutureExt.wait3(
      model.getNftItem(address: routeData.address, owner: routeData.owner),
      model.getCollection(routeData.collection),
      model.getLocalCustodiansAsync(routeData.owner),
    );

    if (account == null || nftItem == null || nftCollection == null) {
      _data.error(Exception('Nft transfer prepare initialization failed'));
      return;
    }

    _data.content(
      NftPrepareTransferData(
        account: account,
        item: nftItem,
        collection: nftCollection,
        custodian: localCustodians?.firstOrNull ?? account.publicKey,
        localCustodians: localCustodians,
      ),
    );
  }
}
