import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/bottom_space.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';

class EditNetworkPageWidgetSmallLayout extends StatelessWidget {
  const EditNetworkPageWidgetSmallLayout(this._wm, {super.key});

  final EditNetworkWidgetModel _wm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(DimensSize.d16),
            sliver: SliverList.list(
              children: [
                DefaultAppBar(
                  titleText:
                      _wm.connection?.networkName ??
                      LocaleKeys.addCustomNetwork.tr(),
                  onClosePressed: _wm.onBack,
                ),
                Form(
                  key: _wm.formKey,
                  child: SeparatedColumn(
                    spacing: DimensSize.d24,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypeField(
                        connectionTypeState: _wm.connectionTypeState,
                        isEditable: _wm.isEditable,
                        onChangeType: _wm.onChangeType,
                      ),
                      if (_wm.networkTypesOptions != null)
                        NetworkTypeField(
                          isEditable: _wm.isEditable,
                          types: _wm.networkTypesOptions!,
                          selectedNetworkTypeState:
                              _wm.selectedNetworkTypeState,
                          onChanged: _wm.onChangedNetworkType,
                        ),
                      NameField(
                        isEditable: _wm.isEditable,
                        controller: _wm.nameController,
                        validator: _wm.validators.nameValidator,
                      ),
                      EndpointsField(
                        isEditable: _wm.isEditable,
                        endpointsControllersState:
                            _wm.endpointsControllersState,
                        connectionTypeState: _wm.connectionTypeState,
                        validator: _wm.validators.nonOptionalUrlValidator,
                        isLocalState: _wm.isLocalState,
                        onLocalChanged: _wm.onLocalChanged,
                        onAdd: _wm.onAdd,
                        onRemove: _wm.onRemove,
                      ),
                      CurrencyField(
                        isEditable: _wm.isEditable,
                        controller: _wm.currencySymbolController,
                        validator: _wm.validators.currencySymbolValidator,
                      ),
                      DecimalsField(
                        isEditable: _wm.isEditable,
                        controller: _wm.currencyDecimalsController,
                      ),
                      BlockExplorerField(
                        validator: _wm.validators.optionalUrlValidator,
                        isEditable: _wm.isEditable,
                        controller: _wm.blockExplorerUrlController,
                      ),
                      TokenListField(
                        isEditable: _wm.isEditable,
                        controller: _wm.manifestUrlController,
                        validator: _wm.validators.optionalUrlValidator,
                        errorText: _wm.manifestErrorState,
                        isLoading: _wm.isManifestLoadingState,
                        onTap: _wm.onTokenListTextLinkTap,
                      ),
                    ],
                  ),
                ),
                if (_wm.isSaveEnabled || _wm.isDeleteEnabled)
                  Padding(
                    padding: const EdgeInsets.only(top: DimensSize.d16),
                    child: NetworkButtons(
                      saveEnabled: _wm.isSaveEnabled,
                      deleteEnabled: _wm.isDeleteEnabled,
                      connection: _wm.connection,
                      onSave: _wm.onSave,
                      onDelete: _wm.onDelete,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
