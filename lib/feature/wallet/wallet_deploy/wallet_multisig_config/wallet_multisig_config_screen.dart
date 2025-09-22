import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet_deploy/constants.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_multisig_config/wallet_multisig_config_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/input_formatters.dart';
import 'package:app/widgets/widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

final _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

const publicKeyLength = 64;

/// Minimum quantity of custodians for [WalletDeployType.multisig]
const minConfirmationsCount = 2;

class WalletMultisigConfigScreen extends InjectedElementaryParametrizedWidget<
    WalletMultisigConfigWidgetModel, WalletMultisigConfigWmParams> {
  WalletMultisigConfigScreen({
    required Address address,
    required PublicKey publicKey,
    List<PublicKey>? initialCustodians,
    int? initialRequireConfirmations,
    int? initialHours,
    super.key,
  }) : super(
          wmFactoryParam: WalletMultisigConfigWmParams(
            address: address,
            publicKey: publicKey,
            initialCustodians: initialCustodians,
            initialRequireConfirmations: initialRequireConfirmations,
            initialHours: initialHours,
          ),
        );

  @override
  Widget build(WalletMultisigConfigWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      appBar: DefaultAppBar(
        titleText: LocaleKeys.multisigConfiguration.tr(),
        backgroundColor: wm.colors.background0,
      ),
      body: _WalletMultisigConfigBody(
        custodians: wm.custodiansState.value,
        requireConfirmations: wm.requireConfirmationsState.value,
        hours: wm.hoursState.value,
        isWaitingTimeSelectionEnabled: wm.isWaitingTimeSelectionEnabled,
        onNext: (custodians, requireConfirmations, hours) {
          wm.onNext(
            custodians: custodians,
            requireConfirmations: requireConfirmations,
            hours: hours,
          );
        },
      ),
    );
  }
}

/// Widget that allows prepare data for multisig deploy.
class _WalletMultisigConfigBody extends StatefulWidget {
  const _WalletMultisigConfigBody({
    required this.custodians,
    required this.requireConfirmations,
    required this.hours,
    required this.isWaitingTimeSelectionEnabled,
    required this.onNext,
  });

  /// This data is just initial data and not used during lifecycle.
  final List<PublicKey> custodians;
  final int requireConfirmations;
  final int hours;
  final bool isWaitingTimeSelectionEnabled;
  final void Function(
    List<PublicKey> custodians,
    int requireConfirmations,
    int hours,
  ) onNext;

  @override
  State<_WalletMultisigConfigBody> createState() =>
      _WalletMultisigConfigBodyState();
}

class _WalletMultisigConfigBodyState extends State<_WalletMultisigConfigBody> {
  final _formKey = GlobalKey<FormState>();

  late List<TextEditingController> custodianControllers = List.generate(
    widget.custodians.isEmpty ? 3 : widget.custodians.length,
    (index) => TextEditingController(
      text: widget.custodians.isEmpty ? '' : widget.custodians[index].publicKey,
    ),
  );
  late List<FocusNode> custodianFocuses = List.generate(
    widget.custodians.isEmpty ? 3 : widget.custodians.length,
    (_) => FocusNode(),
  );

  late FocusNode waitingTimeNode = FocusNode();
  late TextEditingController requireConfirmationController =
      TextEditingController(text: widget.requireConfirmations.toString());

  late TextEditingController waitingTimeController =
      TextEditingController(text: widget.hours.toString());

  /// If true, then some of custodian focuses has focus
  final focusNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    for (final f in custodianFocuses) {
      // ignore: always-remove-listener
      f.addListener(_focusListener);
    }
    waitingTimeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    for (final c in custodianControllers) {
      c.dispose();
    }
    for (final f in custodianFocuses) {
      f
        ..removeListener(_focusListener)
        ..dispose();
    }
    requireConfirmationController.dispose();
    focusNotifier.dispose();
    waitingTimeController.dispose();
    waitingTimeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = context.themeStyleV2.textStyles;

    return Stack(
      children: [
        Positioned.fill(
          bottom: commonButtonHeight,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(DimensSize.d16),
            child: Form(
              key: _formKey,
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: focusNotifier,
                    builder: (context, value, _) {
                      if (value) {
                        return const CommonDivider();
                      }

                      return SeparatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: DimensSize.d12,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: DimensSizeV2.d8),
                              SeparatedRow(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: PrimaryTextField(
                                      textEditingController:
                                          requireConfirmationController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      onSubmit: (_) =>
                                          custodianFocuses.first.requestFocus(),
                                      inputFormatters: [
                                        InputFormatters.noSpacesFormatter,
                                        InputFormatters.onlyDigitsFormatter,
                                      ],
                                      validator: _validateRequireConfirmations,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: DimensSizeV2.d18,
                                    ),
                                    child: Text(
                                      LocaleKeys.outOfNumber.tr(
                                        args: [
                                          custodianControllers.length
                                              .toString(),
                                        ],
                                      ),
                                      style: textStyles.labelSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  if (widget.isWaitingTimeSelectionEnabled)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: DimensSizeV2.d8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.deployWalletWaitingTime.tr(),
                            style: textStyles.labelSmall,
                          ),
                          const SizedBox(height: DimensSizeV2.d8),
                          PrimaryTextField(
                            focusNode: waitingTimeNode,
                            textEditingController: waitingTimeController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSubmit: (_) =>
                                custodianFocuses.first.requestFocus(),
                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys.invalidValue.tr();
                              }
                              final number = int.tryParse(value);
                              if (number == null || number > 24 || number == 0) {
                                return LocaleKeys.invalidValue.tr();
                              }
                              return null;
                            },
                            inputFormatters: [
                              InputFormatters.onlyDigitsFormatter,
                            ],
                            suffixes: [
                              _buildMiniButton(1),
                              _buildMiniButton(2),
                              _buildMiniButton(12),
                              _buildMiniButton(24),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: DimensSizeV2.d12),
                  Text(
                    LocaleKeys.custodiansWord.tr(),
                    style: textStyles.labelSmall,
                  ),
                  ...custodianControllers.mapIndexed(_custodianItem),
                  const SizedBox(height: DimensSizeV2.d8),
                  if (custodianControllers.length < 32)
                    GhostButton(
                      icon: LucideIcons.plus,
                      title: LocaleKeys.addOneMorePublicKey.tr(),
                      onPressed: _addOneCustodian,
                      buttonShape: ButtonShape.pill,
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: DimensSize.d16,
          left: DimensSize.d16,
          right: DimensSize.d16,
          child: Padding(
            padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
            child: AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.nextWord.tr(),
              onPressed: () => _next(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniButton(int hours) {
    final currentValue = waitingTimeController.text.toInt();
    final theme = context.themeStyleV2;
    final isSelected = currentValue == hours;

    return GestureDetector(
      onTap: () {
        setState(() {
          waitingTimeController.text = hours.toString();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: DimensSizeV2.d4),
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d12,
          vertical: DimensSizeV2.d6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
          border: Border.all(
            color: isSelected ? theme.colors.accent : theme.colors.border0,
          ),
          color: isSelected ? theme.colors.accent : Colors.transparent,
        ),
        child: Text(
          '${hours}h',
          style: theme.textStyles.labelSmall.copyWith(
            color:
                isSelected ? theme.colors.background0 : theme.colors.content1,
          ),
        ),
      ),
    );
  }

  Widget _custodianItem(int index, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DimensSizeV2.d4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PrimaryTextField(
              key: ValueKey(controller.hashCode),
              textEditingController: controller,
              focusNode: custodianFocuses[index],
              hintText: LocaleKeys.publicKeyOfCustodianNumber
                  .tr(args: [(index + 1).toString()]),
              textInputAction: index == custodianControllers.length - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              onSubmit: (value) {
                if (index != custodianControllers.length - 1) {
                  custodianFocuses[index + 1].requestFocus();
                } else {
                  _next(context);
                }
              },
              maxLength: publicKeyLength,
              suffixes: [
                ClipboardPasteButton(
                  value: controller,
                  onClear: controller.clear,
                  onPaste: (String text) =>
                      custodianControllers[index].text = text,
                ),
              ],
              inputFormatters: [
                InputFormatters.noSpacesFormatter,
                InputFormatters.publicKeyInputFormatter,
              ],
              validator: _validatePublicKey,
            ),
          ),
          if (index >= minConfirmationsCount)
            Padding(
              padding: const EdgeInsets.only(
                left: DimensSizeV2.d8,
                top: DimensSizeV2.d4,
              ),
              child: DestructiveButton(
                buttonShape: ButtonShape.circle,
                icon: LucideIcons.trash,
                buttonSize: ButtonSize.medium,
                onPressed: () => _removeCustodian(index),
              ),
            ),
        ],
      ),
    );
  }

  void _next(BuildContext context) {
    FocusScope.of(context).unfocus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentState?.validate() ?? false) {
        final hours = int.tryParse(waitingTimeController.text) ?? widget.hours;
        widget.onNext(
          _collectValidKeys(),
          _collectRequireConfirmations(),
          hours,
        );
      }
    });
  }

  /// Get list of valid public keys
  List<PublicKey> _collectValidKeys() => custodianControllers
      .where((v) => _validatePublicKey(v.text) == null)
      .map((v) => PublicKey(publicKey: v.text))
      .toList();

  int _collectRequireConfirmations() {
    if (_validateRequireConfirmations(requireConfirmationController.text) ==
        null) {
      return int.parse(requireConfirmationController.text);
    }

    return defaultRequireConfirmations;
  }

  String? _validatePublicKey(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.invalidValue.tr();
    }

    if (!_alphanumeric.hasMatch(value)) {
      return LocaleKeys.invalidValue.tr();
    }

    if (value.length != publicKeyLength) {
      return LocaleKeys.invalidLengthMustBe
          .tr(args: [publicKeyLength.toString()]);
    }

    return null;
  }

  String? _validateRequireConfirmations(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.invalidValue.tr();
    }

    final number = int.tryParse(value);

    if (number == null || number < 1 || number > custodianControllers.length) {
      return LocaleKeys.invalidValue.tr();
    }

    return null;
  }

  void _focusListener() =>
      focusNotifier.value = custodianFocuses.any((f) => f.hasFocus);

  void _addOneCustodian() {
    setState(() {
      custodianFocuses.add(FocusNode()..addListener(_focusListener));
      custodianControllers.add(TextEditingController());
    });
  }

  void _removeCustodian(int index) {
    setState(() {
      custodianControllers.removeAt(index).dispose();
      custodianFocuses.removeAt(index)
        ..removeListener(_focusListener)
        ..dispose();
    });
  }
}
