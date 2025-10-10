import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/network_type.dart';
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
    connection?.name ?? '',
  );

  late final isEditable = connection?.canBeEdited ?? true;

  late final currencySymbolController = createTextEditingController(
    connection?.nativeTokenTicker ?? '',
  );

  late final currencyDecimalsController = createTextEditingController(
    connection?.nativeTokenDecimals.toString() ?? '',
  );

  late final blockExplorerUrlController = createTextEditingController(
    connection?.blockExplorerUrl ?? '',
  );

  late final manifestUrlController = createTextEditingController(
    connection?.manifestUrl ?? '',
  );

  late final _isManifestLoadingState = createNotifier(false);
  late final _manifestErrorState = createNotifier<String>();

  late final bool isDeleteEnabled = connection != null && isEditable;
  late final bool isSaveEnabled = isEditable;

  late final validators = Validators();

  late final _selectedNetworkTypeState = createNotifier(
    connection?.networkType ?? model.networkTypesOptions?.firstOrNull,
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
    final networkType = connection?.networkType;
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

  ConnectionType? get _connectionType => _connectionTypeState.value;

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
      networkName: connection?.name ?? '',
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

    return switch (connection!) {
      ConnectionDataGql(:final endpoints) =>
        endpoints
            .map((endpoint) => TextEditingController(text: endpoint))
            .toList(),
      ConnectionDataProto(:final endpoint) => [
        TextEditingController(text: endpoint),
      ],
      ConnectionDataJrpc(:final endpoint) => [
        TextEditingController(text: endpoint),
      ],
    };
  }

  bool _getIsLocal() {
    if (connection == null) {
      return false;
    }

    return switch (connection!) {
      ConnectionDataGql(:final isLocal) => isLocal,
      _ => false,
    };
  }

  ConnectionData? _getConnection() {
    final id = connection?.id;
    final nativeTokenTicker =
        currencySymbolController.text.trim().takeIf((it) => it.isNotEmpty) ??
        'EVER';
    final nativeTokenDecimals =
        int.tryParse(currencyDecimalsController.text.trim()) ?? 9;

    final groupName = 'custom-${model.lastNetworkGroupNumber + 1}';

    return switch (_connectionType) {
      ConnectionType.jrpc => ConnectionData.jrpcCustom(
        id: id,
        name: nameController.text,
        group: groupName,
        networkType: selectedNetworkType,
        endpoint: _endpointsControllers![0].text,
        blockExplorerUrl: blockExplorerUrlController.text,
        manifestUrl: manifestUrlController.text,
        nativeTokenTicker: nativeTokenTicker,
        nativeTokenDecimals: nativeTokenDecimals,
      ),
      ConnectionType.gql => ConnectionData.gqlCustom(
        id: id,
        name: nameController.text,
        group: groupName,
        networkType: selectedNetworkType,
        endpoints: [
          for (final controller in _endpointsControllers!) controller.text,
        ],
        isLocal: _isLocal,
        blockExplorerUrl: blockExplorerUrlController.text,
        manifestUrl: manifestUrlController.text,
        nativeTokenTicker: nativeTokenTicker,
        nativeTokenDecimals: nativeTokenDecimals,
      ),
      ConnectionType.proto => ConnectionData.protoCustom(
        id: id,
        name: nameController.text,
        group: groupName,
        networkType: selectedNetworkType,
        endpoint: _endpointsControllers![0].text,
        blockExplorerUrl: blockExplorerUrlController.text,
        manifestUrl: manifestUrlController.text,
        nativeTokenTicker: nativeTokenTicker,
        nativeTokenDecimals: nativeTokenDecimals,
      ),
      _ => null,
    };
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
