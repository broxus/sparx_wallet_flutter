import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point for screen with information about account
class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({
    required this.address,
    super.key,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountDetailCubit>(
      create: (_) => AccountDetailCubit(
        address: address,
        nekotonRepository: inject<NekotonRepository>(),
        balanceService: inject(),
        convertService: inject(),
      )..init(),
      child: BlocConsumer<AccountDetailCubit, AccountDetailState>(
        listener: (context, state) => switch (state) {
          AccountDetailStateEmpty() => context.compassBack(),
          _ => null,
        },
        builder: (context, state) {
          return switch (state) {
            AccountDetailStateData(
              :final account,
              :final balance,
              :final custodians,
            ) =>
              Scaffold(
                appBar: DefaultAppBar(
                  actions: [
                    FloatButton(
                      buttonShape: ButtonShape.circle,
                      icon: LucideIcons.cog,
                      buttonSize: ButtonSize.medium,
                      onPressed: () => showAccountSettingsSheet(
                        context: context,
                        address: account.address,
                        showHiding: false,
                      ),
                    ),
                  ],
                ),
                body: AccountDetailView(
                  account: account,
                  balance: balance,
                  custodians: custodians,
                ),
              ),
            _ => const Scaffold(
                appBar: DefaultAppBar(),
              ),
          };
        },
      ),
    );
  }
}
