import 'package:app/app/router/router.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final RegExp _parameterRegExp = RegExp(r':(\w+)(\((?:\\.|[^\\()])+\))?');

enum AppRoute {
  bootstrapFailedInit(
    'bootstrapFailed',
    '/bootstrapFailed/:$bootstrapFailedIndexPathParam',
  ),
  splash(
    'splash',
    '/splash',
  ),
  noInternet(
    'noInternet',
    '/noInternet',
  ),
  onboarding(
    'onboarding',
    '/onboarding',
    isSaveLocation: true,
  ),
  updateVersion(
    'updateVersion',
    '/updateVersion',
  ),

  /// Network selection
  chooseNetwork(
    'chooseNetwork',
    'chooseNetwork',
  ),

  /// Wallet section
  wallet(
    'wallet',
    '/wallet',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
    overrideExtendScaffoldBody: true,
  ),
  selectNewAsset(
    '',
    'selectNewAsset/:$selectNewAssetAddressPathParam',
  ),
  tonWalletDetails(
    '',
    'tonWalletDetails/:$tonWalletDetailsAddressPathParam',
  ),
  tokenWalletDetails(
    '',
    'tonWalletDetails/:$tokenWalletDetailsOwnerAddressPathParam/:$tokenWalletDetailsContractAddressPathParam',
  ),
  walletPrepareTransfer(
    '',
    'walletPrepareTransfer/:$walletPrepareTransferAddressPathParam',
  ),
  walletPrepareTransferSpecified(
    '',
    'walletPrepareTransfer/:$walletPrepareTransferAddressPathParam/:$walletPrepareTransferRootTokenAddressPathParam/:$walletPrepareTransferSymbolPathParam',
  ),
  tonWalletSend(
    '',
    'tonWalletSend', // all data in query
  ),
  tokenWalletSend(
    '',
    'tokenWalletSend', // all data in query
  ),
  walletDeploy(
    '',
    'walletDeploy/:$walletDeployAddressPathParam/:$walletDeployPublicKeyPathParam',
  ),
  confirmMultisigTransaction(
    '',
    'tonConfirmTransaction', // all data in query
  ),
  walletStake(
    '',
    'walletStake/:$walletStakeAddressPathParam',
  ),
  walletCancelUnstaking(
    '',
    'walletCancelUnstaking', // all data in query
  ),
  walletAddAccount(
    'walletAddAccount',
    'walletAddAccount',
  ),
  walletSelectSeed(
    '',
    'walletSelectSeed',
  ),
  walletNewAccount(
    '',
    'walletNewAccount', // all data in query
  ),
  walletNewExternalAccount(
    '',
    'walletNewExternalAccount', // all data in query
  ),

  /// Browser section
  browser(
    'browser',
    '/browser',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
    isSaveSubroutes: true,
  ),

  /// Profile section
  profile(
    'profile',
    '/profile',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
    isSaveSubroutes: true,
  ),
  manageSeedsAccounts(
    'manageSeeds',
    'manageSeeds',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),
  seedDetail(
    '',
    'seedDetail/:$seedDetailPublicKeyPathParam',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),
  keyDetail(
    '',
    'keyDetail/:$keyDetailPublicKeyPathParam',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),
  accountDetail(
    '',
    'accountDetail/:$accountDetailAddressPathParam',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),

  /// Adding seed
  createSeed(
    '',
    'createSeed',
    isSaveLocation: true,
  ),
  createSeedNamed(
    '',
    'createSeed/:$enterSeedNameNamePathParam',
    isSaveLocation: true,
  ),
  enterSeed(
    '',
    'enterSeed',
    isSaveLocation: true,
  ),
  enterSeedNamed(
    '',
    'enterSeed/:$enterSeedNameNamePathParam',
    isSaveLocation: true,
  ),
  addExistingWallet(
    'addExistingWallet',
    'addExistingWallet',
    isSaveLocation: true,
  ),
  importWallet(
    '',
    'importWallet',
    isSaveLocation: true,
  ),

  // command flag means: 'import' - import, 'create' (or other) - create,
  // see <enterSeedNameImportCommand> and <enterSeedNameCreateCommand>.
  enterSeedName(
    '',
    'enterSeedName/:$enterSeedNameCommandPathParam',
    isSaveLocation: true,
  ),
  checkSeed(
    '',
    'checkSeed',
  ),
  createSeedPassword(
    '',
    'createSeedPassword',
    isSaveLocation: true,
  ),
  enableBiometry(
    '/enableBiometry',
    'enableBiometry',
  ),
  custodiansSettings(
    '',
    'custodiansSettings',
  ),

  /// Browser section

  /// Configure networks page
  configureNetworks(
    'configureNetworks',
    'configureNetworks',
    isSaveLocation: true,
  ),

  /// Edit network page
  editNetwork(
    'editNetwork',
    'editNetwork',
    isSaveLocation: true,
  );

  const AppRoute(
    this.name,
    this.path, {
    this.isSaveLocation = false,
    this.isBottomNavigationBarVisible = false,
    this.isSaveSubroutes = false,
    this.overrideExtendScaffoldBody = false,
  });

  static final _log = Logger('AppRoute');

  final String name;
  final String path;

  /// If location is saved in NavigationService.
  final bool isSaveLocation;

  /// Should BottomNavigationBar be visible.
  final bool isBottomNavigationBarVisible;

  /// Additional field that allows use [Scaffold.extendBody] in <RootView> to
  /// hide content behind bottom nav bar.
  final bool overrideExtendScaffoldBody;

  /// Should subroutes be saved and restored when user navigates between
  /// root routes. It's effective only for root routes
  final bool isSaveSubroutes;

  static AppRoute? getByPath(String path) {
    // ignore: prefer-enums-by-name
    return AppRoute.values.firstWhereOrNull(
      (e) => e.path == path,
    );
  }

  static AppRoute get defaultRoute => splash;

  // Reconstructs the full path from a [pattern] and path parameters.
  // This thing is directly copied from the go_router package ¯\_(ツ)_/¯
  ///
  /// This is useful for restoring the original path from a [RegExpMatch].
  ///
  /// For example, A path matched a [RegExp] returned from patternToRegExp and
  /// produced a [RegExpMatch]. To reconstruct the path from the match, one
  /// can follow these steps:
  ///
  /// 1. Get the `pathParameters` by calling extractPathParameters with the
  ///    [RegExpMatch] and the parameters used for generating the [RegExp].
  /// 2. Call [patternToPath] with the `pathParameters` from the first step and
  ///    the original `pattern` used for generating the [RegExp].
  String patternToPath(String pattern, Map<String, String> pathParameters) {
    final buffer = StringBuffer();
    var start = 0;
    for (final match in _parameterRegExp.allMatches(pattern)) {
      if (match.start > start) {
        buffer.write(pattern.substring(start, match.start));
      }
      final name = match[1]!;
      buffer.write(pathParameters[name]);
      start = match.end;
    }

    if (start < pattern.length) {
      buffer.write(pattern.substring(start));
    }

    return buffer.toString();
  }

  /// Helper method, that allows add path and query parameter to [path].
  String pathWithData({
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
  }) {
    final encodedParams = <String, String>{
      for (final MapEntry<String, String> param in pathParameters.entries)
        param.key: Uri.encodeComponent(param.value),
    };
    final encodedQuery = queryParameters.isEmpty
        ? null
        : <String, String>{
            for (final param in queryParameters.entries)
              param.key: Uri.encodeQueryComponent(param.value),
          };

    final location = patternToPath(path, encodedParams);

    return Uri(
      path: location,
      queryParameters: encodedQuery,
    ).toString();
  }

  /// Returns path segments from [fullPath]. It's a wrapper for
  /// [Uri.pathSegments], but for the first segment adds slash.
  /// Also it filters and joins segments that contains parameters.
  /// We are strongly recommend to use this method instead
  /// of [Uri.pathSegments].
  static List<String> pathSegments({required String fullPath}) {
    final uri = Uri.parse(fullPath);
    if (uri.pathSegments.isEmpty) return [];

    final segments = [...uri.pathSegments]
      ..replaceRange(0, 1, ['/${uri.pathSegments.first}']);

    final filteredSegments =
        segments.fold(<String>[], (previousValue, element) {
      if (element.startsWith(':')) {
        if (previousValue.isEmpty) {
          // Don't know what to do with this case
          return [element];
        }
        final [...rest, last] = previousValue;

        return [...rest, '$last/$element'];
      }

      return [...previousValue, element];
    });

    return filteredSegments
        .where((segment) => AppRoute.getByPath(segment) != null)
        .toList();
  }
}

/// Get first segment from [fullPath].
String getRootPath({required String fullPath}) {
  try {
    final segments = AppRoute.pathSegments(fullPath: fullPath);
    if (segments.isEmpty) {
      AppRoute._log.severe('getRootPath: no root location found');
      return AppRoute.defaultRoute.path;
    }
    return segments.first;
  } catch (_) {
    return '/';
  }
}

/// Get last segment from [fullPath].
String getCurrentPath({required String? fullPath}) {
  if (fullPath == null) {
    return AppRoute.defaultRoute.path;
  }

  final segments = AppRoute.pathSegments(fullPath: fullPath);
  if (segments.isEmpty) {
    AppRoute._log.severe('getCurrentPath: no current location found');

    return AppRoute.defaultRoute.path;
  }

  return segments.last;
}

/// Get first segment from [fullPath] and return [AppRoute].
AppRoute getRootAppRoute({required String fullPath}) {
  return AppRoute.getByPath(getRootPath(fullPath: fullPath)) ??
      AppRoute.defaultRoute;
}

/// Get last segment from [fullPath] and return [AppRoute].
AppRoute getCurrentAppRoute({required String? fullPath}) {
  return fullPath != null
      ? AppRoute.getByPath(getCurrentPath(fullPath: fullPath)) ??
          AppRoute.getByPath(fullPath) ??
          AppRoute.defaultRoute
      : AppRoute.defaultRoute;
}

/// Returns true, if every segment from [fullPath] can be saved in
/// NavigationService.
bool canSaveLocation({required String fullPath}) {
  return AppRoute.pathSegments(fullPath: fullPath)
      .every((segment) => AppRoute.getByPath(segment)?.isSaveLocation ?? false);
}

extension NavigationContextHelper on BuildContext {
  GoRouter? get goRouter => mounted ? GoRouter.of(this) : null;

  /// Navigate to a location above current.
  /// Instead of:
  /// ```
  /// onPressed: () => context.go(
  ///   '${AppRoute.onboarding.path}/${AppRoute.multiuse.path}',
  /// ),
  /// ```
  ///
  /// USE:
  /// ```
  /// onPressed: () => context.goFurther(AppRoute.multiuse.path),
  /// ```
  void goFurther(
    String location, {
    bool preserveQueryParams = false,
    Object? extra,
  }) {
    return goRouter?.goFurther(
      location,
      preserveQueryParams: preserveQueryParams,
      extra: extra,
    );
  }

  Future<T?> pushFurther<T>(
    String location, {
    bool preserveQueryParams = false,
    Object? extra,
  }) async {
    return goRouter?.pushFurther<T>(
      location,
      preserveQueryParams: preserveQueryParams,
      extra: extra,
    );
  }

  /// Navigate to current location, but without query parameters.
  void clearQueryParams() {
    return goRouter?.clearQueryParams();
  }

  /// Pop current screen if possible.
  void maybePop({
    bool preserveQueryParams = true,
    List<String>? removeQueries,
  }) {
    goRouter?.maybePop(
      preserveQueryParams: preserveQueryParams,
      removeQueries: removeQueries,
    );
  }

  void clearQueryParamsAndPop<T extends Object?>([T? result]) {
    goRouter?.clearQueryParamsAndPop<T>(result);
  }
}
