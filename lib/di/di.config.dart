// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:elementary/elementary.dart' as _i83;
import 'package:encrypted_storage/encrypted_storage.dart' as _i426;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i171;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nekoton_repository/nekoton_repository.dart' as _i771;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i1067;

import '../app/router/compass/compass.dart' as _i82;
import '../app/router/guard.dart' as _i484;
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
import '../app/service/bootstrap/configurators/biometry.dart' as _i728;
import '../app/service/bootstrap/configurators/connection.dart' as _i159;
import '../app/service/bootstrap/configurators/encrypted_storage.dart' as _i569;
import '../app/service/bootstrap/configurators/features.dart' as _i690;
import '../app/service/bootstrap/configurators/localization.dart' as _i440;
import '../app/service/bootstrap/configurators/logger.dart' as _i335;
import '../app/service/bootstrap/configurators/migrate_storage.dart' as _i962;
import '../app/service/bootstrap/configurators/nekoton.dart' as _i388;
import '../app/service/bootstrap/configurators/ntp.dart' as _i231;
import '../app/service/bootstrap/configurators/storage_services.dart' as _i634;
import '../app/service/connection/connection_service.dart' as _i754;
import '../app/service/crash_detector/domain/service/crash_detector_service.dart'
    as _i47;
import '../app/service/currencies/currencies_fetch_strategy.dart' as _i586;
import '../app/service/currencies/currencies_service.dart' as _i1052;
import '../app/service/currency_convert_service.dart' as _i27;
import '../app/service/current_accounts_service.dart' as _i402;
import '../app/service/current_seed_service.dart' as _i244;
import '../app/service/database/database_service.dart' as _i940;
import '../app/service/identify/i_identify_icons_service.dart' as _i958;
import '../app/service/identify/identify_icons_service.dart' as _i316;
import '../app/service/navigation_service.dart' as _i275;
import '../app/service/nekoton_related/current_key_service.dart' as _i272;
import '../app/service/nekoton_related/gas_price_service.dart' as _i818;
import '../app/service/nekoton_related/nekoton_related.dart' as _i403;
import '../app/service/network_connection/network_connection_service.dart'
    as _i33;
import '../app/service/ntp_service.dart' as _i68;
import '../app/service/pending_deep_link_service.dart' as _i239;
import '../app/service/permissions_service.dart' as _i473;
import '../app/service/presets_connection/presets_connection_service.dart'
    as _i116;
import '../app/service/remote/dns_resolve_service.dart' as _i391;
import '../app/service/resources_service.dart' as _i104;
import '../app/service/service.dart' as _i128;
import '../app/service/session/session_service.dart' as _i299;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i747;
import '../app/service/storage_service/app_storage_service.dart' as _i184;
import '../app/service/storage_service/balance_storage_service.dart' as _i1020;
import '../app/service/storage_service/connections_storage/connections_storage_service.dart'
    as _i284;
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
import '../app/view/app_model.dart' as _i425;
import '../app/view/app_wm.dart' as _i1017;
import '../core/sentry.dart' as _i438;
import '../feature/add_seed/add_existing_wallet/route.dart' as _i852;
import '../feature/add_seed/add_seed.dart' as _i1056;
import '../feature/add_seed/check_seed_phrase/check_seed_phrase.dart' as _i199;
import '../feature/add_seed/check_seed_phrase/route.dart' as _i850;
import '../feature/add_seed/check_seed_phrase/view/check_seed_phrase_page_model.dart'
    as _i1030;
import '../feature/add_seed/check_seed_phrase/view/check_seed_phrase_page_wm.dart'
    as _i708;
import '../feature/add_seed/create_password/route.dart' as _i473;
import '../feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen_model.dart'
    as _i905;
import '../feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen_wm.dart'
    as _i762;
import '../feature/add_seed/create_password/view/create_seed_password_profile_model.dart'
    as _i81;
import '../feature/add_seed/create_password/view/create_seed_password_profile_wm.dart'
    as _i445;
import '../feature/add_seed/create_seed/route.dart' as _i431;
import '../feature/add_seed/create_seed/view/create_seed_model.dart' as _i484;
import '../feature/add_seed/create_seed/view/create_seed_wm.dart' as _i1016;
import '../feature/add_seed/enter_seed_name/route.dart' as _i50;
import '../feature/add_seed/enter_seed_phrase/enter_seed_phrase_model.dart'
    as _i9;
import '../feature/add_seed/enter_seed_phrase/enter_seed_phrase_wm.dart'
    as _i134;
import '../feature/add_seed/enter_seed_phrase/route.dart' as _i741;
import '../feature/add_seed/import_wallet/import_wallet_screen_model.dart'
    as _i966;
import '../feature/add_seed/import_wallet/import_wallet_screen_wm.dart'
    as _i542;
import '../feature/add_seed/import_wallet/route.dart' as _i176;
import '../feature/biometry/route.dart' as _i459;
import '../feature/biometry/view/biometry_screen_model.dart' as _i700;
import '../feature/biometry/view/biometry_screen_wm.dart' as _i801;
import '../feature/bootstrap_failed/bootstrap_failed.dart' as _i9;
import '../feature/bootstrap_failed/route.dart' as _i501;
import '../feature/bootstrap_failed/view/bootstrap_failed_rerun_model.dart'
    as _i884;
import '../feature/bootstrap_failed/view/bootstrap_failed_rerun_wm.dart'
    as _i926;
import '../feature/browser_v1/approvals_listener/actions/add_network/add_network_model.dart'
    as _i561;
import '../feature/browser_v1/approvals_listener/actions/add_network/add_network_wm.dart'
    as _i317;
import '../feature/browser_v1/approvals_listener/actions/add_tip3_token/add_tip3_token_model.dart'
    as _i588;
import '../feature/browser_v1/approvals_listener/actions/add_tip3_token/add_tip3_token_wm.dart'
    as _i668;
import '../feature/browser_v1/approvals_listener/actions/change_network/change_network_model.dart'
    as _i710;
import '../feature/browser_v1/approvals_listener/actions/change_network/change_network_wm.dart'
    as _i639;
import '../feature/browser_v1/approvals_listener/actions/request_permissions/request_permissions_model.dart'
    as _i57;
import '../feature/browser_v1/approvals_listener/actions/request_permissions/request_permissions_wm.dart'
    as _i1015;
import '../feature/browser_v1/approvals_listener/actions/send_message/send_message_model.dart'
    as _i201;
import '../feature/browser_v1/approvals_listener/actions/send_message/send_message_wm.dart'
    as _i136;
import '../feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_model.dart'
    as _i662;
import '../feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_wm.dart'
    as _i446;
import '../feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_model.dart'
    as _i378;
import '../feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_wm.dart'
    as _i968;
import '../feature/browser_v1/browser.dart' as _i4;
import '../feature/browser_v2/domain/browser_launcher.dart' as _i70;
import '../feature/browser_v2/domain/delegates/browser_anti_phishing_delegate.dart'
    as _i106;
import '../feature/browser_v2/domain/delegates/browser_service_auth_delegate.dart'
    as _i931;
import '../feature/browser_v2/domain/delegates/browser_service_bookmarks_delegate.dart'
    as _i773;
import '../feature/browser_v2/domain/delegates/browser_service_favicon_delegate.dart'
    as _i181;
import '../feature/browser_v2/domain/delegates/browser_service_history_delegate.dart'
    as _i617;
import '../feature/browser_v2/domain/delegates/browser_service_pages_controllers_delegate.dart'
    as _i318;
import '../feature/browser_v2/domain/delegates/browser_service_permissions_delegate.dart'
    as _i475;
import '../feature/browser_v2/domain/delegates/browser_service_screenshots_delegate.dart'
    as _i169;
import '../feature/browser_v2/domain/delegates/browser_service_tabs_delegate.dart'
    as _i77;
import '../feature/browser_v2/domain/service/browser_service.dart' as _i470;
import '../feature/browser_v2/domain/service/storages/browser_bookmarks_storage_service.dart'
    as _i213;
import '../feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart'
    as _i234;
import '../feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart'
    as _i988;
import '../feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart'
    as _i229;
import '../feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart'
    as _i634;
import '../feature/browser_v2/screens/create_group/create_browser_group_screen_model.dart'
    as _i907;
import '../feature/browser_v2/screens/create_group/create_browser_group_screen_wm.dart'
    as _i877;
import '../feature/browser_v2/screens/create_group/route.dart' as _i345;
import '../feature/browser_v2/screens/main/browser_main_screen_model.dart'
    as _i933;
import '../feature/browser_v2/screens/main/browser_main_screen_wm.dart'
    as _i792;
import '../feature/browser_v2/screens/main/route.dart' as _i1040;
import '../feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar_model.dart'
    as _i659;
import '../feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar_wm.dart'
    as _i1045;
import '../feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu_model.dart'
    as _i942;
import '../feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu_wm.dart'
    as _i627;
import '../feature/browser_v2/screens/main/widgets/pages/page/browser_page_model.dart'
    as _i154;
import '../feature/browser_v2/screens/main/widgets/pages/page/browser_page_wm.dart'
    as _i307;
import '../feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view_model.dart'
    as _i865;
import '../feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view_wm.dart'
    as _i399;
import '../feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_model.dart'
    as _i413;
import '../feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_wm.dart'
    as _i518;
import '../feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_model.dart'
    as _i747;
import '../feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_wm.dart'
    as _i976;
import '../feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header_model.dart'
    as _i762;
import '../feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header_wm.dart'
    as _i1045;
import '../feature/browser_v2/widgets/bottomsheets/book/browser_book_model.dart'
    as _i250;
import '../feature/browser_v2/widgets/bottomsheets/book/browser_book_wm.dart'
    as _i913;
import '../feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu_model.dart'
    as _i966;
import '../feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu_wm.dart'
    as _i970;
import '../feature/browser_v2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet_model.dart'
    as _i706;
import '../feature/browser_v2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet_wm.dart'
    as _i848;
import '../feature/browser_v2/widgets/favicon_view/favicon_view_model.dart'
    as _i306;
import '../feature/browser_v2/widgets/favicon_view/favicon_view_wm.dart'
    as _i312;
import '../feature/browser_v2/widgets/tips_bar/tips_bar_model.dart' as _i476;
import '../feature/browser_v2/widgets/tips_bar/tips_bar_wm.dart' as _i704;
import '../feature/choose_network/choose_network_screen_model.dart' as _i173;
import '../feature/choose_network/choose_network_screen_wm.dart' as _i124;
import '../feature/choose_network/route.dart' as _i805;
import '../feature/connection_fail/connection_fail_screen_model.dart' as _i1007;
import '../feature/connection_fail/connection_fail_screen_wm.dart' as _i459;
import '../feature/contact_support/view/contact_support_model.dart' as _i915;
import '../feature/contact_support/view/contact_support_wm.dart' as _i894;
import '../feature/ledger/domain/ledger_app/ble_packer.dart' as _i433;
import '../feature/ledger/domain/ledger_ble_scanner.dart' as _i328;
import '../feature/ledger/domain/ledger_connection_handler_impl.dart' as _i191;
import '../feature/ledger/domain/ledger_service.dart' as _i91;
import '../feature/ledger/domain/ledger_storage_service.dart' as _i820;
import '../feature/ledger/domain/mixins.dart' as _i213;
import '../feature/ledger/ledger.dart' as _i865;
import '../feature/localization/domain/localization_service.dart' as _i221;
import '../feature/localization/localization.dart' as _i1071;
import '../feature/localization/widgets/localization/localization_sheet_model.dart'
    as _i893;
import '../feature/localization/widgets/localization/localization_sheet_wm.dart'
    as _i910;
import '../feature/messenger/domain/service/messenger_service.dart' as _i632;
import '../feature/messenger/messenger.dart' as _i553;
import '../feature/network/bottom_sheets/select_network/select_network_model.dart'
    as _i703;
import '../feature/network/bottom_sheets/select_network/select_network_wm.dart'
    as _i175;
import '../feature/network/bottom_sheets/select_workchain/select_workchain_model.dart'
    as _i1011;
import '../feature/network/bottom_sheets/select_workchain/select_workchain_wm.dart'
    as _i295;
import '../feature/network/configure_networks/configure_networks_model.dart'
    as _i385;
import '../feature/network/configure_networks/configure_networks_wm.dart'
    as _i1055;
import '../feature/network/configure_networks/route.dart' as _i1004;
import '../feature/network/edit_network/edit_network_model.dart' as _i328;
import '../feature/network/edit_network/edit_network_wm.dart' as _i942;
import '../feature/network/edit_network/route.dart' as _i217;
import '../feature/network/network.dart' as _i393;
import '../feature/nft/domain/nft_service.dart' as _i263;
import '../feature/nft/domain/nft_storage_service.dart' as _i336;
import '../feature/nft/nft.dart' as _i1015;
import '../feature/nft/route.dart' as _i4;
import '../feature/nft/view/add_nft/add_nft_model.dart' as _i321;
import '../feature/nft/view/add_nft/add_nft_wm.dart' as _i374;
import '../feature/nft/view/nft_collection_page/nft_collection_page_model.dart'
    as _i857;
import '../feature/nft/view/nft_collection_page/nft_collection_page_wm.dart'
    as _i212;
import '../feature/nft/view/nft_collection_page/route.dart' as _i103;
import '../feature/nft/view/nft_item_page/nft_item_page_model.dart' as _i641;
import '../feature/nft/view/nft_item_page/nft_item_page_wm.dart' as _i348;
import '../feature/nft/view/nft_item_page/route.dart' as _i32;
import '../feature/nft/view/nft_page/nft_page_model.dart' as _i680;
import '../feature/nft/view/nft_page/nft_page_wm.dart' as _i972;
import '../feature/nft/view/nft_prepare_transfer/nft_prepare_transfer_model.dart'
    as _i1038;
import '../feature/nft/view/nft_prepare_transfer/nft_prepare_transfer_wm.dart'
    as _i143;
import '../feature/nft/view/nft_prepare_transfer/route.dart' as _i248;
import '../feature/nft/view/nft_send/nft_send_model.dart' as _i362;
import '../feature/nft/view/nft_send/nft_send_wm.dart' as _i425;
import '../feature/nft/view/nft_send/route.dart' as _i33;
import '../feature/nft/widgets/nft_transfer_info/nft_transfer_info_model.dart'
    as _i125;
import '../feature/nft/widgets/nft_transfer_info/nft_transfer_info_wm.dart'
    as _i833;
import '../feature/no_internet/no_internet_screen_model.dart' as _i243;
import '../feature/no_internet/no_internet_screen_wm.dart' as _i775;
import '../feature/no_internet/route.dart' as _i225;
import '../feature/onboarding/guard.dart' as _i13;
import '../feature/onboarding/route.dart' as _i1010;
import '../feature/onboarding/screen/welcome/welcome_screen_model.dart'
    as _i437;
import '../feature/onboarding/screen/welcome/welcome_screen_wm.dart' as _i634;
import '../feature/presets_config/domain/presets_config_reader.dart' as _i130;
import '../feature/presets_config/presets_config.dart' as _i418;
import '../feature/profile/account_detail/account_detail_model.dart' as _i78;
import '../feature/profile/account_detail/account_detail_wm.dart' as _i963;
import '../feature/profile/account_detail/route.dart' as _i303;
import '../feature/profile/key_detail/route.dart' as _i171;
import '../feature/profile/key_detail/view/key_detail_page_model.dart' as _i974;
import '../feature/profile/key_detail/view/key_detail_page_wm.dart' as _i37;
import '../feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet_model.dart'
    as _i210;
import '../feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet_wm.dart'
    as _i787;
import '../feature/profile/key_detail/widgets/account_settings_sheet/account_settings_sheet_model.dart'
    as _i1031;
import '../feature/profile/key_detail/widgets/account_settings_sheet/account_settings_sheet_wm.dart'
    as _i541;
import '../feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_sheet_model.dart'
    as _i964;
import '../feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_sheet_wm.dart'
    as _i199;
import '../feature/profile/key_detail/widgets/add_new_local_account_type_sheet/add_new_local_account_type_sheet_model.dart'
    as _i6;
import '../feature/profile/key_detail/widgets/add_new_local_account_type_sheet/add_new_local_account_type_sheet_wm.dart'
    as _i865;
import '../feature/profile/key_detail/widgets/delete_account_sheet/delete_account_sheet_model.dart'
    as _i549;
import '../feature/profile/key_detail/widgets/delete_account_sheet/delete_account_sheet_wm.dart'
    as _i11;
import '../feature/profile/manage_seeds_accounts/route.dart' as _i45;
import '../feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page_model.dart'
    as _i321;
import '../feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page_wm.dart'
    as _i667;
import '../feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password.dart'
    as _i56;
import '../feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password_model.dart'
    as _i546;
import '../feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password_wm.dart'
    as _i1004;
import '../feature/profile/manage_seeds_accounts/widgets/delete_seed_sheet/delete_seed_sheet_model.dart'
    as _i976;
import '../feature/profile/manage_seeds_accounts/widgets/delete_seed_sheet/delete_seed_sheet_wm.dart'
    as _i241;
import '../feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_sheet_model.dart'
    as _i508;
import '../feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_sheet_wm.dart'
    as _i1070;
import '../feature/profile/manage_seeds_accounts/widgets/seed_settings/seed_settings_model.dart'
    as _i955;
import '../feature/profile/manage_seeds_accounts/widgets/seed_settings/seed_settings_wm.dart'
    as _i1068;
import '../feature/profile/profile.dart' as _i767;
import '../feature/profile/route.dart' as _i302;
import '../feature/profile/seed_detail/route.dart' as _i649;
import '../feature/profile/seed_detail/seed_detail.dart' as _i450;
import '../feature/profile/seed_detail/view/seed_detail_page_model.dart'
    as _i708;
import '../feature/profile/seed_detail/view/seed_detail_page_wm.dart' as _i420;
import '../feature/profile/seed_detail/widgets/derive_keys_sheet/derive_keys_sheet_model.dart'
    as _i616;
import '../feature/profile/seed_detail/widgets/derive_keys_sheet/derive_keys_sheet_wm.dart'
    as _i240;
import '../feature/profile/view/profile_page_model.dart' as _i342;
import '../feature/profile/view/profile_page_wm.dart' as _i700;
import '../feature/profile/widgets/enter_password/enter_password_model.dart'
    as _i322;
import '../feature/profile/widgets/enter_password/enter_password_wm.dart'
    as _i506;
import '../feature/profile/widgets/rename_sheet/rename_sheet_model.dart'
    as _i815;
import '../feature/profile/widgets/rename_sheet/rename_sheet_wm.dart' as _i313;
import '../feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_model.dart'
    as _i644;
import '../feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_wm.dart'
    as _i11;
import '../feature/qa/view/qa_model.dart' as _i1046;
import '../feature/qa/view/qa_wm.dart' as _i301;
import '../feature/qr_scanner/qr_scanner.dart' as _i686;
import '../feature/qr_scanner/view/qr_scanner_model.dart' as _i121;
import '../feature/qr_scanner/view/qr_scanner_wm.dart' as _i569;
import '../feature/root/domain/root_tab_service.dart' as _i533;
import '../feature/root/restore_subroutes_guard.dart' as _i331;
import '../feature/root/view/route.dart' as _i786;
import '../feature/splash/route.dart' as _i592;
import '../feature/splash/splash_screen_model.dart' as _i582;
import '../feature/splash/splash_screen_wm.dart' as _i659;
import '../feature/ton_connect/domain/ton_connect_http_bridge.dart' as _i1071;
import '../feature/ton_connect/domain/ton_connect_js_bridge.dart' as _i269;
import '../feature/ton_connect/domain/ton_connect_service.dart' as _i33;
import '../feature/ton_connect/ton_connect.dart' as _i625;
import '../feature/ton_connect/view/tc_connect/tc_connect_model.dart' as _i88;
import '../feature/ton_connect/view/tc_connect/tc_connect_wm.dart' as _i522;
import '../feature/ton_connect/view/tc_manage_dapps/tc_manage_dapps_model.dart'
    as _i956;
import '../feature/ton_connect/view/tc_manage_dapps/tc_manage_dapps_wm.dart'
    as _i935;
import '../feature/ton_connect/view/tc_send_message/tc_send_message_model.dart'
    as _i446;
import '../feature/ton_connect/view/tc_send_message/tc_send_message_wm.dart'
    as _i73;
import '../feature/ton_connect/view/tc_sign_data/tc_sign_data_model.dart'
    as _i845;
import '../feature/ton_connect/view/tc_sign_data/tc_sign_data_wm.dart' as _i603;
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
import '../feature/update_version/view/update_version_model.dart' as _i482;
import '../feature/update_version/view/update_version_wm.dart' as _i596;
import '../feature/wallet/confirm_multisig_transaction/route.dart' as _i693;
import '../feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_model.dart'
    as _i594;
import '../feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_wm.dart'
    as _i1029;
import '../feature/wallet/custodians_settings/custodians_settings_model.dart'
    as _i313;
import '../feature/wallet/custodians_settings/custodians_settings_wm.dart'
    as _i94;
import '../feature/wallet/custodians_settings/route.dart' as _i1052;
import '../feature/wallet/new_account/add_account/add_account_model.dart'
    as _i715;
import '../feature/wallet/new_account/add_account/add_account_wm.dart' as _i677;
import '../feature/wallet/new_account/add_account_confirm/add_account_confirm_model.dart'
    as _i513;
import '../feature/wallet/new_account/add_account_confirm/add_account_confirm_wm.dart'
    as _i920;
import '../feature/wallet/new_account/add_account_result/add_account_result_model.dart'
    as _i459;
import '../feature/wallet/new_account/add_account_result/add_account_result_wm.dart'
    as _i57;
import '../feature/wallet/new_account/add_external_account/add_external_account.dart'
    as _i231;
import '../feature/wallet/new_account/add_external_account/add_external_account_model.dart'
    as _i716;
import '../feature/wallet/new_account/add_external_account/add_external_account_wm.dart'
    as _i727;
import '../feature/wallet/new_account/add_external_account/route.dart' as _i971;
import '../feature/wallet/new_account/new_account_type/new_account_type_model.dart'
    as _i848;
import '../feature/wallet/new_account/new_account_type/new_account_type_wm.dart'
    as _i667;
import '../feature/wallet/new_account/route.dart' as _i986;
import '../feature/wallet/new_account/screen/new_account_screen_model.dart'
    as _i175;
import '../feature/wallet/new_account/screen/new_account_screen_wm.dart'
    as _i423;
import '../feature/wallet/new_account/screen/route.dart' as _i229;
import '../feature/wallet/new_account/select_seed/route.dart' as _i278;
import '../feature/wallet/new_account/select_seed/select_seed_model.dart'
    as _i479;
import '../feature/wallet/new_account/select_seed/select_seed_wm.dart' as _i338;
import '../feature/wallet/route.dart' as _i113;
import '../feature/wallet/staking/domain/staking_abi_provider.dart' as _i1016;
import '../feature/wallet/staking/domain/staking_service.dart' as _i811;
import '../feature/wallet/staking/staking.dart' as _i948;
import '../feature/wallet/staking/view/cancel_unstaking_page/cancel_unstaking_page_model.dart'
    as _i450;
import '../feature/wallet/staking/view/cancel_unstaking_page/cancel_unstaking_page_wm.dart'
    as _i516;
import '../feature/wallet/staking/view/cancel_unstaking_page/route.dart'
    as _i420;
import '../feature/wallet/staking/view/staking_page/route.dart' as _i450;
import '../feature/wallet/staking/view/staking_page/staking_page_model.dart'
    as _i251;
import '../feature/wallet/staking/view/staking_page/staking_page_wm.dart'
    as _i904;
import '../feature/wallet/staking/widgets/staking_in_progress/staking_in_progress_model.dart'
    as _i402;
import '../feature/wallet/staking/widgets/staking_in_progress/staking_in_progress_wm.dart'
    as _i180;
import '../feature/wallet/token_wallet_details/route.dart' as _i750;
import '../feature/wallet/token_wallet_details/view/token_wallet_details_model.dart'
    as _i941;
import '../feature/wallet/token_wallet_details/view/token_wallet_details_wm.dart'
    as _i209;
import '../feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_model.dart'
    as _i311;
import '../feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_wm.dart'
    as _i996;
import '../feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_model.dart'
    as _i178;
import '../feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_wm.dart'
    as _i127;
import '../feature/wallet/token_wallet_send/domain/basic_token_transfer_delegate.dart'
    as _i74;
import '../feature/wallet/token_wallet_send/domain/gasless_token_transfer_delegate.dart'
    as _i591;
import '../feature/wallet/token_wallet_send/domain/token_transfer_delegate_provider.dart'
    as _i132;
import '../feature/wallet/token_wallet_send/route.dart' as _i290;
import '../feature/wallet/token_wallet_send/token_wallet_send.dart' as _i201;
import '../feature/wallet/token_wallet_send/view/token_wallet_send_model.dart'
    as _i523;
import '../feature/wallet/token_wallet_send/view/token_wallet_send_wm.dart'
    as _i312;
import '../feature/wallet/ton_wallet_details/route.dart' as _i512;
import '../feature/wallet/ton_wallet_details/view/ton_wallet_details_page_model.dart'
    as _i71;
import '../feature/wallet/ton_wallet_details/view/ton_wallet_details_page_wm.dart'
    as _i397;
import '../feature/wallet/ton_wallet_send/route.dart' as _i72;
import '../feature/wallet/ton_wallet_send/view/ton_wallet_send_model.dart'
    as _i946;
import '../feature/wallet/ton_wallet_send/view/ton_wallet_send_wm.dart'
    as _i252;
import '../feature/wallet/view/wallet_page_model.dart' as _i348;
import '../feature/wallet/view/wallet_page_wm.dart' as _i938;
import '../feature/wallet/wallet.dart' as _i0;
import '../feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart'
    as _i291;
import '../feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart'
    as _i818;
import '../feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_model.dart'
    as _i791;
import '../feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_wm.dart'
    as _i313;
import '../feature/wallet/wallet_deploy/wallet_deploy_status/route.dart'
    as _i653;
import '../feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_model.dart'
    as _i1053;
import '../feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_wm.dart'
    as _i309;
import '../feature/wallet/wallet_deploy/wallet_multisig_config/route.dart'
    as _i192;
import '../feature/wallet/wallet_deploy/wallet_multisig_config/wallet_multisig_config_model.dart'
    as _i335;
import '../feature/wallet/wallet_deploy/wallet_multisig_config/wallet_multisig_config_wm.dart'
    as _i826;
import '../feature/wallet/wallet_prepare_transfer/route.dart' as _i650;
import '../feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_model.dart'
    as _i149;
import '../feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_wm.dart'
    as _i236;
import '../feature/wallet/widgets/account_asset_tab/account_asset_tab_model.dart'
    as _i343;
import '../feature/wallet/widgets/account_asset_tab/account_asset_tab_wm.dart'
    as _i695;
import '../feature/wallet/widgets/account_asset_tab/select_new_asset/route.dart'
    as _i182;
import '../feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart'
    as _i158;
import '../feature/wallet/widgets/account_asset_tab/select_new_asset/view/select_new_asset_page_model.dart'
    as _i1024;
import '../feature/wallet/widgets/account_asset_tab/select_new_asset/view/select_new_asset_page_wm.dart'
    as _i483;
import '../feature/wallet/widgets/account_asset_tab/select_tokens/select_token_model.dart'
    as _i289;
import '../feature/wallet/widgets/account_asset_tab/select_tokens/select_token_wm.dart'
    as _i718;
import '../feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_model.dart'
    as _i869;
import '../feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_wm.dart'
    as _i771;
import '../feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_model.dart'
    as _i719;
import '../feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_wm.dart'
    as _i526;
import '../feature/wallet/widgets/account_card/account_card_model.dart'
    as _i615;
import '../feature/wallet/widgets/account_card/account_card_wm.dart' as _i645;
import '../feature/wallet/widgets/account_settings/account_settings_model.dart'
    as _i8;
import '../feature/wallet/widgets/account_settings/account_settings_wm.dart'
    as _i962;
import '../feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet_model.dart'
    as _i806;
import '../feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet_wm.dart'
    as _i1015;
import '../feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button_model.dart'
    as _i611;
import '../feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button_wm.dart'
    as _i268;
import '../feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart'
    as _i1034;
import '../feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_model.dart'
    as _i161;
import '../feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_wm.dart'
    as _i1010;
import '../feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen_model.dart'
    as _i772;
import '../feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen_wm.dart'
    as _i743;
import '../feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_model.dart'
    as _i562;
import '../feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_wm.dart'
    as _i408;
import '../feature/wallet/widgets/account_transactions_tab/view/account_transactions_tab_model.dart'
    as _i330;
import '../feature/wallet/widgets/account_transactions_tab/view/account_transactions_tab_wm.dart'
    as _i793;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget/ton_wallet_expired_transaction_widget_model.dart'
    as _i365;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget/ton_wallet_expired_transaction_widget_wm.dart'
    as _i783;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_model.dart'
    as _i938;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget_wm.dart'
    as _i765;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget/ton_wallet_multisig_ordinary_transaction_widget_model.dart'
    as _i63;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget/ton_wallet_multisig_ordinary_transaction_widget_wm.dart'
    as _i772;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_pending_transaction_widget/ton_wallet_multisig_pending_transaction_widget_model.dart'
    as _i222;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_pending_transaction_widget/ton_wallet_multisig_pending_transaction_widget_wm.dart'
    as _i359;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_model.dart'
    as _i680;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_wm.dart'
    as _i399;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_pending_transaction_widget/ton_wallet_pending_transaction_widget_model.dart'
    as _i205;
import '../feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_pending_transaction_widget/ton_wallet_pending_transaction_widget_wm.dart'
    as _i504;
import '../feature/wallet/widgets/select_account/select_account_model.dart'
    as _i1035;
import '../feature/wallet/widgets/select_account/select_account_wm.dart'
    as _i371;
import '../feature/wallet/widgets/token_transfer_info/token_transfer_info_model.dart'
    as _i207;
import '../feature/wallet/widgets/token_transfer_info/token_transfer_info_wm.dart'
    as _i111;
import '../feature/wallet/widgets/wallet_account_actions/wallet_account_actions_model.dart'
    as _i801;
import '../feature/wallet/widgets/wallet_account_actions/wallet_account_actions_wm.dart'
    as _i532;
import '../feature/wallet/widgets/wallet_account_body/wallet_account_body_model.dart'
    as _i516;
import '../feature/wallet/widgets/wallet_account_body/wallet_account_body_wm.dart'
    as _i227;
import '../feature/wallet/widgets/wallet_app_bar/wallet_app_bar_model.dart'
    as _i622;
import '../feature/wallet/widgets/wallet_app_bar/wallet_app_bar_wm.dart'
    as _i693;
import '../feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector_model.dart'
    as _i1042;
import '../feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector_wm.dart'
    as _i1005;
import '../feature/wallet/widgets/wallet_backup/check_phrase/check_phrase_model.dart'
    as _i415;
import '../feature/wallet/widgets/wallet_backup/check_phrase/check_phrase_wm.dart'
    as _i760;
import '../feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_model.dart'
    as _i352;
import '../feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_wm.dart'
    as _i62;
import '../feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_model.dart'
    as _i318;
import '../feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_wm.dart'
    as _i830;
import '../feature/wallet/widgets/wallet_backup/wallet_backup.dart' as _i217;
import '../http/api/gasless/gasless_api.dart' as _i528;
import '../http/api/presets/presets_api.dart' as _i249;
import '../http/api/token/token_api.dart' as _i639;
import '../http/api/ton/ton_api.dart' as _i162;
import '../http/dio_module.dart' as _i720;
import '../http/http.dart' as _i188;
import '../http/interceptors/app_lifecycle_interceptor.dart' as _i164;
import '../http/repository/gasless_repository.dart' as _i487;
import '../http/repository/repository.dart' as _i593;
import '../http/repository/token_repository.dart' as _i700;
import '../http/repository/ton_repository.dart' as _i495;
import '../utils/factories/error_handler/standard_error_handler.dart' as _i290;
import '../widgets/barcode_address/barcode_address_model.dart' as _i257;
import '../widgets/barcode_address/barcode_address_wm.dart' as _i798;
import '../widgets/bottom_navigation_bar/custom_bottom_navigation_bar_model.dart'
    as _i278;
import '../widgets/bottom_navigation_bar/custom_bottom_navigation_bar_wm.dart'
    as _i249;
import '../widgets/user_avatar/user_avatar_model.dart' as _i45;
import '../widgets/user_avatar/user_avatar_wm.dart' as _i903;

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
    final sentryModule = _$SentryModule();
    final dioModule = _$DioModule();
    gh.factory<_i440.LocalizationConfigurator>(
        () => _i440.LocalizationConfigurator());
    gh.factory<_i728.VersionComparator>(() => _i728.VersionComparator());
    gh.factory<_i318.BrowserServicePagesControllersDelegate>(
        () => _i318.BrowserServicePagesControllersDelegate());
    gh.factory<_i931.BrowserServiceAuthDelegate>(
        () => _i931.BrowserServiceAuthDelegate());
    gh.singleton<_i738.TokenWalletStorageService>(
        () => _i738.TokenWalletStorageService());
    gh.singleton<_i139.TonWalletStorageService>(
        () => _i139.TonWalletStorageService());
    gh.singleton<_i940.DatabaseService>(
      () => _i940.DatabaseService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i143.AppVersionService>(() => _i143.AppVersionService());
    gh.singleton<_i746.AppLinksService>(
      () => _i746.AppLinksService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i47.CrashDetectorService>(() => _i47.CrashDetectorService());
    gh.singleton<_i104.ResourcesService>(() => _i104.ResourcesService());
    gh.singleton<_i830.AppLifecycleService>(() => _i830.AppLifecycleService());
    gh.singleton<_i1070.AppPermissionsService>(
        () => _i1070.AppPermissionsService());
    gh.singleton<_i33.NetworkConnectionService>(
        () => _i33.NetworkConnectionService());
    gh.singleton<_i27.CurrencyConvertService>(
        () => _i27.CurrencyConvertService());
    gh.singleton<_i391.DnsResolveService>(() => _i391.DnsResolveService());
    gh.singleton<_i654.BrowserApprovalsService>(
        () => _i654.BrowserApprovalsService());
    gh.singleton<_i433.BlePacker>(() => _i433.BlePacker());
    gh.singleton<_i191.LedgerConnectionHandlerImpl>(
        () => _i191.LedgerConnectionHandlerImpl());
    gh.singleton<_i221.LocalizationService>(() => _i221.LocalizationService());
    gh.lazySingleton<_i438.SentryWorker>(() => sentryModule.getSentryWorker());
    gh.lazySingleton<_i632.MessengerService>(
      () => _i632.MessengerService(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i83.ErrorHandler>(
        () => _i290.PrimaryErrorHandler(gh<_i632.MessengerService>()));
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
      () => _i33.NftSendRoute(),
      instanceName: 'NftSendRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i653.WalletDeployStatusRoute(),
      instanceName: 'WalletDeployStatusRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i290.TokenWalletSendRoute(),
      instanceName: 'TokenWalletSendRoute',
    );
    gh.factory<_i915.ContactSupportModel>(() => _i915.ContactSupportModel(
          gh<_i83.ErrorHandler>(),
          gh<_i632.MessengerService>(),
        ));
    gh.factory<_i257.BarcodeAddressModel>(() => _i257.BarcodeAddressModel(
          gh<_i83.ErrorHandler>(),
          gh<_i632.MessengerService>(),
        ));
    gh.singleton<_i679.SecureStorageService>(
        () => _i679.SecureStorageService(gh<_i426.EncryptedStorage>()));
    gh.factory<_i798.BarcodeAddressWidgetModel>(
        () => _i798.BarcodeAddressWidgetModel(gh<_i257.BarcodeAddressModel>()));
    gh.lazySingleton<_i1030.UpdateVersionStorageService>(() =>
        _i1030.UpdateVersionStorageService(gh<_i792.GetStorage>(
            instanceName: 'update_version_storage_service')));
    gh.factory<_i335.LoggerConfigurator>(() => _i335.LoggerConfigurator(
          gh<_i143.AppVersionService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i1046.QaModel>(() => _i1046.QaModel(
          storage: gh<_i426.EncryptedStorage>(),
          messengerService: gh<_i632.MessengerService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i229.NewAccountRoute(),
      instanceName: 'NewAccountRoute',
    );
    gh.factory<_i569.EncryptedStorageConfigurator>(
        () => _i569.EncryptedStorageConfigurator(gh<_i426.EncryptedStorage>()));
    gh.singleton<_i275.NavigationService>(
        () => _i275.NavigationService(gh<_i426.EncryptedStorage>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1052.CustodiansSettingsRoute(),
      instanceName: 'CustodiansSettingsRoute',
    );
    gh.factory<_i966.ImportWalletScreenModel>(
        () => _i966.ImportWalletScreenModel(
              gh<_i632.MessengerService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.NetworkConnectionService>(),
            ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i693.ConfirmMultisigTransactionRoute(),
      instanceName: 'ConfirmMultisigTransactionRoute',
    );
    gh.singleton<_i1068.TonConnectStorageService>(() =>
        _i1068.TonConnectStorageService(
            gh<_i792.GetStorage>(instanceName: 'ton_connect_storage_service')));
    gh.singleton<_i82.CompassGuard>(
      () => _i484.LoggingGuard(),
      instanceName: 'LoggingGuard',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i225.NoInternetRoute(),
      instanceName: 'NoInternetRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i303.AccountDetailRoute(),
      instanceName: 'AccountDetailRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i345.CreateBrowserGroupRoute(),
      instanceName: 'CreateBrowserGroupRoute',
    );
    gh.factory<_i893.LocalizationSheetModel>(() => _i893.LocalizationSheetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i1071.LocalizationService>(),
        ));
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
      () => _i459.EnableBiometryRoute(),
      instanceName: 'EnableBiometryRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i4.AddNftRoute(),
      instanceName: 'AddNftRoute',
    );
    gh.factory<_i964.AddNewExternalAccountSheetModel>(
        () => _i964.AddNewExternalAccountSheetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i6.AddNewLocalAccountTypeSheetModel>(
        () => _i6.AddNewLocalAccountTypeSheetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i815.RenameSheetModel>(() => _i815.RenameSheetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
        ));
    gh.factory<_i716.AddExternalAccountModel>(
        () => _i716.AddExternalAccountModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i175.NewAccountScreenModel>(() => _i175.NewAccountScreenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i632.MessengerService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i818.WalletDeployConfirmRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'WalletDeployStatusRoute')),
      instanceName: 'WalletDeployConfirmRoute',
    );
    gh.factory<_i894.ContactSupportWidgetModel>(
        () => _i894.ContactSupportWidgetModel(gh<_i915.ContactSupportModel>()));
    gh.factory<_i934.StoreUrlGenerator>(
        () => _i934.StoreUrlGenerator(gh<_i143.AppVersionService>()));
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
    gh.singleton<_i1016.StakingAbiProvider>(
        () => _i1016.StakingAbiProvider(gh<_i104.ResourcesService>()));
    gh.factory<_i106.BrowserAntiPhishingDelegate>(
        () => _i106.BrowserAntiPhishingDelegate(gh<_i104.ResourcesService>()));
    gh.singleton<_i164.AppLifecycleInterceptor>(
      () => _i164.AppLifecycleInterceptor(gh<_i128.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i1020.BalanceStorageService>(
        () => _i1020.BalanceStorageService(
              gh<_i792.GetStorage>(instanceName: 'overallBalancesDomain'),
              gh<_i792.GetStorage>(instanceName: 'balancesDomain'),
            ));
    gh.factory<_i865.AddNewLocalAccountTypeSheetWidgetModel>(() =>
        _i865.AddNewLocalAccountTypeSheetWidgetModel(
            gh<_i6.AddNewLocalAccountTypeSheetModel>()));
    gh.factory<_i199.AddNewExternalAccountSheetWidgetModel>(() =>
        _i199.AddNewExternalAccountSheetWidgetModel(
            gh<_i964.AddNewExternalAccountSheetModel>()));
    gh.singleton<_i634.BrowserTabsStorageService>(() =>
        _i634.BrowserTabsStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_tabs')));
    gh.factory<_i475.BrowserServicePermissionsDelegate>(
        () => _i475.BrowserServicePermissionsDelegate(
              gh<_i229.BrowserPermissionsStorageService>(),
              gh<_i940.DatabaseService>(),
            ));
    gh.factory<_i313.RenameSheetWidgetModel>(
        () => _i313.RenameSheetWidgetModel(gh<_i815.RenameSheetModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1004.ConfigureNetworksRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'EditNetworkRoute')),
      instanceName: 'ConfigureNetworksRoute',
    );
    gh.singleton<_i336.NftStorageService>(() => _i336.NftStorageService(
          gh<_i792.GetStorage>(instanceName: 'nft_storage_service_metadata'),
          gh<_i792.GetStorage>(instanceName: 'nft_storage_service_general'),
        ));
    gh.factory<_i423.NewAccountScreenWidgetModel>(() =>
        _i423.NewAccountScreenWidgetModel(gh<_i175.NewAccountScreenModel>()));
    gh.factory<_i662.AccountInfoModel>(() => _i662.AccountInfoModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i974.KeyDetailPageModel>(() => _i974.KeyDetailPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i976.DeleteSeedSheetModel>(() => _i976.DeleteSeedSheetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i508.ExportSeedSheetModel>(() => _i508.ExportSeedSheetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i402.StakingInProgressModel>(() => _i402.StakingInProgressModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i772.TonWalletMultisigPendingTransactionDetailsScreenModel>(
        () => _i772.TonWalletMultisigPendingTransactionDetailsScreenModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i222.TonWalletMultisigPendingTransactionWidgetModel>(
        () => _i222.TonWalletMultisigPendingTransactionWidgetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i365.TonWalletExpiredTransactionWidgetModel>(
        () => _i365.TonWalletExpiredTransactionWidgetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i205.TonWalletPendingTransactionWidgetModel>(
        () => _i205.TonWalletPendingTransactionWidgetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i63.TonWalletMultisigOrdinaryTransactionWidgetModel>(
        () => _i63.TonWalletMultisigOrdinaryTransactionWidgetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i680.TonWalletOrdinaryTransactionWidgetModel>(
        () => _i680.TonWalletOrdinaryTransactionWidgetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i617.BrowserServiceHistoryDelegate>(
        () => _i617.BrowserServiceHistoryDelegate(gh<_i940.DatabaseService>()));
    gh.singleton<_i213.BrowserBookmarksStorageService>(() =>
        _i213.BrowserBookmarksStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_bookmarks')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i171.KeyDetailRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'AccountDetailRoute')),
      instanceName: 'KeyDetailRoute',
    );
    gh.factory<_i243.NoInternetScreenModel>(() => _i243.NoInternetScreenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i33.NetworkConnectionService>(),
        ));
    gh.factory<_i359.TonWalletMultisigPendingTransactionWidgetWidgetModel>(() =>
        _i359.TonWalletMultisigPendingTransactionWidgetWidgetModel(
            gh<_i222.TonWalletMultisigPendingTransactionWidgetModel>()));
    gh.singleton<_i820.LedgerStorageService>(() => _i820.LedgerStorageService(
        gh<_i792.GetStorage>(instanceName: 'ledger_storage_service')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i649.SeedDetailRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'KeyDetailRoute')),
      instanceName: 'SeedDetailRoute',
    );
    gh.factory<_i121.QrScannerModel>(() => _i121.QrScannerModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.AppPermissionsService>(),
          gh<_i128.AppLifecycleService>(),
          gh<_i632.MessengerService>(),
        ));
    gh.factory<_i241.DeleteSeedSheetWidgetModel>(() =>
        _i241.DeleteSeedSheetWidgetModel(gh<_i976.DeleteSeedSheetModel>()));
    gh.factory<_i9.EnterSeedPhraseModel>(() => _i9.EnterSeedPhraseModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.NetworkConnectionService>(),
          gh<_i632.MessengerService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i484.CreateSeedModel>(
        () => _i484.CreateSeedModel(gh<_i83.ErrorHandler>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1040.BrowserRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'CreateBrowserGroupRoute')),
      instanceName: 'BrowserRoute',
    );
    gh.singleton<_i747.GeneralStorageService>(() => _i747.GeneralStorageService(
          gh<_i792.GetStorage>(instanceName: 'preferences_key'),
          gh<_i792.GetStorage>(instanceName: 'currencies_key'),
          gh<_i792.GetStorage>(instanceName: 'system_contract_assets_key'),
          gh<_i792.GetStorage>(instanceName: 'custom_contract_assets_key'),
          gh<_i792.GetStorage>(
              instanceName: 'default_active_assets_storage_key'),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i192.WalletMultisigConfigRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'WalletDeployConfirmRoute')),
      instanceName: 'WalletMultisigConfigRoute',
    );
    gh.singleton<_i68.NtpService>(
      () => _i68.NtpService(gh<_i128.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i74.BasicTokenTransferDelegate>(
        () => _i74.BasicTokenTransferDelegate(gh<_i771.NekotonRepository>()));
    gh.singleton<_i386.NekotonRepositoryStorageService>(() =>
        _i386.NekotonRepositoryStorageService(gh<_i771.NekotonRepository>()));
    gh.singleton<_i818.GasPriceService>(
        () => _i818.GasPriceService(gh<_i771.NekotonRepository>()));
    gh.singleton<_i291.WalletDeploymentService>(
        () => _i291.WalletDeploymentService(gh<_i771.NekotonRepository>()));
    gh.singleton<_i272.CurrentKeyService>(() => _i272.CurrentKeyService(
          gh<_i128.GeneralStorageService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i210.AccountRenameSheetModel>(
        () => _i210.AccountRenameSheetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i845.TCSignDataModel>(() => _i845.TCSignDataModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
        ));
    gh.factory<_i1030.CheckSeedPhrasePageModel>(
        () => _i1030.CheckSeedPhrasePageModel(
              gh<_i83.ErrorHandler>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i446.AccountInfoWidgetModel>(
        () => _i446.AccountInfoWidgetModel(gh<_i662.AccountInfoModel>()));
    gh.factory<_i335.WalletMultisigConfigModel>(
        () => _i335.WalletMultisigConfigModel(
              gh<_i771.NekotonRepository>(),
              gh<_i83.ErrorHandler>(),
            ));
    gh.factory<_i783.TonWalletExpiredTransactionWidgetWidgetModel>(() =>
        _i783.TonWalletExpiredTransactionWidgetWidgetModel(
            gh<_i365.TonWalletExpiredTransactionWidgetModel>()));
    gh.factory<_i803.LatestVersionFinder>(
        () => _i803.LatestVersionFinder(gh<_i728.VersionComparator>()));
    gh.factory<_i1008.UpdateStatusChecker>(
        () => _i1008.UpdateStatusChecker(gh<_i728.VersionComparator>()));
    gh.factory<_i773.BrowserServiceBookmarksDelegate>(
        () => _i773.BrowserServiceBookmarksDelegate(
              gh<_i213.BrowserBookmarksStorageService>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i1053.WalletDeployStatusModel>(
        () => _i1053.WalletDeployStatusModel(
              gh<_i83.ErrorHandler>(),
              gh<_i291.WalletDeploymentService>(),
              gh<_i553.MessengerService>(),
            ));
    gh.singleton<_i234.BrowserFaviconURLStorageService>(() =>
        _i234.BrowserFaviconURLStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_favicon_urls')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i501.BootstrapFailedRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ConfigureNetworksRoute')),
      instanceName: 'BootstrapFailedRoute',
    );
    gh.singleton<_i988.BrowserGroupsStorageService>(() =>
        _i988.BrowserGroupsStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_groups')));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i248.NftPrepareTransferRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'NftSendRoute')),
      instanceName: 'NftPrepareTransferRoute',
    );
    gh.factory<_i437.WelcomeScreenModel>(() => _i437.WelcomeScreenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.AppStorageService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i850.CheckSeedPhraseRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedPasswordRoute')),
      instanceName: 'CheckSeedPhraseRoute',
    );
    gh.factory<_i516.WalletAccountBodyModel>(() => _i516.WalletAccountBodyModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.AppStorageService>(),
        ));
    gh.factory<_i301.QaWidgetModel>(
        () => _i301.QaWidgetModel(gh<_i1046.QaModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i278.SelectSeedRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'NewAccountRoute')),
      instanceName: 'SelectSeedRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i32.NftItemRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'NftPrepareTransferRoute')),
      instanceName: 'NftItemRoute',
    );
    gh.factory<_i318.ManualBackUpModel>(() => _i318.ManualBackUpModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
          gh<_i128.AppStorageService>(),
        ));
    gh.factory<_i415.CheckPhraseModel>(() => _i415.CheckPhraseModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
          gh<_i128.AppStorageService>(),
        ));
    gh.factory<_i1016.CreateSeedWidgetModel>(
        () => _i1016.CreateSeedWidgetModel(gh<_i484.CreateSeedModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i420.CancelUnstakingRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletSendRoute')),
      instanceName: 'CancelUnstakingRoute',
    );
    gh.factory<_i806.ChangeColorBottomSheetModel>(
        () => _i806.ChangeColorBottomSheetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i958.IIdentifyIconsService>(),
            ));
    gh.factory<_i611.AccountSettingsChangeColorButtonModel>(
        () => _i611.AccountSettingsChangeColorButtonModel(
              gh<_i83.ErrorHandler>(),
              gh<_i958.IIdentifyIconsService>(),
            ));
    gh.factory<_i45.UserAvatarModel>(() => _i45.UserAvatarModel(
          gh<_i83.ErrorHandler>(),
          gh<_i958.IIdentifyIconsService>(),
        ));
    gh.factory<_i1015.ChangeColorBottomSheetWidgetModel>(() =>
        _i1015.ChangeColorBottomSheetWidgetModel(
            gh<_i806.ChangeColorBottomSheetModel>()));
    gh.singleton<_i91.LedgerService>(() => _i91.LedgerService(
          gh<_i865.LedgerStorageService>(),
          gh<_i865.LedgerConnectionHandlerImpl>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i181.BrowserServiceFaviconDelegate>(() =>
        _i181.BrowserServiceFaviconDelegate(
            gh<_i234.BrowserFaviconURLStorageService>()));
    gh.singleton<_i575.BiometryService>(() => _i575.BiometryService(
          gh<_i128.GeneralStorageService>(),
          gh<_i128.SecureStorageService>(),
          gh<_i128.AppLifecycleService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i910.LocalizationSheetWidgetModel>(() =>
        _i910.LocalizationSheetWidgetModel(
            gh<_i1071.LocalizationSheetModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i473.CreateSeedOnboardingPasswordRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'EnableBiometryRoute')),
      instanceName: 'CreateSeedOnboardingPasswordRoute',
    );
    gh.factory<_i542.ImportWalletScreenWidgetModel>(() =>
        _i542.ImportWalletScreenWidgetModel(
            gh<_i966.ImportWalletScreenModel>()));
    gh.factory<_i603.TCSignDataWidgetModel>(
        () => _i603.TCSignDataWidgetModel(gh<_i625.TCSignDataModel>()));
    gh.singleton<_i244.CurrentSeedService>(() => _i244.CurrentSeedService(
          gh<_i771.NekotonRepository>(),
          gh<_i403.CurrentKeyService>(),
        ));
    gh.factory<_i546.ChangeSeedPasswordModel>(
        () => _i546.ChangeSeedPasswordModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.BiometryService>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i644.SwitchToSeedModel>(() => _i644.SwitchToSeedModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.CurrentKeyService>(),
        ));
    gh.factory<_i616.DeriveKeysSheetModel>(() => _i616.DeriveKeysSheetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i865.LedgerService>(),
        ));
    gh.factory<_i37.KeyDetailPageWidgetModel>(
        () => _i37.KeyDetailPageWidgetModel(gh<_i974.KeyDetailPageModel>()));
    gh.factory<_i309.WalletDeployStatusWidgetModel>(() =>
        _i309.WalletDeployStatusWidgetModel(
            gh<_i1053.WalletDeployStatusModel>()));
    gh.factory<_i569.QrScannerWidgetModel>(
        () => _i569.QrScannerWidgetModel(gh<_i686.QrScannerModel>()));
    gh.factory<
            _i743.TonWalletMultisigPendingTransactionDetailsScreenWidgetModel>(
        () => _i743.TonWalletMultisigPendingTransactionDetailsScreenWidgetModel(
            gh<_i772.TonWalletMultisigPendingTransactionDetailsScreenModel>()));
    gh.factory<_i787.AccountRenameSheetWidgetModel>(() =>
        _i787.AccountRenameSheetWidgetModel(
            gh<_i210.AccountRenameSheetModel>()));
    gh.factory<_i399.TonWalletOrdinaryTransactionWidgetWidgetModel>(() =>
        _i399.TonWalletOrdinaryTransactionWidgetWidgetModel(
            gh<_i680.TonWalletOrdinaryTransactionWidgetModel>()));
    gh.factory<_i227.WalletAccountBodyWidgetModel>(() =>
        _i227.WalletAccountBodyWidgetModel(gh<_i0.WalletAccountBodyModel>()));
    gh.factory<_i903.UserAvatarWidgetModel>(
        () => _i903.UserAvatarWidgetModel(gh<_i45.UserAvatarModel>()));
    gh.factory<_i1070.ExportSeedSheetWidgetModel>(() =>
        _i1070.ExportSeedSheetWidgetModel(gh<_i508.ExportSeedSheetModel>()));
    gh.factory<_i231.NtpConfigurator>(
        () => _i231.NtpConfigurator(gh<_i128.NtpService>()));
    gh.factory<_i240.DeriveKeysSheetWidgetModel>(() =>
        _i240.DeriveKeysSheetWidgetModel(gh<_i450.DeriveKeysSheetModel>()));
    gh.factory<_i727.AddExternalAccountWidgetModel>(() =>
        _i727.AddExternalAccountWidgetModel(
            gh<_i231.AddExternalAccountModel>()));
    gh.factory<_i134.EnterSeedPhraseWidgetModel>(() =>
        _i134.EnterSeedPhraseWidgetModel(gh<_i1056.EnterSeedPhraseModel>()));
    gh.factory<_i388.NekotonConfigurator>(() => _i388.NekotonConfigurator(
          gh<_i771.NekotonRepository>(),
          gh<_i128.NekotonStorageService>(),
          gh<_i128.TonWalletStorageService>(),
          gh<_i128.TokenWalletStorageService>(),
          gh<_i128.NtpService>(),
          gh<_i865.LedgerConnectionHandlerImpl>(),
        ));
    gh.factory<_i634.WelcomeScreenWidgetModel>(
        () => _i634.WelcomeScreenWidgetModel(gh<_i437.WelcomeScreenModel>()));
    gh.factory<_i772.TonWalletMultisigOrdinaryTransactionWidgetWidgetModel>(
        () => _i772.TonWalletMultisigOrdinaryTransactionWidgetWidgetModel(
            gh<_i63.TonWalletMultisigOrdinaryTransactionWidgetModel>()));
    gh.factory<_i313.CustodiansSettingsModel>(
        () => _i313.CustodiansSettingsModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.AppStorageService>(),
              gh<_i632.MessengerService>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i504.TonWalletPendingTransactionWidgetWidgetModel>(() =>
        _i504.TonWalletPendingTransactionWidgetWidgetModel(
            gh<_i205.TonWalletPendingTransactionWidgetModel>()));
    gh.factory<_i169.BrowserServiceScreenshotsDelegate>(() =>
        _i169.BrowserServiceScreenshotsDelegate(
            gh<_i747.GeneralStorageService>()));
    gh.factory<_i11.SwitchToSeedWidgetModel>(
        () => _i11.SwitchToSeedWidgetModel(gh<_i644.SwitchToSeedModel>()));
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
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.getDio(gh<_i164.AppLifecycleInterceptor>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i103.NftCollectionRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'NftItemRoute')),
      instanceName: 'NftCollectionRoute',
    );
    gh.factory<_i830.ManualBackUpWidgetModel>(
        () => _i830.ManualBackUpWidgetModel(gh<_i217.ManualBackUpModel>()));
    gh.factory<_i77.BrowserServiceTabsDelegate>(
        () => _i77.BrowserServiceTabsDelegate(
              gh<_i634.BrowserTabsStorageService>(),
              gh<_i988.BrowserGroupsStorageService>(),
              gh<_i318.BrowserServicePagesControllersDelegate>(),
              gh<_i169.BrowserServiceScreenshotsDelegate>(),
            ));
    gh.singleton<_i213.BleAvailabilityModelDelegate>(
        () => _i213.BleAvailabilityModelDelegate(
              ledgerService: gh<_i865.LedgerService>(),
              messengerService: gh<_i553.MessengerService>(),
              permissionsService: gh<_i128.AppPermissionsService>(),
            ));
    gh.factory<_i180.StakingInProgressWidgetModel>(() =>
        _i180.StakingInProgressWidgetModel(gh<_i402.StakingInProgressModel>()));
    gh.factory<_i268.AccountSettingsChangeColorButtonWidgetModel>(() =>
        _i268.AccountSettingsChangeColorButtonWidgetModel(
            gh<_i611.AccountSettingsChangeColorButtonModel>()));
    gh.factory<_i775.NoInternetScreenWidgetModel>(() =>
        _i775.NoInternetScreenWidgetModel(gh<_i243.NoInternetScreenModel>()));
    gh.singleton<_i700.TokenRepository>(() => _i700.TokenRepository(
          gh<_i771.NekotonRepository>(),
          gh<_i361.Dio>(),
        ));
    gh.factory<_i639.TokenApi>(() => _i639.TokenApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.factory<_i528.GaslessApi>(() => _i528.GaslessApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i986.AddAccountRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'SelectSeedRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NewAccountRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NewExternalAccountRoute'),
      ),
      instanceName: 'AddAccountRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i431.CreateSeedRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'CheckSeedPhraseRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedPasswordRoute'),
      ),
      instanceName: 'CreateSeedRoute',
    );
    gh.factory<_i1004.ChangeSeedPasswordWidgetModel>(() =>
        _i1004.ChangeSeedPasswordWidgetModel(
            gh<_i56.ChangeSeedPasswordModel>()));
    gh.factory<_i708.CheckSeedPhrasePageWidgetModel>(() =>
        _i708.CheckSeedPhrasePageWidgetModel(
            gh<_i199.CheckSeedPhrasePageModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i512.TonWalletDetailsRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletMultisigConfigRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletDeployConfirmRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletPrepareTransferRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'WalletPrepareSpecifiedTransferRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'ConfirmMultisigTransactionRoute'),
      ),
      instanceName: 'TonWalletDetailsRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i450.StakingRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'TonWalletSendRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'TokenWalletSendRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'CancelUnstakingRoute'),
      ),
      instanceName: 'StakingRoute',
    );
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i750.TokenWalletDetailsRoute(gh<_i82.CompassBaseRoute>(
          instanceName: 'WalletPrepareSpecifiedTransferRoute')),
      instanceName: 'TokenWalletDetailsRoute',
    );
    gh.factory<_i826.WalletMultisigConfigWidgetModel>(() =>
        _i826.WalletMultisigConfigWidgetModel(
            gh<_i335.WalletMultisigConfigModel>()));
    gh.singleton<_i328.LedgerBleScanner>(
        () => _i328.LedgerBleScanner(gh<_i865.LedgerService>()));
    gh.factory<_i201.SendMessageModel>(() => _i201.SendMessageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i946.TonWalletSendModel>(() => _i946.TonWalletSendModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i594.ConfirmMultisigTransactionModel>(
        () => _i594.ConfirmMultisigTransactionModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i865.LedgerService>(),
              gh<_i865.BleAvailabilityModelDelegate>(),
            ));
    gh.factory<_i848.NewAccountTypeModel>(() => _i848.NewAccountTypeModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i1029.ConfirmMultisigTransactionWidgetModel>(() =>
        _i1029.ConfirmMultisigTransactionWidgetModel(
            gh<_i594.ConfirmMultisigTransactionModel>()));
    gh.factory<_i760.CheckPhraseWidgetModel>(
        () => _i760.CheckPhraseWidgetModel(gh<_i217.CheckPhraseModel>()));
    gh.factory<_i321.ManageSeedsAccountsPageModel>(
        () => _i321.ManageSeedsAccountsPageModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrentSeedService>(),
              gh<_i128.AppStorageService>(),
            ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i741.EnterSeedPhraseRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedPasswordRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'CreateSeedOnboardingPasswordRoute'),
      ),
      instanceName: 'EnterSeedPhraseRoute',
    );
    gh.factory<_i728.BiometryConfigurator>(
        () => _i728.BiometryConfigurator(gh<_i128.BiometryService>()));
    gh.factory<_i700.BiometryScreenModel>(
        () => _i700.BiometryScreenModel(gh<_i128.BiometryService>()));
    gh.factory<_i322.EnterPasswordModel>(() => _i322.EnterPasswordModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
          gh<_i128.BiometryService>(),
        ));
    gh.factory<_i352.ConfirmActionModel>(() => _i352.ConfirmActionModel(
          gh<_i83.ErrorHandler>(),
          gh<_i575.BiometryService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i244.CurrentSeedService>(),
          gh<_i632.MessengerService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i4.NftRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'AddNftRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NftCollectionRoute'),
      ),
      instanceName: 'NftRoute',
    );
    gh.factory<_i708.SeedDetailPageModel>(() => _i708.SeedDetailPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.CurrentSeedService>(),
          gh<_i128.CurrentKeyService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i94.CustodianSettingsWidgetModel>(() =>
        _i94.CustodianSettingsWidgetModel(gh<_i313.CustodiansSettingsModel>()));
    gh.singleton<_i487.GaslessRepository>(() => _i487.GaslessRepository(
          gh<_i771.NekotonRepository>(),
          gh<_i361.Dio>(),
        ));
    gh.lazySingleton<_i33.TonConnectService>(() => _i33.TonConnectService(
          gh<_i128.TonConnectStorageService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i143.AppVersionService>(),
          gh<_i361.Dio>(),
        ));
    gh.singleton<_i811.StakingService>(() => _i811.StakingService(
          gh<_i771.NekotonRepository>(),
          gh<_i361.Dio>(),
          gh<_i948.StakingAbiProvider>(),
          gh<_i128.GasPriceService>(),
        ));
    gh.factory<_i479.SelectSeedModel>(() => _i479.SelectSeedModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentKeyService>(),
          gh<_i128.CurrentSeedService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i162.TonApi>(() => _i162.TonApi(gh<_i361.Dio>()));
    gh.factory<_i249.PresetsApi>(() => _i249.PresetsApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i1071.TonConnectHttpBridge>(
        () => _i1071.TonConnectHttpBridge(
              gh<_i625.TonConnectService>(),
              gh<_i128.AppLifecycleService>(),
              gh<_i128.TonConnectStorageService>(),
              gh<_i361.Dio>(),
            ));
    gh.factory<_i801.WalletAccountActionsModel>(
        () => _i801.WalletAccountActionsModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i948.StakingService>(),
              gh<_i632.MessengerService>(),
            ));
    gh.singleton<_i586.DefaultCurrenciesFetchStrategy>(
        () => _i586.DefaultCurrenciesFetchStrategy(gh<_i361.Dio>()));
    gh.singleton<_i586.TonCurrenciesFetchStrategy>(
        () => _i586.TonCurrenciesFetchStrategy(gh<_i361.Dio>()));
    gh.singleton<_i470.BrowserService>(
      () => _i470.BrowserService(
        gh<_i625.TonConnectService>(),
        gh<_i771.NekotonRepository>(),
        gh<_i931.BrowserServiceAuthDelegate>(),
        gh<_i773.BrowserServiceBookmarksDelegate>(),
        gh<_i181.BrowserServiceFaviconDelegate>(),
        gh<_i617.BrowserServiceHistoryDelegate>(),
        gh<_i475.BrowserServicePermissionsDelegate>(),
        gh<_i77.BrowserServiceTabsDelegate>(),
        gh<_i106.BrowserAntiPhishingDelegate>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i715.AddAccountModel>(() => _i715.AddAccountModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentSeedService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i956.TCManageDappsModel>(() => _i956.TCManageDappsModel(
          gh<_i83.ErrorHandler>(),
          gh<_i625.TonConnectService>(),
          gh<_i128.TonConnectStorageService>(),
          gh<_i625.TonConnectHttpBridge>(),
        ));
    gh.factory<_i955.SeedSettingsModel>(() => _i955.SeedSettingsModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentKeyService>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i801.BiometryScreenWidgetModel>(
        () => _i801.BiometryScreenWidgetModel(gh<_i700.BiometryScreenModel>()));
    gh.factory<_i338.SelectSeedWidgetModel>(
        () => _i338.SelectSeedWidgetModel(gh<_i479.SelectSeedModel>()));
    gh.factory<_i1068.SeedSettingsWidgetModel>(
        () => _i1068.SeedSettingsWidgetModel(gh<_i767.SeedSettingsModel>()));
    gh.factory<_i62.ConfirmActionWidgetModel>(
        () => _i62.ConfirmActionWidgetModel(gh<_i217.ConfirmActionModel>()));
    gh.factory<_i667.ManageSeedsAccountsPageWidgetModel>(() =>
        _i667.ManageSeedsAccountsPageWidgetModel(
            gh<_i321.ManageSeedsAccountsPageModel>()));
    gh.factory<_i136.SendMessageWidgetModel>(
        () => _i136.SendMessageWidgetModel(gh<_i201.SendMessageModel>()));
    gh.factory<_i269.TonConnectJsBridge>(() => _i269.TonConnectJsBridge(
          gh<_i625.TonConnectService>(),
          gh<_i128.TonConnectStorageService>(),
        ));
    gh.singleton<_i130.PresetsConfigReader>(() => _i130.PresetsConfigReader(
          gh<_i249.PresetsApi>(),
          gh<_i679.SecureStorageService>(),
          gh<_i104.ResourcesService>(),
        ));
    gh.singleton<_i720.UpdateService>(() => _i720.UpdateService(
          gh<_i130.PresetsConfigReader>(),
          gh<_i1008.UpdateStatusChecker>(),
          gh<_i803.LatestVersionFinder>(),
          gh<_i1030.UpdateVersionStorageService>(),
          gh<_i143.AppVersionService>(),
        ));
    gh.singleton<_i495.TonRepository>(
        () => _i495.TonRepository(gh<_i162.TonApi>()));
    gh.factory<_i667.NewAccountTypeWidgetModel>(
        () => _i667.NewAccountTypeWidgetModel(gh<_i848.NewAccountTypeModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i176.ImportWalletRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedPhraseRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'CreateSeedOnboardingPasswordRoute'),
      ),
      instanceName: 'ImportWalletRoute',
    );
    gh.factory<_i250.BrowserBookModel>(() => _i250.BrowserBookModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
          gh<_i221.LocalizationService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i50.EnterSeedNameRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'CreateSeedRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedPhraseRoute'),
      ),
      instanceName: 'EnterSeedNameRoute',
    );
    gh.singleton<_i82.CompassGuard>(
      () => _i169.UpdateVersionGuard(gh<_i484.UpdateService>()),
      instanceName: 'UpdateVersionGuard',
    );
    gh.factory<_i252.TonWalletSendWidgetModel>(
        () => _i252.TonWalletSendWidgetModel(gh<_i946.TonWalletSendModel>()));
    gh.singleton<_i473.PermissionsService>(() => _i473.PermissionsService(
          gh<_i470.BrowserService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i446.TCSendMessageModel>(() => _i446.TCSendMessageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i593.TonRepository>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i591.GaslessTokenTransferDelegate>(
        () => _i591.GaslessTokenTransferDelegate(
              gh<_i771.NekotonRepository>(),
              gh<_i487.GaslessRepository>(),
            ));
    gh.singleton<_i116.PresetsConnectionService>(
        () => _i116.PresetsConnectionService(gh<_i418.PresetsConfigReader>()));
    gh.factory<_i378.WebsiteInfoModel>(() => _i378.WebsiteInfoModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i907.CreateBrowserGroupScreenModel>(
        () => _i907.CreateBrowserGroupScreenModel(
              gh<_i83.ErrorHandler>(),
              gh<_i470.BrowserService>(),
            ));
    gh.factory<_i933.BrowserMainScreenModel>(() => _i933.BrowserMainScreenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i413.BrowserTabsListItemModel>(
        () => _i413.BrowserTabsListItemModel(
              gh<_i83.ErrorHandler>(),
              gh<_i470.BrowserService>(),
            ));
    gh.factory<_i747.BrowserTabsListModel>(() => _i747.BrowserTabsListModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i762.TabListHeaderModel>(() => _i762.TabListHeaderModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i659.ToolbarModel>(() => _i659.ToolbarModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i865.TabAnimatedViewModel>(() => _i865.TabAnimatedViewModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i942.BrowserGroupMenuModel>(() => _i942.BrowserGroupMenuModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i306.FaviconViewModel>(() => _i306.FaviconViewModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i706.BrowserBookmarkRenameBottomSheetModel>(
        () => _i706.BrowserBookmarkRenameBottomSheetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i470.BrowserService>(),
            ));
    gh.factory<_i966.BrowserMainMenuModel>(() => _i966.BrowserMainMenuModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i476.TipsBarModel>(() => _i476.TipsBarModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
        ));
    gh.singleton<_i132.TokenTransferDelegateProvider>(
        () => _i132.TokenTransferDelegateProvider(
              gh<_i771.NekotonRepository>(),
              gh<_i487.GaslessRepository>(),
              gh<_i0.GaslessTokenTransferDelegate>(),
              gh<_i0.BasicTokenTransferDelegate>(),
            ));
    gh.factory<_i1045.TabListHeaderWidgetModel>(
        () => _i1045.TabListHeaderWidgetModel(gh<_i762.TabListHeaderModel>()));
    gh.factory<_i506.EnterPasswordWidgetModel>(
        () => _i506.EnterPasswordWidgetModel(gh<_i322.EnterPasswordModel>()));
    gh.factory<_i420.SeedDetailPageWidgetModel>(
        () => _i420.SeedDetailPageWidgetModel(gh<_i708.SeedDetailPageModel>()));
    gh.factory<_i677.AddAccountWidgetModel>(
        () => _i677.AddAccountWidgetModel(gh<_i715.AddAccountModel>()));
    gh.factory<_i73.TCSendMessageWidgetModel>(
        () => _i73.TCSendMessageWidgetModel(gh<_i625.TCSendMessageModel>()));
    gh.factory<_i704.TipsBarWidgetModel>(
        () => _i704.TipsBarWidgetModel(gh<_i476.TipsBarModel>()));
    gh.factory<_i848.BrowserBookmarkRenameBottomSheetWidgetModel>(() =>
        _i848.BrowserBookmarkRenameBottomSheetWidgetModel(
            gh<_i706.BrowserBookmarkRenameBottomSheetModel>()));
    gh.factory<_i532.WalletAccountActionsWidgetModel>(() =>
        _i532.WalletAccountActionsWidgetModel(
            gh<_i801.WalletAccountActionsModel>()));
    gh.factory<_i792.BrowserMainScreenWidgetModel>(() =>
        _i792.BrowserMainScreenWidgetModel(gh<_i933.BrowserMainScreenModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i852.AddExistingWalletRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ImportWalletRoute')),
      instanceName: 'AddExistingWalletRoute',
    );
    gh.factory<_i312.FaviconViewWidgetModel>(
        () => _i312.FaviconViewWidgetModel(gh<_i306.FaviconViewModel>()));
    gh.factory<_i482.UpdateVersionModel>(() => _i482.UpdateVersionModel(
          gh<_i83.ErrorHandler>(),
          gh<_i720.UpdateService>(),
          gh<_i934.StoreUrlGenerator>(),
          gh<_i438.SentryWorker>(),
        ));
    gh.factory<_i970.BrowserMainMenuWidgetModel>(() =>
        _i970.BrowserMainMenuWidgetModel(gh<_i966.BrowserMainMenuModel>()));
    gh.factory<_i935.TCManageDappsWidgetModel>(
        () => _i935.TCManageDappsWidgetModel(gh<_i625.TCManageDappsModel>()));
    gh.factory<_i399.TabAnimatedViewWidgetModel>(() =>
        _i399.TabAnimatedViewWidgetModel(gh<_i865.TabAnimatedViewModel>()));
    gh.factory<_i627.BrowserGroupMenuWidgetModel>(() =>
        _i627.BrowserGroupMenuWidgetModel(gh<_i942.BrowserGroupMenuModel>()));
    gh.factory<_i968.WebsiteInfoWidgetModel>(
        () => _i968.WebsiteInfoWidgetModel(gh<_i378.WebsiteInfoModel>()));
    gh.factory<_i1045.ToolbarWidgetModel>(
        () => _i1045.ToolbarWidgetModel(gh<_i659.ToolbarModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i45.ManageSeedsAccountsRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'SeedDetailRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedNameRoute'),
      ),
      instanceName: 'ManageSeedsAccountsRoute',
    );
    gh.singleton<_i284.ConnectionsStorageService>(
        () => _i284.ConnectionsStorageService(
              gh<_i792.GetStorage>(instanceName: 'connections'),
              gh<_i128.PresetsConnectionService>(),
              gh<_i632.MessengerService>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i518.BrowserTabsListItemWidgetModel>(() =>
        _i518.BrowserTabsListItemWidgetModel(
            gh<_i413.BrowserTabsListItemModel>()));
    gh.factory<_i523.TokenWalletSendModel>(() => _i523.TokenWalletSendModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
          gh<_i0.TokenTransferDelegateProvider>(),
        ));
    gh.factory<_i877.CreateBrowserGroupScreenWidgetModel>(() =>
        _i877.CreateBrowserGroupScreenWidgetModel(
            gh<_i907.CreateBrowserGroupScreenModel>()));
    gh.factory<_i913.BrowserBookWidgetModel>(
        () => _i913.BrowserBookWidgetModel(gh<_i250.BrowserBookModel>()));
    gh.factory<_i596.UpdateVersionWidgetModel>(
        () => _i596.UpdateVersionWidgetModel(gh<_i482.UpdateVersionModel>()));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i805.ChooseNetworkRoute(
        gh<_i82.CompassBaseRoute>(
            instanceName: 'CreateSeedOnboardingPasswordRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'AddExistingWalletRoute'),
      ),
      instanceName: 'ChooseNetworkRoute',
    );
    gh.factory<_i976.BrowserTabsListWidgetModel>(() =>
        _i976.BrowserTabsListWidgetModel(gh<_i747.BrowserTabsListModel>()));
    gh.factory<_i962.MigrateConfigurator>(() => _i962.MigrateConfigurator(
          gh<_i426.EncryptedStorage>(),
          gh<_i128.PresetsConnectionService>(),
          gh<_i128.GeneralStorageService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i940.DatabaseService>(),
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
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletMultisigConfigRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletDeployConfirmRoute'),
        gh<_i82.CompassBaseRoute>(
            instanceName: 'ConfirmMultisigTransactionRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'ConfigureNetworksRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'StakingRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'EnterSeedNameRoute'),
      ),
      instanceName: 'WalletRoute',
    );
    gh.factory<_i173.ChooseNetworkScreenModel>(
        () => _i173.ChooseNetworkScreenModel(
              gh<_i83.ErrorHandler>(),
              gh<_i632.MessengerService>(),
              gh<_i128.NetworkConnectionService>(),
              gh<_i128.PresetsConnectionService>(),
              gh<_i128.ConnectionsStorageService>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i81.CreateSeedPasswordProfileModel>(
        () => _i81.CreateSeedPasswordProfileModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.NetworkConnectionService>(),
              gh<_i632.MessengerService>(),
              gh<_i128.ConnectionsStorageService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.BiometryService>(),
              gh<_i128.AppStorageService>(),
            ));
    gh.singleton<_i754.ConnectionService>(() => _i754.ConnectionService(
          gh<_i128.ConnectionsStorageService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
          gh<_i361.Dio>(),
        ));
    gh.singleton<_i402.CurrentAccountsService>(
        () => _i402.CurrentAccountsService(
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrentKeyService>(),
              gh<_i128.GeneralStorageService>(),
              gh<_i128.ConnectionsStorageService>(),
            ));
    gh.factory<_i513.AddAccountConfirmModel>(() => _i513.AddAccountConfirmModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.BiometryService>(),
          gh<_i632.MessengerService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentAccountsService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i1010.OnBoardingRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ChooseNetworkRoute')),
      instanceName: 'OnBoardingRoute',
    );
    gh.factory<_i920.AddAccountConfirmWidgetModel>(() =>
        _i920.AddAccountConfirmWidgetModel(gh<_i513.AddAccountConfirmModel>()));
    gh.factory<_i57.RequestPermissionsModel>(() => _i57.RequestPermissionsModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.PermissionsService>(),
          gh<_i128.CurrentAccountsService>(),
        ));
    gh.factory<_i385.ConfigureNetworksModel>(() => _i385.ConfigureNetworksModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.ConnectionsStorageService>(),
        ));
    gh.factory<_i703.SelectNetworkModel>(() => _i703.SelectNetworkModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.ConnectionsStorageService>(),
        ));
    gh.factory<_i1042.WorkchainSelectorModel>(
        () => _i1042.WorkchainSelectorModel(
              gh<_i83.ErrorHandler>(),
              gh<_i284.ConnectionsStorageService>(),
            ));
    gh.factory<_i1011.SelectWorkchainModel>(() => _i1011.SelectWorkchainModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.ConnectionsStorageService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i302.ProfileRoute(
          gh<_i82.CompassBaseRoute>(instanceName: 'ManageSeedsAccountsRoute')),
      instanceName: 'ProfileRoute',
    );
    gh.factory<_i312.TokenWalletSendWidgetModel>(() =>
        _i312.TokenWalletSendWidgetModel(gh<_i523.TokenWalletSendModel>()));
    gh.singleton<_i725.StorageManagerService>(() => _i725.StorageManagerService(
          gh<_i128.SecureStorageService>(),
          gh<_i128.GeneralStorageService>(),
          gh<_i988.BrowserGroupsStorageService>(),
          gh<_i634.BrowserTabsStorageService>(),
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
          gh<_i865.LedgerStorageService>(),
        ));
    gh.factory<_i295.SelectWorkchainWidgetModel>(() =>
        _i295.SelectWorkchainWidgetModel(gh<_i1011.SelectWorkchainModel>()));
    gh.factory<_i561.AddNetworkModel>(() => _i561.AddNetworkModel(
          gh<_i83.ErrorHandler>(),
          gh<_i632.MessengerService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i128.ConnectionService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i710.ChangeNetworkModel>(() => _i710.ChangeNetworkModel(
          gh<_i83.ErrorHandler>(),
          gh<_i632.MessengerService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i622.WalletAppBarModel>(() => _i622.WalletAppBarModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i128.AppLinksService>(),
        ));
    gh.factory<_i634.StorageConfigurator>(
        () => _i634.StorageConfigurator(gh<_i128.StorageManagerService>()));
    gh.factory<_i639.ChangeNetworkWidgetModel>(
        () => _i639.ChangeNetworkWidgetModel(gh<_i710.ChangeNetworkModel>()));
    gh.factory<_i1055.ConfigureNetworksWidgetModel>(() =>
        _i1055.ConfigureNetworksWidgetModel(
            gh<_i385.ConfigureNetworksModel>()));
    gh.factory<_i175.SelectNetworkWidgetModel>(
        () => _i175.SelectNetworkWidgetModel(gh<_i703.SelectNetworkModel>()));
    gh.factory<_i317.AddNetworkWidgetModel>(
        () => _i317.AddNetworkWidgetModel(gh<_i4.AddNetworkModel>()));
    gh.singleton<_i1052.CurrenciesService>(() => _i1052.CurrenciesService(
          dio: gh<_i361.Dio>(),
          nekotonRepository: gh<_i771.NekotonRepository>(),
          currentAccounts: gh<_i128.CurrentAccountsService>(),
          storageService: gh<_i128.GeneralStorageService>(),
          appLifecycle: gh<_i128.AppLifecycleService>(),
          defaultFetchStrategy: gh<_i128.DefaultCurrenciesFetchStrategy>(),
          tonFetchStrategy: gh<_i128.TonCurrenciesFetchStrategy>(),
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
    gh.factory<_i693.WalletAppBarWidgetModel>(
        () => _i693.WalletAppBarWidgetModel(gh<_i622.WalletAppBarModel>()));
    gh.factory<_i445.CreateSeedPasswordProfileWidgetModel>(() =>
        _i445.CreateSeedPasswordProfileWidgetModel(
            gh<_i81.CreateSeedPasswordProfileModel>()));
    gh.factory<_i125.NftTransferInfoModel>(() => _i125.NftTransferInfoModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrenciesService>(),
        ));
    gh.factory<_i330.AccountTransactionsTabModel>(
        () => _i330.AccountTransactionsTabModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.TonWalletStorageService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrenciesService>(),
            ));
    gh.factory<_i459.AddAccountResultModel>(() => _i459.AddAccountResultModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentKeyService>(),
          gh<_i128.CurrentAccountsService>(),
        ));
    gh.singleton<_i263.NftService>(() => _i263.NftService(
          gh<_i771.NekotonRepository>(),
          gh<_i1015.NftStorageService>(),
          gh<_i128.AppStorageService>(),
          gh<_i128.CurrentAccountsService>(),
        ));
    gh.singleton<_i82.CompassBaseRoute>(
      () => _i786.RootRoute(
        gh<_i82.CompassBaseRoute>(instanceName: 'WalletRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'BrowserRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'ProfileRoute'),
        gh<_i82.CompassBaseRoute>(instanceName: 'NftRoute'),
      ),
      instanceName: 'RootRoute',
    );
    gh.factory<_i1015.RequestPermissionsWidgetModel>(() =>
        _i1015.RequestPermissionsWidgetModel(
            gh<_i4.RequestPermissionsModel>()));
    gh.factory<_i88.TCConnectModel>(() => _i88.TCConnectModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentAccountsService>(),
        ));
    gh.factory<_i588.AddTip3TokenModel>(() => _i588.AddTip3TokenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.AssetsService>(),
        ));
    gh.factory<_i1005.WorkchainSelectorWidgetModel>(() =>
        _i1005.WorkchainSelectorWidgetModel(
            gh<_i1042.WorkchainSelectorModel>()));
    gh.factory<_i124.ChooseNetworkScreenWidgetModel>(() =>
        _i124.ChooseNetworkScreenWidgetModel(
            gh<_i173.ChooseNetworkScreenModel>()));
    gh.factory<_i791.WalletDeployConfirmModel>(
        () => _i791.WalletDeployConfirmModel(
              gh<_i83.ErrorHandler>(),
              gh<_i291.WalletDeploymentService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrenciesService>(),
              gh<_i865.LedgerService>(),
              gh<_i865.BleAvailabilityModelDelegate>(),
            ));
    gh.factory<_i251.StakingPageModel>(() => _i251.StakingPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrenciesService>(),
          gh<_i948.StakingService>(),
          gh<_i128.AssetsService>(),
          gh<_i128.GeneralStorageService>(),
        ));
    gh.factory<_i1035.SelectAccountModel>(() => _i1035.SelectAccountModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrentKeyService>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i128.BalanceStorageService>(),
        ));
    gh.factory<_i833.NftTransferInfoWidgetModel>(() =>
        _i833.NftTransferInfoWidgetModel(gh<_i1015.NftTransferInfoModel>()));
    gh.factory<_i321.AddNftModel>(() => _i321.AddNftModel(
          gh<_i83.ErrorHandler>(),
          gh<_i402.CurrentAccountsService>(),
          gh<_i632.MessengerService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i905.CreateSeedPasswordScreenModel>(
        () => _i905.CreateSeedPasswordScreenModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.BiometryService>(),
              gh<_i128.CurrentKeyService>(),
              gh<_i128.CurrentAccountsService>(),
              gh<_i128.ConnectionsStorageService>(),
              gh<_i632.MessengerService>(),
              gh<_i771.NekotonRepository>(),
            ));
    gh.factory<_i762.CreateSeedPasswordScreenWidgetModel>(() =>
        _i762.CreateSeedPasswordScreenWidgetModel(
            gh<_i905.CreateSeedPasswordScreenModel>()));
    gh.factory<_i159.ConnectionConfigurator>(() => _i159.ConnectionConfigurator(
          gh<_i754.ConnectionService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i313.WalletDeployConfirmWidgetModel>(() =>
        _i313.WalletDeployConfirmWidgetModel(
            gh<_i791.WalletDeployConfirmModel>()));
    gh.factory<_i374.AddNftWidgetModel>(
        () => _i374.AddNftWidgetModel(gh<_i321.AddNftModel>()));
    gh.factory<_i450.CancelUnstakingPageModel>(
        () => _i450.CancelUnstakingPageModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i948.StakingService>(),
              gh<_i128.AssetsService>(),
            ));
    gh.factory<_i207.TokenTransferInfoModel>(() => _i207.TokenTransferInfoModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrenciesService>(),
          gh<_i128.AssetsService>(),
        ));
    gh.factory<_i371.SelectAccountWidgetModel>(
        () => _i371.SelectAccountWidgetModel(gh<_i1035.SelectAccountModel>()));
    gh.factory<_i904.StakingPageWidgetModel>(
        () => _i904.StakingPageWidgetModel(gh<_i0.StakingPageModel>()));
    gh.singleton<_i299.SessionService>(() => _i299.SessionService(
          gh<_i771.NekotonRepository>(),
          gh<_i725.StorageManagerService>(),
          gh<_i679.SecureStorageService>(),
          gh<_i958.IIdentifyIconsService>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i178.TokenWalletTransactionsModel>(
        () => _i178.TokenWalletTransactionsModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrenciesService>(),
              gh<_i128.TokenWalletStorageService>(),
            ));
    gh.factory<_i149.WalletPrepareTransferPageModel>(
        () => _i149.WalletPrepareTransferPageModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.AssetsService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
              gh<_i128.CurrenciesService>(),
              gh<_i201.TokenTransferDelegateProvider>(),
            ));
    gh.factory<_i668.AddTip3TokenWidgetModel>(
        () => _i668.AddTip3TokenWidgetModel(gh<_i588.AddTip3TokenModel>()));
    gh.factory<_i1024.SelectNewAssetPageModel>(
        () => _i1024.SelectNewAssetPageModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.AssetsService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i362.NftSendModel>(() => _i362.NftSendModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i1015.NftService>(),
          gh<_i865.LedgerService>(),
          gh<_i865.BleAvailabilityModelDelegate>(),
        ));
    gh.factory<_i522.TCConnectWidgetModel>(
        () => _i522.TCConnectWidgetModel(gh<_i625.TCConnectModel>()));
    gh.singleton<_i637.BalanceService>(() => _i637.BalanceService(
          gh<_i771.NekotonRepository>(),
          gh<_i128.CurrenciesService>(),
          gh<_i128.BalanceStorageService>(),
        ));
    gh.singleton<_i877.TokenWalletsService>(() => _i877.TokenWalletsService(
          gh<_i771.NekotonRepository>(),
          gh<_i128.AssetsService>(),
          gh<_i188.TokenRepository>(),
          gh<_i104.ResourcesService>(),
        ));
    gh.factory<_i154.BrowserPageModel>(() => _i154.BrowserPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i470.BrowserService>(),
          gh<_i654.BrowserApprovalsService>(),
          gh<_i473.PermissionsService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
          gh<_i964.AssetsService>(),
          gh<_i284.ConnectionsStorageService>(),
          gh<_i754.ConnectionService>(),
          gh<_i625.TonConnectJsBridge>(),
          gh<_i865.LedgerService>(),
          gh<_i1070.AppPermissionsService>(),
        ));
    gh.factory<_i516.CancelUnstakingPageWidgetModel>(() =>
        _i516.CancelUnstakingPageWidgetModel(
            gh<_i0.CancelUnstakingPageModel>()));
    gh.factory<_i57.AddAccountResultWidgetModel>(() =>
        _i57.AddAccountResultWidgetModel(gh<_i459.AddAccountResultModel>()));
    gh.factory<_i1038.NftPrepareTransferModel>(
        () => _i1038.NftPrepareTransferModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
              gh<_i1015.NftService>(),
            ));
    gh.factory<_i680.NftPageModel>(() => _i680.NftPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i1015.NftService>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i869.TokenWalletAssetModel>(() => _i869.TokenWalletAssetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.BalanceStorageService>(),
          gh<_i128.BalanceService>(),
          gh<_i128.CurrencyConvertService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i719.TonWalletAssetModel>(() => _i719.TonWalletAssetModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.BalanceStorageService>(),
          gh<_i128.BalanceService>(),
          gh<_i128.CurrencyConvertService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i71.TonWalletDetailsPageModel>(
        () => _i71.TonWalletDetailsPageModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i27.CurrencyConvertService>(),
              gh<_i637.BalanceService>(),
            ));
    gh.factory<_i793.AccountTransactionsTabWidgetModel>(() =>
        _i793.AccountTransactionsTabWidgetModel(
            gh<_i1034.AccountTransactionsTabModel>()));
    gh.factory<_i307.BrowserPageWidgetModel>(
        () => _i307.BrowserPageWidgetModel(gh<_i154.BrowserPageModel>()));
    gh.factory<_i771.TokenWalletAssetWidgetModel>(() =>
        _i771.TokenWalletAssetWidgetModel(gh<_i869.TokenWalletAssetModel>()));
    gh.factory<_i526.TonWalletAssetWidgetModel>(
        () => _i526.TonWalletAssetWidgetModel(gh<_i719.TonWalletAssetModel>()));
    gh.factory<_i549.DeleteAccountSheetModel>(
        () => _i549.DeleteAccountSheetModel(
              errorHandler: gh<_i83.ErrorHandler>(),
              balanceService: gh<_i128.BalanceService>(),
              convertService: gh<_i128.CurrencyConvertService>(),
            ));
    gh.factory<_i941.TokenWalletDetailsModel>(
        () => _i941.TokenWalletDetailsModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i128.CurrencyConvertService>(),
              gh<_i128.BalanceService>(),
              gh<_i128.AssetsService>(),
              gh<_i201.TokenTransferDelegateProvider>(),
            ));
    gh.factory<_i236.WalletPrepareTransferPageWidgetModel>(() =>
        _i236.WalletPrepareTransferPageWidgetModel(
            gh<_i149.WalletPrepareTransferPageModel>()));
    gh.factory<_i11.DeleteAccountSheetWidgetModel>(() =>
        _i11.DeleteAccountSheetWidgetModel(
            gh<_i549.DeleteAccountSheetModel>()));
    gh.factory<_i972.NftPageWidgetModel>(
        () => _i972.NftPageWidgetModel(gh<_i1015.NftPageModel>()));
    gh.factory<_i289.SelectTokenModel>(() => _i289.SelectTokenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.TokenWalletsService>(),
        ));
    gh.factory<_i111.TokenTransferInfoWidgetModel>(() =>
        _i111.TokenTransferInfoWidgetModel(gh<_i207.TokenTransferInfoModel>()));
    gh.factory<_i78.AccountDetailModel>(() => _i78.AccountDetailModel(
          errorHandler: gh<_i83.ErrorHandler>(),
          nekotonRepository: gh<_i771.NekotonRepository>(),
          balanceService: gh<_i128.BalanceService>(),
          convertService: gh<_i128.CurrencyConvertService>(),
        ));
    gh.factory<_i343.AccountAssetsTabModel>(() => _i343.AccountAssetsTabModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.AssetsService>(),
          gh<_i128.TokenWalletsService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.factory<_i615.AccountCardModel>(() => _i615.AccountCardModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i128.BalanceService>(),
          gh<_i128.CurrencyConvertService>(),
          gh<_i128.BalanceStorageService>(),
          gh<_i632.MessengerService>(),
          gh<_i948.StakingService>(),
        ));
    gh.factory<_i425.NftSendWidgetModel>(
        () => _i425.NftSendWidgetModel(gh<_i1015.NftSendModel>()));
    gh.factory<_i127.TokenWalletTransactionsWidgetModel>(() =>
        _i127.TokenWalletTransactionsWidgetModel(
            gh<_i178.TokenWalletTransactionsModel>()));
    gh.factory<_i483.SelectNewAssetPageWidgetModel>(() =>
        _i483.SelectNewAssetPageWidgetModel(
            gh<_i158.SelectNewAssetPageModel>()));
    gh.factory<_i397.TonWalletDetailsPageWidgetModel>(() =>
        _i397.TonWalletDetailsPageWidgetModel(
            gh<_i71.TonWalletDetailsPageModel>()));
    gh.factory<_i690.FeatureServicesConfigurator>(
        () => _i690.FeatureServicesConfigurator(
              gh<_i484.UpdateService>(),
              gh<_i128.CurrentSeedService>(),
              gh<_i128.CurrentAccountsService>(),
              gh<_i128.CurrenciesService>(),
              gh<_i128.AssetsService>(),
              gh<_i128.PermissionsService>(),
              gh<_i811.StakingService>(),
              gh<_i128.TokenWalletsService>(),
              gh<_i1071.TonConnectHttpBridge>(),
              gh<_i188.TokenRepository>(),
              gh<_i263.NftService>(),
              gh<_i188.GaslessRepository>(),
            ));
    gh.factory<_i209.TokenWalletDetailsWidgetModel>(() =>
        _i209.TokenWalletDetailsWidgetModel(
            gh<_i941.TokenWalletDetailsModel>()));
    gh.factory<_i718.SelectTokenWidgetModel>(
        () => _i718.SelectTokenWidgetModel(gh<_i289.SelectTokenModel>()));
    gh.factory<_i143.NftPrepareTransferWidgetModel>(() =>
        _i143.NftPrepareTransferWidgetModel(
            gh<_i1015.NftPrepareTransferModel>()));
    gh.factory<_i963.AccountDetailWidgetModel>(
        () => _i963.AccountDetailWidgetModel(gh<_i78.AccountDetailModel>()));
    gh.factory<_i695.AccountAssetsTabWidgetModel>(() =>
        _i695.AccountAssetsTabWidgetModel(gh<_i343.AccountAssetsTabModel>()));
    gh.factory<_i645.AccountCardWidgetModel>(
        () => _i645.AccountCardWidgetModel(gh<_i615.AccountCardModel>()));
    gh.singleton<_i468.BootstrapService>(() => _i468.BootstrapService(
          gh<_i116.PresetsConnectionService>(),
          gh<_i728.BiometryConfigurator>(),
          gh<_i159.ConnectionConfigurator>(),
          gh<_i569.EncryptedStorageConfigurator>(),
          gh<_i690.FeatureServicesConfigurator>(),
          gh<_i962.MigrateConfigurator>(),
          gh<_i634.StorageConfigurator>(),
          gh<_i388.NekotonConfigurator>(),
          gh<_i231.NtpConfigurator>(),
        ));
    gh.factory<_i884.BootstrapFailedRerunModel>(
        () => _i884.BootstrapFailedRerunModel(
              gh<_i83.ErrorHandler>(),
              gh<_i468.BootstrapService>(),
              gh<_i632.MessengerService>(),
            ));
    gh.factory<_i1007.ConnectionFailModel>(() => _i1007.ConnectionFailModel(
          gh<_i83.ErrorHandler>(),
          gh<_i468.BootstrapService>(),
          gh<_i632.MessengerService>(),
        ));
    gh.factory<_i926.BootstrapFailedRerunWidgetModel>(() =>
        _i926.BootstrapFailedRerunWidgetModel(
            gh<_i9.BootstrapFailedRerunModel>()));
    gh.singleton<_i82.CompassGuard>(
      () => _i331.RestoreSubroutesGuard(
        gh<_i275.NavigationService>(),
        gh<_i468.BootstrapService>(),
      ),
      instanceName: 'RestoreSubroutesGuard',
    );
    gh.factory<_i459.ConnectionFailWidgetModel>(() =>
        _i459.ConnectionFailWidgetModel(gh<_i1007.ConnectionFailModel>()));
    gh.singleton<_i309.CompassRouter>(
        () => _i309.CompassRouter(gh<_i468.BootstrapService>()));
    gh.singleton<_i533.RootTabService>(() => _i533.RootTabService(
          gh<_i309.CompassRouter>(),
          gh<_i470.BrowserService>(),
        ));
    gh.singleton<_i82.CompassGuard>(
      () => _i13.OnboardingGuard(
        gh<_i468.BootstrapService>(),
        gh<_i771.NekotonRepository>(),
      ),
      instanceName: 'OnboardingGuard',
    );
    gh.factory<_i70.BrowserLauncher>(() => _i70.BrowserLauncher(
          gh<_i309.CompassRouter>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i342.ProfilePageModel>(() => _i342.ProfilePageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.CurrentSeedService>(),
          gh<_i128.BiometryService>(),
          gh<_i128.SessionService>(),
          gh<_i143.AppVersionService>(),
          gh<_i70.BrowserLauncher>(),
        ));
    gh.factory<_i857.NftCollectionPageModel>(() => _i857.NftCollectionPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i1015.NftService>(),
          gh<_i1015.NftStorageService>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i553.MessengerService>(),
          gh<_i70.BrowserLauncher>(),
        ));
    gh.factory<_i328.EditNetworkModel>(() => _i328.EditNetworkModel(
          gh<_i128.ConnectionsStorageService>(),
          gh<_i128.PresetsConnectionService>(),
          gh<_i128.AssetsService>(),
          gh<_i70.BrowserLauncher>(),
        ));
    gh.factory<_i582.SplashScreenModel>(() => _i582.SplashScreenModel(
          gh<_i83.ErrorHandler>(),
          gh<_i468.BootstrapService>(),
          gh<_i275.NavigationService>(),
          gh<_i33.NetworkConnectionService>(),
          gh<_i470.BrowserService>(),
        ));
    gh.factory<_i311.TokenWalletOrdinaryTransactionDetailsScreenModel>(
        () => _i311.TokenWalletOrdinaryTransactionDetailsScreenModel(
              gh<_i83.ErrorHandler>(),
              gh<_i128.AssetsService>(),
              gh<_i771.NekotonRepository>(),
              gh<_i70.BrowserLauncher>(),
            ));
    gh.factory<_i348.WalletPageModel>(() => _i348.WalletPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i128.AssetsService>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i128.AppStorageService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i533.RootTabService>(),
        ));
    gh.singleton<_i239.PendingDeepLinkService>(
      () => _i239.PendingDeepLinkService(gh<_i70.BrowserLauncher>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i942.EditNetworkWidgetModel>(
        () => _i942.EditNetworkWidgetModel(gh<_i393.EditNetworkModel>()));
    gh.factory<_i278.CustomBottomNavigationBarModel>(
        () => _i278.CustomBottomNavigationBarModel(
              gh<_i83.ErrorHandler>(),
              gh<_i533.RootTabService>(),
            ));
    gh.factory<_i8.AccountSettingsModel>(() => _i8.AccountSettingsModel(
          gh<_i83.ErrorHandler>(),
          gh<_i771.NekotonRepository>(),
          gh<_i632.MessengerService>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i70.BrowserLauncher>(),
        ));
    gh.factory<_i641.NftItemPageModel>(() => _i641.NftItemPageModel(
          gh<_i83.ErrorHandler>(),
          gh<_i1015.NftService>(),
          gh<_i128.CurrentAccountsService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i70.BrowserLauncher>(),
        ));
    gh.factory<_i212.NftCollectionPageWidgetModel>(() =>
        _i212.NftCollectionPageWidgetModel(
            gh<_i1015.NftCollectionPageModel>()));
    gh.factory<_i1031.AccountSettingsSheetModel>(
        () => _i1031.AccountSettingsSheetModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i632.MessengerService>(),
              gh<_i70.BrowserLauncher>(),
            ));
    gh.factory<_i996.TokenWalletOrdinaryTransactionDetailsScreenWidgetModel>(
        () => _i996.TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
            gh<_i311.TokenWalletOrdinaryTransactionDetailsScreenModel>()));
    gh.factory<_i348.NftItemPageWidgetModel>(
        () => _i348.NftItemPageWidgetModel(gh<_i1015.NftItemPageModel>()));
    gh.factory<_i659.SplashScreenWidgetModel>(
        () => _i659.SplashScreenWidgetModel(gh<_i582.SplashScreenModel>()));
    gh.factory<_i700.ProfilePageWidgetModel>(
        () => _i700.ProfilePageWidgetModel(gh<_i342.ProfilePageModel>()));
    gh.factory<_i249.CustomBottomNavigationBarWidgetModel>(() =>
        _i249.CustomBottomNavigationBarWidgetModel(
            gh<_i278.CustomBottomNavigationBarModel>()));
    gh.factory<_i161.TonWalletMultisigOrdinaryTransactionDetailsScreenModel>(
        () => _i161.TonWalletMultisigOrdinaryTransactionDetailsScreenModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i70.BrowserLauncher>(),
            ));
    gh.factory<_i562.TonWalletOrdinaryTransactionDetailsModel>(
        () => _i562.TonWalletOrdinaryTransactionDetailsModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i70.BrowserLauncher>(),
            ));
    gh.factory<_i938.TonWalletMultisigExpiredTransactionModel>(
        () => _i938.TonWalletMultisigExpiredTransactionModel(
              gh<_i83.ErrorHandler>(),
              gh<_i771.NekotonRepository>(),
              gh<_i70.BrowserLauncher>(),
            ));
    gh.factory<_i765.TonWalletMultisigExpiredTransactionWidgetModel>(() =>
        _i765.TonWalletMultisigExpiredTransactionWidgetModel(
            gh<_i938.TonWalletMultisigExpiredTransactionModel>()));
    gh.factory<_i938.WalletPageWidgetModel>(
        () => _i938.WalletPageWidgetModel(gh<_i348.WalletPageModel>()));
    gh.factory<_i425.AppModel>(() => _i425.AppModel(
          gh<_i83.ErrorHandler>(),
          gh<_i309.CompassRouter>(),
          gh<_i850.AppLinksService>(),
          gh<_i830.AppLifecycleService>(),
          gh<_i1071.LocalizationService>(),
          gh<_i575.BiometryService>(),
          gh<_i632.MessengerService>(),
          gh<_i47.CrashDetectorService>(),
          gh<_i335.LoggerConfigurator>(),
          gh<_i70.BrowserLauncher>(),
          gh<_i771.NekotonRepository>(),
          gh<_i468.BootstrapService>(),
          gh<_i239.PendingDeepLinkService>(),
        ));
    gh.factory<
            _i1010
            .TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel>(
        () => _i1010
            .TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel(gh<
                _i161
                .TonWalletMultisigOrdinaryTransactionDetailsScreenModel>()));
    gh.factory<_i1017.AppWidgetModel>(
        () => _i1017.AppWidgetModel(gh<_i425.AppModel>()));
    gh.factory<_i962.AccountSettingsWidgetModel>(
        () => _i962.AccountSettingsWidgetModel(gh<_i8.AccountSettingsModel>()));
    gh.factory<_i541.AccountSettingsSheetWidgetModel>(() =>
        _i541.AccountSettingsSheetWidgetModel(
            gh<_i1031.AccountSettingsSheetModel>()));
    gh.factory<_i408.TonWalletOrdinaryTransactionDetailsWidgetModel>(() =>
        _i408.TonWalletOrdinaryTransactionDetailsWidgetModel(
            gh<_i562.TonWalletOrdinaryTransactionDetailsModel>()));
    return this;
  }
}

class _$SentryModule extends _i438.SentryModule {}

class _$DioModule extends _i720.DioModule {}
