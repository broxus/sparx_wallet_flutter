import 'package:app/di/di.dart';
import 'package:app/feature/bootstrap_failed/bootstrap_failed.dart';
import 'package:app/feature/network/bottom_sheets/select_network/select_network_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows user to change network during bootstrap process if
/// original network failed to connect.
@Deprecated('Use ConnectionFailScreen')
class BootstrapRetryConnectionView extends StatelessWidget {
  @Deprecated('Use ConnectionFailScreen')
  const BootstrapRetryConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return BlocProvider<RetryConnectionCubit>(
      create: (_) => RetryConnectionCubit(
        inject(),
        inject(),
      ),
      child: BlocListener<RetryConnectionCubit, void>(
        // idk why, but without creating listener, provider doesn't creates cub
        // ignore: no-empty-block
        listener: (_, __) {},
        child: SeparatedColumn(
          spacing: DimensSize.d16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
              child: Text(
                LocaleKeys.connectingNetworkFailed.tr(),
                style: StyleRes.h2.copyWith(color: colors.textPrimary),
              ),
            ),
            const Expanded(
              child: SelectNetworkWidget(
                needPopAfterAction: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
