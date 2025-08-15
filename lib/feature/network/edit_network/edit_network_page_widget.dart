import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EditNetworkPageWidget extends InjectedElementaryParametrizedWidget<
    EditNetworkWidgetModel, String?> {
  const EditNetworkPageWidget({
    String? connectionDataId,
    super.key,
  }) : super(
          wmFactoryParam: connectionDataId,
        );

  @override
  Widget build(EditNetworkWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: wm.connection?.name ?? LocaleKeys.addCustomNetwork.tr(),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              Form(
                key: wm.formKey,
                child: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(DimensSizeV2.d16),
                    child: SeparatedColumn(
                      spacing: DimensSizeV2.d24,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TypeField(
                          connectionTypeState: wm.connectionTypeState,
                          isEditable: wm.isEditable,
                          onChangeType: wm.onChangeType,
                        ),
                        if (wm.networkTypesOptions != null)
                          NetworkTypeField(
                            isEditable: wm.isEditable,
                            types: wm.networkTypesOptions!,
                            selectedNetworkTypeState:
                                wm.selectedNetworkTypeState,
                            onChanged: wm.onChangedNetworkType,
                          ),
                        NameField(
                          isEditable: wm.isEditable,
                          controller: wm.nameController,
                          validator: wm.validators.nameValidator,
                        ),
                        EndpointsField(
                          isEditable: wm.isEditable,
                          endpointsControllersState:
                              wm.endpointsControllersState,
                          connectionTypeState: wm.connectionTypeState,
                          validator: wm.validators.nonOptionalUrlValidator,
                          isLocalState: wm.isLocalState,
                          onLocalChanged: wm.onLocalChanged,
                          onAdd: wm.onAdd,
                          onRemove: wm.onRemove,
                        ),
                        CurrencyField(
                          isEditable: wm.isEditable,
                          controller: wm.currencySymbolController,
                          validator: wm.validators.currencySymbolValidator,
                        ),
                        DecimalsField(
                          isEditable: wm.isEditable,
                          controller: wm.currencyDecimalsController,
                        ),
                        BlockExplorerField(
                          validator: wm.validators.optionalUrlValidator,
                          isEditable: wm.isEditable,
                          controller: wm.blockExplorerUrlController,
                        ),
                        TokenListField(
                          isEditable: wm.isEditable,
                          controller: wm.manifestUrlController,
                          validator: wm.validators.optionalUrlValidator,
                          errorText: wm.manifestError,
                          isLoading: wm.isManifestLoading,
                          onTap: wm.onTokenListTextLinkTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomSpacer(
                deleteEnabled: wm.isDeleteEnabled,
                saveEnabled: wm.isSaveEnabled,
              ),
            ],
          ),
          NetworkButtons(
            saveEnabled: wm.isSaveEnabled,
            deleteEnabled: wm.isDeleteEnabled,
            connection: wm.connection,
            onSave: wm.onSave,
            onDelete: wm.onDelete,
          ),
        ],
      ),
    );
  }
}
