// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:encrypted_storage/encrypted_storage.dart' as _i426;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i171;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nekoton_repository/nekoton_repository.dart' as _i771;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i1067;

import '../app/router/compass/compass.dart' as _i82;
import '../app/router/router.dart' as _i309;
import '../app/service/app_lifecycle_service.dart' as _i830;
import '../app/service/app_links/app_links.dart' as _i850;
import '../app/service/app_links/app_links_service.dart' as _i746;
import '../app/service/app_permissions_service.dart' as _i1070;
import '../app/service/app_version_service.dart' as _i143;
import '../app/service/approvals_service.dart' as _i654;
import '../app/service/assets_service.dart' as _i964;
import '../app/service/balance_service.dart' as _i637;
import '../app/service/biometry_service.dart' as _i575;
import '../app/service/bootstrap/bootstrap_service.dart' as _i468;
import '../app/service/connection/connection_service.dart' as _i754;
import '../app/service/currencies_service.dart' as _i308;
import '../app/service/currency_convert_service.dart' as _i27;
import '../app/service/current_accounts_service.dart' as _i402;
import '../app/service/current_seed_service.dart' as _i244;
import '../app/service/identify/i_identify_icons_service.dart' as _i958;
import '../app/service/identify/identify_icons_service.dart' as _i316;
import '../app/service/js_servcie.dart' as _i157;
import '../app/service/localization/service/localization_service.dart' as _i5;
import '../app/service/navigation_service.dart' as _i275;
import '../app/service/nekoton_related/current_key_service.dart' as _i272;
import '../app/service/nekoton_related/gas_price_service.dart' as _i818;
import '../app/service/nekoton_related/nekoton_related.dart' as _i403;
import '../app/service/network_connection/network_connection_service.dart'
    as _i33;
import '../app/service/ntp_service.dart' as _i68;
import '../app/service/permissions_service.dart' as _i473;
import '../app/service/presets_connection/presets_connection_service.dart'
    as _i116;
import '../app/service/remote/dns_resolve_service.dart' as _i391;
import '../app/service/resources_service.dart' as _i104;
import '../app/service/service.dart' as _i128;
import '../app/service/session/session_service.dart' as _i299;
import '../app/service/staking_service.dart' as _i209;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i747;
import '../app/service/storage_service/app_storage_service.dart' as _i184;
import '../app/service/storage_service/balance_storage_service.dart' as _i1020;
import '../app/service/storage_service/connections_storage_service.dart'
    as _i65;
import '../app/service/storage_service/general_storage_service.dart' as _i747;
import '../app/service/storage_service/nekoton_repository_service.dart'
    as _i386;
import '../app/service/storage_service/secure_storage_service.dart' as _i679;
import '../app/service/storage_service/storage_manager_service.dart' as _i725;
import '../app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart'
    as _i738;
import '../app/service/storage_service/ton_connect_storage_service.dart'
    as _i1068;
import '../app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart'
    as _i139;
import '../app/service/token_wallets_service.dart' as _i877;
import '../app/service/ton_connect/ton_connect_http_bridge.dart' as _i770;
import '../app/service/ton_connect/ton_connect_js_bridge.dart' as _i186;
import '../app/service/ton_connect/ton_connect_service.dart' as _i175;
import '../feature/add_seed/add_existing_wallet/route.dart' as _i852;
import '../feature/add_seed/create_password/route.dart' as _i473;
import '../feature/add_seed/enter_seed_phrase/route.dart' as _i741;
import '../feature/add_seed/import_wallet/route.dart' as _i176;
import '../feature/biometry/view/route.dart' as _i434;
import '../feature/bootstrap_failed/route.dart' as _i501;
import '../feature/browser_v2/domain/service/browser_service.dart' as _i470;
import '../feature/browser_v2/domain/service/storages/browser_bookmarks_storage_service.dart'
    as _i213;
import '../feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart'
    as _i234;
import '../feature/browser_v2/domain/service/storages/browser_history_storage_service.dart'
    as _i581;
import '../feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart'
    as _i229;
import '../feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart'
    as _i634;
import '../feature/browser_v2/route.dart' as _i537;
import '../feature/choose_network/route.dart' as _i805;
import '../feature/messenger/domain/service/messenger_service.dart' as _i632;
import '../feature/network/configure_networks/route.dart' as _i1004;
import '../feature/network/edit_network/route.dart' as _i217;
import '../feature/nft/domain/nft_service.dart' as _i263;
import '../feature/nft/domain/nft_storage_service.dart' as _i336;
import '../feature/nft/nft.dart' as _i1015;
import '../feature/nft/route.dart' as _i4;
import '../feature/no_internet/route.dart' as _i225;
import '../feature/onboarding/guard.dart' as _i13;
import '../feature/onboarding/route.dart' as _i1010;
import '../feature/presets_config/domain/presets_config_reader.dart' as _i130;
import '../feature/presets_config/presets_config.dart' as _i418;
import '../feature/profile/account_detail/route.dart' as _i303;
import '../feature/profile/key_detail/route.dart' as _i171;
import '../feature/profile/manage_seeds_accounts/route.dart' as _i45;
import '../feature/profile/route.dart' as _i302;
import '../feature/profile/seed_detail/route.dart' as _i649;
import '../feature/root/restore_subroutes_guard.dart' as _i331;
import '../feature/root/view/guard.dart' as _i48;
import '../feature/root/view/route.dart' as _i786;
import '../feature/splash/route.dart' as _i592;
import '../feature/update_version/domain/latest_version_finder.dart' as _i803;
import '../feature/update_version/domain/storage/update_version_storage_service.dart'
    as _i1030;
import '../feature/update_version/domain/store_url_generator.dart' as _i934;
import '../feature/update_version/domain/update_service.dart' as _i720;
import '../feature/update_version/domain/update_status_checker.dart' as _i1008;
import '../feature/update_version/domain/version_comparator.dart' as _i728;
import '../feature/update_version/guard.dart' as _i169;
import '../feature/update_version/route.dart' as _i562;
import '../feature/update_version/update_version.dart' as _i484;
import '../feature/wallet/confirm_multisig_transaction/route.dart' as _i693;
import '../feature/wallet/custodians_settings/route.dart' as _i1052;
import '../feature/wallet/new_account/add_external_account/route.dart' as _i971;
import '../feature/wallet/new_account/route.dart' as _i986;
import '../feature/wallet/new_account/screen/route.dart' as _i229;
import '../feature/wallet/new_account/select_seed/route.dart' as _i278;
import '../feature/wallet/route.dart' as _i113;
import '../feature/wallet/staking/view/cancel_unstaking_page/route.dart'
    as _i420;
import '../feature/wallet/staking/view/staking_page/route.dart' as _i450;
import '../feature/wallet/token_wallet_details/route.dart' as _i750;
import '../feature/wallet/token_wallet_send/route.dart' as _i290;
import '../feature/wallet/ton_wallet_details/route.dart' as _i512;
import '../feature/wallet/ton_wallet_send/route.dart' as _i72;
import '../feature/wallet/wallet_deploy/route.dart' as _i211;
import '../feature/wallet/wallet_prepare_transfer/route.dart' as _i650;
import '../feature/wallet/widgets/account_asset_tab/select_new_asset/route.dart'
    as _i182;
import '../http/api/presets/presets_api.dart' as _i249;
import '../http/api/token/token_api.dart' as _i639;
import '../http/api/ton/ton_api.dart' as _i162;
import '../http/dio_module.dart' as _i720;
import '../http/http.dart' as _i188;
import '../http/repository/token_repository.dart' as _i700;
import '../http/repository/ton_repository.dart' as _i495;
import '../v1/feature/add_seed/check_seed_phrase/route.dart' as _i118;
import '../v1/feature/add_seed/create_seed/route.dart' as _i646;
import '../v1/feature/add_seed/enter_seed_name/route.dart' as _i643;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i171.EncryptedStoragePackageModule().init(gh);
    await _i1067.NekotonRepositoryPackageModule().init(gh);
    final dioModule = _$DioModule();
    gh.factory<_i728.VersionComparator>(() => _i728.VersionComparator());
    gh.singleton<_i738.TokenWalletStorageService>(
        () => _i738.TokenWalletStorageService());
    gh.singleton<_i139.TonWalletStorageService>(
        () => _i139.TonWalletStorageService());
    gh.singleton<_i143.AppVersionService>(() => _i143.AppVersionService());
    gh.singleton<_i157.JsService>(() => _i157.JsService());
    gh.singleton<_i746.AppLinksService>(
      () => _i746.AppLinksService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i104.ResourcesService>(() => _i104.ResourcesService());
    gh.singleton<_i830.AppLifecycleService>(() => _i830.AppLifecycleService());
    gh.singleton<_i1070.AppPermissionsService>(
        () => _i1070.AppPermissionsService());
    gh.singleton<_i5.LocalizationService>(() => _i5.LocalizationService());
    gh.singleton<_i33.NetworkConnectionService>(
        () => _i33.NetworkConnectionService());
    gh.singleton<_i27.CurrencyConvertService>(
        () => _i27.CurrencyConvertService());
    gh.singleton<_i391.DnsResolveService>(() => _i391.DnsResolveService());
    gh.singleton<_i654.BrowserApprovalsService>(
        () => _i654.BrowserApprovalsService());
    gh.lazySingleton<_i361.Dio>(() => dioModule.getDio());
    gh.lazySingleton<_i632.MessengerService>(
      () => _i632.MessengerService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i747.NekotonStorageService>(() =>
        _i747.NekotonStorageService(storage: gh<_i426.EncryptedStorage>()));
    gh.singleton<_i229.BrowserPermissionsStorageService>(() =>
        _i229.BrowserPermissionsStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_permissions')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i592.SplashScreenRoute(),
      instanceName: 'SplashScreenRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i290.TokenWalletSendRoute(),
      instanceName: 'TokenWalletSendRoute',
    );
    gh.singleton<_i679.SecureStorageService>(
        () => _i679.SecureStorageService(gh<_i426.EncryptedStorage>()));
    gh.lazySingleton<_i1030.UpdateVersionStorageService>(() =>
        _i1030.UpdateVersionStorageService(gh<_i792.GetStorage>(
            instanceName: 'update_version_storage_service')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i229.NewAccountRoute(),
      instanceName: 'NewAccountRoute',
    );
    gh.singleton<_i275.NavigationService>(
        () => _i275.NavigationService(gh<_i426.EncryptedStorage>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1052.CustodiansSettingsRoute(),
      instanceName: 'CustodiansSettingsRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i434.EnableBiometryRoute(),
      instanceName: 'EnableBiometryRoute',
    );
    gh.singleton<_i209.StakingService>(() => _i209.StakingService(
          gh<_i771.NekotonRepository>(),
          gh<_i361.Dio>(),
          gh<_i104.ResourcesService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i693.ConfirmMultisigTransactionRoute(),
      instanceName: 'ConfirmMultisigTransactionRoute',
    );
    gh.singleton<_i1068.TonConnectStorageService>(() =>
        _i1068.TonConnectStorageService(
            gh<_i792.GetStorage>(instanceName: 'ton_connect_storage_service')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i225.NoInternetRoute(),
      instanceName: 'NoInternetRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i303.AccountDetailRoute(),
      instanceName: 'AccountDetailRoute',
    );
    gh.lazySingleton<_i175.TonConnectService>(() => _i175.TonConnectService(
          gh<_i128.TonConnectStorageService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i143.AppVersionService>(),
          gh<_i361.Dio>(),
        ));
    gh.factory<_i162.TonApi>(() => _i162.TonApi(gh<_i361.Dio>()));
    gh.factory<_i249.PresetsApi>(() => _i249.PresetsApi(gh<_i361.Dio>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i182.SelectNewAssetRoute(),
      instanceName: 'SelectNewAssetRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i971.NewExternalAccountRoute(),
      instanceName: 'NewExternalAccountRoute',
    );
    gh.lazySingleton<_i184.AppStorageService>(() => _i184.AppStorageService(
        gh<_i792.GetStorage>(instanceName: 'app_storage_service')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i562.UpdateVersionRoute(),
      instanceName: 'UpdateVersionRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i4.AddNftRoute(),
      instanceName: 'AddNftRoute',
    );
    gh.singleton<_i130.PresetsConfigReader>(() => _i130.PresetsConfigReader(
          gh<_i249.PresetsApi>(),
          gh<_i679.SecureStorageService>(),
          gh<_i104.ResourcesService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i537.BrowserRoute(),
      instanceName: 'BrowserRoute',
    );
    gh.factory<_i934.StoreUrlGenerator>(
        () => _i934.StoreUrlGenerator(gh<_i143.AppVersionService>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i211.WalletDeployRoute(),
      instanceName: 'WalletDeployRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i217.EditNetworkRoute(),
      instanceName: 'EditNetworkRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i72.TonWalletSendRoute(),
      instanceName: 'TonWalletSendRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i473.CreateSeedPasswordRoute(),
      instanceName: 'CreateSeedPasswordRoute',
    );
    gh.lazySingleton<_i128.IIdentifyIconsService>(
        () => _i316.IdentifyIconsService(gh<_i128.AppStorageService>()));
    gh.singleton<_i1020.BalanceStorageService>(
        () => _i1020.BalanceStorageService(
              gh<_i792.GetStorage>(instanceName: 'overallBalancesDomain'),
              gh<_i792.GetStorage>(instanceName: 'balancesDomain'),
            ));
    gh.singleton<_i634.BrowserTabsStorageService>(() =>
        _i634.BrowserTabsStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_tabs')));
    gh.singleton<_i581.BrowserHistoryStorageService>(() =>
        _i581.BrowserHistoryStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_history')));
    gh.singleton<_i700.TokenRepository>(() => _i700.TokenRepository(
          gh<_i771.NekotonRepository>(),
          gh<_i361.Dio>(),
        ));
    gh.factory<_i639.TokenApi>(() => _i639.TokenApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1004.ConfigureNetworksRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'EditNetworkRoute')),
      instanceName: 'ConfigureNetworksRoute',
    );
    gh.singleton<_i213.BrowserBookmarksStorageService>(() =>
        _i213.BrowserBookmarksStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_bookmarks')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i118.CheckSeedPhraseRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedPasswordRoute')),
      instanceName: 'CheckSeedPhraseRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i171.KeyDetailRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'AccountDetailRoute')),
      instanceName: 'KeyDetailRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i649.SeedDetailRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'KeyDetailRoute')),
      instanceName: 'SeedDetailRoute',
    );
    gh.singleton<_i495.TonRepository>(
        () => _i495.TonRepository(gh<_i162.TonApi>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () =>
          _i4.NftRoute(gh<_i82.CompassBaseRoute>(instanceName: 'AddNftRoute')),
      instanceName: 'NftRoute',
    );
    gh.singleton<_i747.GeneralStorageService>(() => _i747.GeneralStorageService(
          gh<_i792.GetStorage>(instanceName: 'preferences_key'),
          gh<_i792.GetStorage>(instanceName: 'currencies_key'),
          gh<_i792.GetStorage>(instanceName: 'system_contract_assets_key'),
          gh<_i792.GetStorage>(instanceName: 'custom_contract_assets_key'),
          gh<_i792.GetStorage>(
              instanceName: 'default_active_assets_storage_key'),
        ));
    gh.singleton<_i68.NtpService>(
      () => _i68.NtpService(gh<_i128.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i386.NekotonRepositoryStorageService>(() =>
        _i386.NekotonRepositoryStorageService(gh<_i771.NekotonRepository>()));
    gh.singleton<_i818.GasPriceService>(
        () => _i818.GasPriceService(gh<_i771.NekotonRepository>()));
    gh.singleton<_i272.CurrentKeyService>(() => _i272.CurrentKeyService(
          gh<_i128.GeneralStorageService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i646.CreateSeedRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'CheckSeedPhraseRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedPasswordRoute'),
      ),
      instanceName: 'CreateSeedRoute',
    );
    gh.singleton<_i402.CurrentAccountsService>(
        () => _i402.CurrentAccountsService(
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrentKeyService>(),
              gh<_i128.GeneralStorageService>(),
            ));
    gh.factory<_i803.LatestVersionFinder>(
        () => _i803.LatestVersionFinder(gh<_i728.VersionComparator>()));
    gh.factory<_i1008.UpdateStatusChecker>(
        () => _i1008.UpdateStatusChecker(gh<_i728.VersionComparator>()));
    gh.singleton<_i116.PresetsConnectionService>(
        () => _i116.PresetsConnectionService(gh<_i418.PresetsConfigReader>()));
    gh.singleton<_i234.BrowserFaviconURLStorageService>(() =>
        _i234.BrowserFaviconURLStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_favicon_urls')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i501.BootstrapFailedRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ConfigureNetworksRoute')),
      instanceName: 'BootstrapFailedRoute',
    );
    gh.singleton<_i336.NftStorageService>(() => _i336.NftStorageService(
        gh<_i792.GetStorage>(instanceName: 'nft_storage_service')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i278.SelectSeedRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'NewAccountRoute')),
      instanceName: 'SelectSeedRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i420.CancelUnstakingRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletSendRoute')),
      instanceName: 'CancelUnstakingRoute',
    );
    gh.singleton<_i82.CompassGuard>(
      () => _i331.RestoreSubroutesGuard(gh<_i275.NavigationService>()),
      instanceName: 'RestoreSubroutesGuard',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i473.CreateSeedOnboardingPasswordRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'EnableBiometryRoute')),
      instanceName: 'CreateSeedOnboardingPasswordRoute',
    );
    gh.singleton<_i244.CurrentSeedService>(() => _i244.CurrentSeedService(
          gh<_i771.NekotonRepository>(),
          gh<_i403.CurrentKeyService>(),
        ));
    gh.factory<_i186.TonConnectJsBridge>(() => _i186.TonConnectJsBridge(
          gh<_i128.TonConnectService>(),
          gh<_i128.TonConnectStorageService>(),
        ));
    gh.lazySingleton<_i770.TonConnectHttpBridge>(
        () => _i770.TonConnectHttpBridge(
              gh<_i128.TonConnectService>(),
              gh<_i128.AppLifecycleService>(),
              gh<_i128.TonConnectStorageService>(),
              gh<_i361.Dio>(),
            ));
    gh.singleton<_i575.BiometryService>(() => _i575.BiometryService(
          gh<_i128.GeneralStorageService>(),
          gh<_i128.SecureStorageService>(),
          gh<_i128.AppLifecycleService>(),
        ));
    gh.singleton<_i263.NftService>(() => _i263.NftService(
          gh<_i771.NekotonRepository>(),
          gh<_i1015.NftStorageService>(),
          gh<_i128.AppStorageService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i650.WalletPrepareTransferRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletSendRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'TokenWalletSendRoute'),
      ),
      instanceName: 'WalletPrepareTransferRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i650.WalletPrepareSpecifiedTransferRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletSendRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'TokenWalletSendRoute'),
      ),
      instanceName: 'WalletPrepareSpecifiedTransferRoute',
    );
    gh.singleton<_i308.CurrenciesService>(() => _i308.CurrenciesService(
          dio: gh<_i361.Dio>(),
          nekotonRepository: gh<_i771.NekotonRepository>(),
          currentAccounts: gh<_i128.CurrentAccountsService>(),
          storageService: gh<_i128.GeneralStorageService>(),
          appLifecycle: gh<_i128.AppLifecycleService>(),
        ));
    gh.singleton<_i65.ConnectionsStorageService>(
        () => _i65.ConnectionsStorageService(
              gh<_i792.GetStorage>(instanceName: 'connections'),
              gh<_i128.PresetsConnectionService>(),
              gh<_i632.MessengerService>(),
            ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i986.AddAccountRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'SelectSeedRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NewAccountRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NewExternalAccountRoute'),
      ),
      instanceName: 'AddAccountRoute',
    );
    gh.singleton<_i720.UpdateService>(() => _i720.UpdateService(
          gh<_i130.PresetsConfigReader>(),
          gh<_i1008.UpdateStatusChecker>(),
          gh<_i803.LatestVersionFinder>(),
          gh<_i1030.UpdateVersionStorageService>(),
          gh<_i143.AppVersionService>(),
        ));
    gh.singleton<_i470.BrowserService>(
      () => _i470.BrowserService(
        gh<_i850.AppLinksService>(),
        gh<_i213.BrowserBookmarksStorageService>(),
        gh<_i234.BrowserFaviconURLStorageService>(),
        gh<_i581.BrowserHistoryStorageService>(),
        gh<_i634.BrowserTabsStorageService>(),
        gh<_i229.BrowserPermissionsStorageService>(),
        gh<_i632.MessengerService>(),
        gh<_i747.GeneralStorageService>(),
        gh<_i175.TonConnectService>(),
        gh<_i771.NekotonRepository>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i468.BootstrapService>(
        () => _i468.BootstrapService(gh<_i116.PresetsConnectionService>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i450.StakingRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletSendRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'TokenWalletSendRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'CancelUnstakingRoute'),
      ),
      instanceName: 'StakingRoute',
    );
    gh.singleton<_i82.CompassGuard>(
      () => _i169.UpdateVersionGuard(gh<_i484.UpdateService>()),
      instanceName: 'UpdateVersionGuard',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i750.TokenWalletDetailsRoute(gh<_i82.CompassBaseRoute>(
          instanceName: 'WalletPrepareSpecifiedTransferRoute')),
      instanceName: 'TokenWalletDetailsRoute',
    );
    gh.singleton<_i82.CompassGuard>(
      () => _i13.OnboardingGuard(
        gh<_i468.BootstrapService>(),
        gh<_i771.NekotonRepository>(),
      ),
      instanceName: 'OnboardingGuard',
    );
    gh.singleton<_i473.PermissionsService>(() => _i473.PermissionsService(
          gh<_i470.BrowserService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.singleton<_i637.BalanceService>(() => _i637.BalanceService(
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrenciesService>(),
          gh<_i128.BalanceStorageService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i512.TonWalletDetailsRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletDeployRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletPrepareTransferRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'WalletPrepareSpecifiedTransferRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'ConfirmMultisigTransactionRoute'),
      ),
      instanceName: 'TonWalletDetailsRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i741.EnterSeedPhraseRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedPasswordRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'CreateSeedOnboardingPasswordRoute'),
      ),
      instanceName: 'EnterSeedPhraseRoute',
    );
    gh.singleton<_i725.StorageManagerService>(() => _i725.StorageManagerService(
          gh<_i128.SecureStorageService>(),
          gh<_i128.GeneralStorageService>(),
          gh<_i634.BrowserTabsStorageService>(),
          gh<_i581.BrowserHistoryStorageService>(),
          gh<_i213.BrowserBookmarksStorageService>(),
          gh<_i229.BrowserPermissionsStorageService>(),
          gh<_i234.BrowserFaviconURLStorageService>(),
          gh<_i128.NekotonStorageService>(),
          gh<_i128.NekotonRepositoryStorageService>(),
          gh<_i128.TonWalletStorageService>(),
          gh<_i128.TokenWalletStorageService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i128.BalanceStorageService>(),
          gh<_i128.AppStorageService>(),
          gh<_i128.TonConnectStorageService>(),
          gh<_i1030.UpdateVersionStorageService>(),
          gh<_i1015.NftStorageService>(),
        ));
    gh.singleton<_i754.ConnectionService>(() => _i754.ConnectionService(
          gh<_i128.ConnectionsStorageService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.PresetsConnectionService>(),
          gh<_i361.Dio>(),
        ));
    gh.singleton<_i299.SessionService>(() => _i299.SessionService(
          gh<_i771.NekotonRepository>(),
          gh<_i725.StorageManagerService>(),
          gh<_i679.SecureStorageService>(),
          gh<_i958.IIdentifyIconsService>(),
          gh<_i470.BrowserService>(),
        ));
    gh.singleton<_i964.AssetsService>(
      () => _i964.AssetsService(
        gh<_i771.NekotonRepository>(),
        gh<_i128.ConnectionsStorageService>(),
        gh<_i128.CurrentAccountsService>(),
        gh<_i128.PresetsConnectionService>(),
        gh<_i361.Dio>(),
        gh<_i128.GeneralStorageService>(),
        gh<_i495.TonRepository>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i643.EnterSeedNameRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedPhraseRoute'),
      ),
      instanceName: 'EnterSeedNameRoute',
    );
    gh.singleton<_i877.TokenWalletsService>(() => _i877.TokenWalletsService(
          gh<_i771.NekotonRepository>(),
          gh<_i128.AssetsService>(),
          gh<_i188.TokenRepository>(),
          gh<_i104.ResourcesService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i113.WalletRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'EnableBiometryRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'SelectNewAssetRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'CustodiansSettingsRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'AddAccountRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletDetailsRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'TokenWalletDetailsRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletPrepareTransferRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'WalletPrepareSpecifiedTransferRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletDeployRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'ConfirmMultisigTransactionRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'ConfigureNetworksRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'StakingRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedNameRoute'),
      ),
      instanceName: 'WalletRoute',
    );
    gh.singleton<_i309.CompassRouter>(
        () => _i309.CompassRouter(gh<_i128.BootstrapService>()));
    gh.singleton<_i82.CompassGuard>(
      () => _i48.RootTabSyncGuard(
        gh<_i468.BootstrapService>(),
        gh<_i771.NekotonRepository>(),
      ),
      instanceName: 'RootTabSyncGuard',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i176.ImportWalletRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedPhraseRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'CreateSeedOnboardingPasswordRoute'),
      ),
      instanceName: 'ImportWalletRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i852.AddExistingWalletRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ImportWalletRoute')),
      instanceName: 'AddExistingWalletRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i45.ManageSeedsAccountsRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'SeedDetailRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedNameRoute'),
      ),
      instanceName: 'ManageSeedsAccountsRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i805.ChooseNetworkRoute(
        gh<_i82.CompassBaseRoute>(
            instanceName: 'CreateSeedOnboardingPasswordRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'AddExistingWalletRoute'),
      ),
      instanceName: 'ChooseNetworkRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1010.OnBoardingRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ChooseNetworkRoute')),
      instanceName: 'OnBoardingRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i302.ProfileRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ManageSeedsAccountsRoute')),
      instanceName: 'ProfileRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i786.RootRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'BrowserRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'ProfileRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NftRoute'),
      ),
      instanceName: 'RootRoute',
    );
    return this;
  }
}

class _$DioModule extends _i720.DioModule {}
