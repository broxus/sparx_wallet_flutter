import 'package:app/app/router/app_route.dart';
import 'package:app/feature/nft/my_nft_page/empty_nft_list.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class MyNftPage extends StatelessWidget {
  const MyNftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const WalletAppBarWidget(),
            Spacer(),
            EmptyNftList(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
