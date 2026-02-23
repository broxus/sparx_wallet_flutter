import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';

class EditNetworkPageWidgetDefaultLayout extends StatelessWidget {
  const EditNetworkPageWidgetDefaultLayout(this._wm, {super.key});

  final EditNetworkWidgetModel _wm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText:
            _wm.connection?.networkName ?? LocaleKeys.addCustomNetwork.tr(),
        onClosePressed: _wm.onBack,
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Form(
            key: _wm.formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(DimensSize.d16),
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
                ),
                BottomSpacer(
                  deleteEnabled: _wm.isDeleteEnabled,
                  saveEnabled: _wm.isSaveEnabled,
                ),
              ],
            ),
          ),
          if (_wm.isSaveEnabled || _wm.isDeleteEnabled)
            ColoredBox(
              color: _wm.theme.colors.background0,
              child: Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: NetworkButtons(
                  saveEnabled: _wm.isSaveEnabled,
                  deleteEnabled: _wm.isDeleteEnabled,
                  connection: _wm.connection,
                  onSave: _wm.onSave,
                  onDelete: _wm.onDelete,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
