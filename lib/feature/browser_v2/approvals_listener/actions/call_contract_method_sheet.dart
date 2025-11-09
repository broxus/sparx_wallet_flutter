import 'package:app/feature/browser_v2/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows sheet to call contract method.
/// Is used by `executeLocal`, `sendExternalMessage`,
/// and `sendExternalMessageDelayed` inpage-provider methods.
///
/// Returns [SignInputAuth] if user confirmed action
/// with password/ledger or null.
Future<SignInputAuth?> showCallContractMethodSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required PublicKey publicKey,
  required Address recipient,
  required FunctionCall payload,
  required SignInputAuthLedger signInputAuthLedger,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.callContractMethod.tr(),
    centerTitle: true,
    body: (_, controller) => _CallContractMethod(
      origin: origin,
      account: account,
      publicKey: publicKey,
      recipient: recipient,
      payload: payload,
      signInputAuthLedger: signInputAuthLedger,
      scrollController: controller,
    ),
  );
}

class _CallContractMethod extends StatelessWidget {
  const _CallContractMethod({
    required this.origin,
    required this.account,
    required this.publicKey,
    required this.recipient,
    required this.payload,
    required this.signInputAuthLedger,
    required this.scrollController,
  });

  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final Address recipient;
  final FunctionCall payload;
  final SignInputAuthLedger signInputAuthLedger;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              spacing: DimensSizeV2.d12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccountInfoWidget(account: account),
                WebsiteInfoWidget(uri: origin),
                ExpandableCard(
                  collapsedHeight: DimensSizeV2.d256,
                  child: SeparatedColumn(
                    spacing: DimensSizeV2.d16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.metadata.tr(),
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      FunctionCallBody(payload: payload, contract: recipient),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidget.auth(
          getLedgerAuthInput: () => signInputAuthLedger,
          publicKey: publicKey,
          title: LocaleKeys.confirm.tr(),
          onConfirmed: (auth) => Navigator.of(context).pop(auth),
        ),
      ],
    );
  }
}
