import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_model.dart';
import 'package:app/feature/wallet/wallet_deploy/widgets/wallet_select_deploy_type_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows deploy wallet with standard type
class WalletDeployStandardBody extends StatelessWidget {
  const WalletDeployStandardBody({
    this.onDeploy,
    this.onChangeType,
    super.key,
  });

  final VoidCallback? onDeploy;
  final ValueChanged<WalletDeployType>? onChangeType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d16),
      child: SeparatedColumn(
        children: [
          WalletSelectDeployTypeWidget(
            type: WalletDeployType.standard,
            onChangeType: onChangeType,
          ),
          const Spacer(),
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.nextWord.tr(),
            onPressed: onDeploy,
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
