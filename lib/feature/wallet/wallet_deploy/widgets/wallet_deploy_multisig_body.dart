// ignore_for_file: lines_longer_than_80_chars

import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

final _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

const publicKeyLength = 64;

/// Minimum quantity of custodians for [WalletDeployType.multisig]
const minConfirmationsCount = 2;

/// Widget that allows prepare data for multisig deploy.
class WalletDeployMultisigBody extends StatefulWidget {
  const WalletDeployMultisigBody({
    required this.custodians,
    required this.requireConfirmations,
    super.key,
  });

  /// This data is just initial data and not used during lifecycle.
  final List<PublicKey> custodians;
  final int requireConfirmations;

  @override
  State<WalletDeployMultisigBody> createState() =>
      _WalletDeployMultisigBodyState();
}

class _WalletDeployMultisigBodyState extends State<WalletDeployMultisigBody> {
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
  late TextEditingController requireConfirmationController =
      TextEditingController(text: widget.requireConfirmations.toString());

  /// If true, then some of custodian focuses has focus
  final focusNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    for (final f in custodianFocuses) {
      // ignore: always-remove-listener
      f.addListener(_focusListener);
    }
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
    super.dispose();
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

  Future<void> _pasteCustodian(int index) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      custodianControllers[index].text = data!.text!;
    }
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
                separatorSize: DimensSize.d16,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: focusNotifier,
                    builder: (context, value, _) {
                      if (value) {
                        return const CommonDivider();
                      }

                      return SeparatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        separatorSize: DimensSize.d16,
                        children: [
                          WalletSelectDeployTypeWidget(
                            type: WalletDeployType.multisig,
                            onChangeAction: (context) =>
                                context.read<WalletDeployBloc>().add(
                                      WalletDeployEvent.updateMultisigData(
                                        _collectValidKeys(),
                                        _collectRequireConfirmations(),
                                      ),
                                    ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${LocaleKeys.evaluationConfirmation.tr()} ',
                                  style: textStyles.labelSmall,
                                  children: [
                                    TextSpan(
                                      text: LocaleKeys.outOfNumber.tr(
                                        args: [
                                          custodianControllers.length
                                              .toString(),
                                        ],
                                      ),
                                      style: textStyles.paragraphXSmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: DimensSizeV2.d8),
                              PrimaryTextField(
                                textEditingController:
                                    requireConfirmationController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSubmit: (_) =>
                                    custodianFocuses.first.requestFocus(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                ],
                                validator: _validateRequireConfirmations,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Text(
                    LocaleKeys.custodiansWord.tr(),
                    style: textStyles.headingLarge,
                  ),
                  ...custodianControllers.mapIndexed(_custodianItem),
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
          child: PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.nextWord.tr(),
            onPressed: () => _next(context),
          ),
        ),
      ],
    );
  }

  Widget _custodianItem(int index, TextEditingController controller) {
    return Builder(
      builder: (context) {
        return Row(
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
                suffixes: [_custodianSuffixIcon(controller, index)],
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  FilteringTextInputFormatter.allow(RegExp('[a-fA-F0-9]')),
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
        );
      },
    );
  }

  Widget _custodianSuffixIcon(
    TextEditingController controller,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: DimensSize.d8),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return value.text.isNotEmpty
              ? PrimaryButton(
                  buttonShape: ButtonShape.square,
                  icon: LucideIcons.x,
                  buttonSize: ButtonSize.small,
                  onPressed: controller.clear,
                )
              : PrimaryButton(
                  buttonShape: ButtonShape.square,
                  icon: LucideIcons.clipboardPaste,
                  buttonSize: ButtonSize.small,
                  onPressed: () => _pasteCustodian(index),
                );
        },
      ),
    );
  }

  void _next(BuildContext context) {
    FocusScope.of(context).unfocus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentState?.validate() ?? false) {
        context.read<WalletDeployBloc>().add(
              WalletDeployEvent.deployMultisig(
                _collectValidKeys(),
                _collectRequireConfirmations(),
              ),
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
}
