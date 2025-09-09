import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_screen.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Page that allows deploy wallet with [address] and [publicKey]
class WalletDeployPage extends StatelessWidget {
  const WalletDeployPage({
    required this.address,
    required this.publicKey,
    super.key,
  });

  final Address address;
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    return WalletDeployScreen(
      address: address,
      publicKey: publicKey,
    );
  }
}
