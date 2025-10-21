import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/native_token_ticker/native_token_ticker.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/edit_network/validators.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditNetworkWidgetModel
    extends
        CustomWidgetModelParametrized<
          EditNetworkPageWidget,
          EditNetworkModel,
          String?
        > {
  EditNetworkWidgetModel(super.model);

  String? get _connectionDataId => wmParams.value;

  final formKey = GlobalKey<FormState>();

  late final nameController = createTextEditingController(
    connection?.networkName ?? '',
  );

  late final isEditable = connection?.canBeEdited ?? true;

  late final currencySymbolController = createTextEditingController(
    connection?.defaultWorkchain.nativeTokenTicker.name ?? '',
  );

  late final currencyDecimalsController = createTextEditingController(
    connection?.defaultWorkchain.nativeTokenDecimals.toString() ?? '',
  );

  late final blockExplorerUrlController = createTextEditingController(
    connection?.defaultWorkchain.blockExplorerUrl ?? '',
  );

  late final manifestUrlController = createTextEditingController(
    connection?.defaultWorkchain.manifestUrl ?? '',
  );

  late final _isManifestLoadingState = createNotifier(false);
  late final _manifestErrorState = createNotifier<String>();

  late final bool isDeleteEnabled = connection != null && isEditable;
  late final bool isSaveEnabled = isEditable;

  late final validators = Validators();

  late final _selectedNetworkTypeState = createNotifier(
    connection?.defaultWorkchain.networkType ??
        model.networkTypesOptions?.firstOrNull,
  );

  late final _isLocalState = createNotifier(_getIsLocal());

  late final _endpointsControllersState = createNotifier(
    _getEndpointsControllers(),
  );

  late final _connectionTypeState = createNotifier(
    connection == null
        ? ConnectionType.jrpc
        : ConnectionType.fromConnection(connection!),
  );

  late final connection = model.connections.firstWhereOrNull(
    (element) => element.id == _connectionDataId,
  );

  ListenableState<NetworkType?> get selectedNetworkTypeState =>
      _selectedNetworkTypeState;

  ListenableState<bool> get isLocalState => _isLocalState;

  ListenableState<List<TextEditingController>> get endpointsControllersState =>
      _endpointsControllersState;

  ListenableState<ConnectionType> get connectionTypeState =>
      _connectionTypeState;

  List<NetworkType>? get networkTypesOptions {
    final networkType = connection?.defaultWorkchain.networkType;
    final networkTypesOptions = model.networkTypesOptions;

    if (networkType != null &&
        networkTypesOptions != null &&
        !networkTypesOptions.contains(networkType)) {
      return [networkType, ...networkTypesOptions];
    }

    return networkTypesOptions;
  }

  NetworkType get selectedNetworkType =>
      selectedNetworkTypeState.value ?? NetworkType.custom;

  ListenableState<bool> get isManifestLoadingState => _isManifestLoadingState;

  ListenableState<String> get manifestErrorState => _manifestErrorState;

  List<TextEditingController>? get _endpointsControllers =>
      _endpointsControllersState.value;

  bool get _isLocal => _isLocalState.value ?? connection != null;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    manifestUrlController.addListener(_validateManifestUrl);
  }

  void onChangedNetworkType(NetworkType value) {
    _selectedNetworkTypeState.accept(value);
  }

  // ignore: avoid_positional_boolean_parameters
  void onLocalChanged(bool value) {
    if (!isEditable) {
      return;
    }

    _isLocalState.accept(value);
  }

  void onAdd() {
    _endpointsControllersState.accept([
      ...?_endpointsControllers,
      createTextEditingController(),
    ]);
  }

  void onRemove(int index) {
    final controllers = [...?_endpointsControllers]..removeAt(index);

    _endpointsControllersState.accept(controllers);
  }

  void onChangeType(ConnectionType type) {
    _connectionTypeState.accept(type);
    if (!type.enableMultipleEndpoints) {
      final first = _endpointsControllers?.first;

      _endpointsControllersState.accept(first == null ? [] : [first]);
    }
  }

  void onTokenListTextLinkTap() =>
      model.openBrowserUrl(LocaleKeys.networkTokenListTextLinkUrl.tr());

  Future<void> onDelete() async {
    final result = await showDeleteNetworkConfirmationSheet(
      context: context,
      networkName: connection?.networkName ?? '',
    );

    if ((result ?? false) && connection != null) {
      model.removeConnection(connection!.id);
      contextSafe?.compassBack();
    }
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_manifestErrorState.value != null ||
        (_isManifestLoadingState.value ?? false)) {
      return;
    }

    final currentConnection = _getConnection();

    if (currentConnection == null) {
      return;
    }

    if (connection == null) {
      model.addConnection(currentConnection);
    } else {
      model.updateConnection(currentConnection);
    }

    if (connection == null) {
      await showSwitchToThisNetworkSheet(
        context: context,
        onSwitch: () => model.saveCurrentConnectionId(currentConnection.id),
      );
    }

    contextSafe?.compassBack();
  }

  // ignore: long-method
  List<TextEditingController> _getEndpointsControllers() {
    if (connection == null) {
      return [TextEditingController()];
    }

    return [
      for (final endpoint in connection!.defaultWorkchain.endpoints)
        TextEditingController(text: endpoint),
    ];
  }

  bool _getIsLocal() {
    return connection?.defaultWorkchain.isLocal ?? false;
  }

  Connection? _getConnection() {
    final id = connection?.id;
    final nativeTokenTicker =
        currencySymbolController.text.trim().takeIf((it) => it.isNotEmpty) ??
        'EVER';
    final nativeTokenDecimals =
        int.tryParse(currencyDecimalsController.text.trim()) ?? 9;

    final groupName = 'custom-${model.lastNetworkGroupNumber + 1}';

    if (id == null) {
      return null;
    }

    final networkName = nameController.text;

    return Connection(
      id: id,
      networkName: networkName,
      defaultWorkchainId: 0,
      workchains: [
        ConnectionWorkchain.custom(
          id: 0,
          parentConnectionId: id,
          networkName: networkName,
          networkGroup: groupName,
          networkType: selectedNetworkType,
          endpoints: [
            if (_endpointsControllers != null)
              for (final controller in _endpointsControllers!) controller.text,
          ],
          blockExplorerUrl: blockExplorerUrlController.text,
          manifestUrl: manifestUrlController.text,
          nativeTokenTicker: NativeTokenTicker(name: nativeTokenTicker),
          nativeTokenDecimals: nativeTokenDecimals,
          defaultNativeCurrencyDecimal: 9,
          isLocal: _isLocal,
        ),
      ],
      isPreset: false,
      canBeEdited: true,
    );
  }

  Future<void> _validateManifestUrl() async {
    _manifestErrorState.accept(null);

    final manifestUrl = manifestUrlController.text.trim();
    if (manifestUrl.isEmpty) return;

    final error = validators.nonOptionalUrlValidator.validate(manifestUrl);
    if (error != null) return;

    _isManifestLoadingState.accept(true);

    try {
      await model.fetchManifest(manifestUrl);
    } catch (e) {
      _manifestErrorState.accept(LocaleKeys.tokenListValidationError.tr());
    } finally {
      _isManifestLoadingState.accept(false);
    }
  }
}
