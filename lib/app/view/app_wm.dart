import 'dart:async';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/app/view/app.dart';
import 'package:app/app/view/app_model.dart';
import 'package:app/app/view/message_viewer.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/onboarding/route.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// [WidgetModel] для [App]
@injectable
class AppWidgetModel extends CustomWidgetModel<App, AppModel> {
  AppWidgetModel(super.model);

  final _logger = Logger('AppWidgetModel');

  late final _messageViewer = MessageViewer(
    messagesExistStream: model.messagesExistStream,
    getRootContext: () => model.navContext,
    getMessage: model.getMessage,
  );

  late final router = model.router;

  StreamSubscription<BootstrapSteps>? _bootstrapStepsSubs;

  List<LocalizationsDelegate<dynamic>> get localizationDelegates =>
      context.localizationDelegates;

  List<Locale> get supportedLocales => context.supportedLocales;

  Locale get locale => context.locale;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _messageViewer.init();
    _bootstrapStepsSubs = model.bootstrapStepStream.listen(
      _listenBootstrapStep,
    );
  }

  @override
  void dispose() {
    _messageViewer.dispose();
    _bootstrapStepsSubs?.cancel();
    super.dispose();
  }

  Future<bool> checkCrashDetected() => model.checkCrashDetected();

  Future<void> _listenBootstrapStep(BootstrapSteps step) async {
    if (step != BootstrapSteps.completed) return;

    await _bootstrapStepsSubs?.cancel();
    _bootstrapStepsSubs = null;

    if (model.hasSeeds == false) {
      _logger.info('Initial navigation. Navigate to onboarding');
      router.compassPoint(const OnBoardingRouteData());
      return;
    }

    final savedNavigation = await model.getSavedNavigation();

    if (savedNavigation != null) {
      _logger.info('Initial navigation. Navigate to $savedNavigation');
      // Use CompassRouter methods for all navigation to maintain consistency
      router.compassPoint(
        UnsafeRedirectCompassRouteData(route: savedNavigation),
      );
    } else {
      _logger.info('Initial navigation. Navigate to wallet');
      router.compassPoint(const WalletRouteData());
    }
  }
}
