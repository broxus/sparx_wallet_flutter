import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows deploy wallet with standard type
class WalletDeployStandardBody extends StatelessWidget {
  const WalletDeployStandardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d16),
      child: SeparatedColumn(
        children: [
          const WalletSelectDeployTypeWidget(
            type: WalletDeployType.standard,
          ),
          const Spacer(),
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.nextWord.tr(),
            onPressed: () => context
                .read<WalletDeployBloc>()
                .add(const WalletDeployEvent.deployStandard()),
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
