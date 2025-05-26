import 'package:app/app/router/router.dart';
import 'package:app/feature/onboarding/route.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({
    required this.isOnboarding,
    super.key,
  });

  final bool isOnboarding;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isOnboarding) {
        context.compassPointNamed(
          const OnBoardingRouteData(),
        );
      } else {
        context.compassPointNamed(
          const WalletRouteData(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background0,
      ),
    );
  }
}
