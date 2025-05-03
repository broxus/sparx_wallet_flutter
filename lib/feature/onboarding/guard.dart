import 'dart:async';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/feature/onboarding/route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Interceptor that redirects to onboarding if the user doesn't have any seeds.
@singleton
class OnboardingGuard extends CompassGuard {
  OnboardingGuard(
    this._bootstrapService,
    this._nekotonRepository,
  ) : super(priority: priorityHigh);

  final BootstrapService _bootstrapService;
  final NekotonRepository _nekotonRepository;
  final _log = Logger('OnboardingGuard');

  StreamSubscription<bool>? _seedsSubscription;
  CompassRouter? _router;

  @override
  void attachToRouter(CompassRouter router) {
    _router = router;
    _seedsSubscription = _nekotonRepository.hasSeeds.listen(_listenSeed);
  }

  @override
  void detach() {
    _seedsSubscription?.cancel();
    _router = null;
  }

  @override
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  ) {
    final hasSeeds = _nekotonRepository.hasSeeds.valueOrNull;
    final rootRoute = location.firstOrNull;

    if (!_bootstrapService.isConfigured || hasSeeds == null) {
      return null;
    }

    if (!hasSeeds && rootRoute is! OnBoardingRoute) {
      // Not onboarded, redirect to onboarding
      _log.info('No seeds, redirecting to onboarding');
      return OnBoardingRouteData();
    }

    // No need to redirect
    return null;
  }

  void _listenSeed(bool hasSeeds) {
    final router = _router;
    final rootRoutePath = _router?.currentRoutes.firstOrNull;
    if (rootRoutePath == null || router == null) return;

    if (!hasSeeds && rootRoutePath is! OnBoardingRoute) {
      _log.info('No seeds, redirecting to onboarding');
      _router?.compassPoint(OnBoardingRouteData());
    }
  }
}
