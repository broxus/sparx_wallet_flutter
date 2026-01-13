import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_save_phrase.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_account_confirm_model.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_account_confirm_wm.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_new_account_confirm_sheet.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_data.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_dialog.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_model.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_data.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_dialog.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_model.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_wm.dart';
import 'package:app/widgets/protected_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class MockProtectedContentService extends Mock
    implements ProtectedContentService {}

// Mock services needed for fake models
class MockErrorHandler extends Mock implements ErrorHandler {}

class MockSeedList extends Mock implements SeedList {}

class MockNekotonRepository extends Mock implements NekotonRepository {
  MockNekotonRepository() {
    // Stub seedList to return a mock SeedList to avoid null errors
    when(() => seedList).thenReturn(MockSeedList());
  }
}

class MockMessengerService extends Mock implements MessengerService {}

class MockAppStorageService extends Mock implements AppStorageService {}

class MockBiometryService extends Mock implements BiometryService {}

class MockCurrentSeedService extends Mock implements CurrentSeedService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockNtpService extends Mock implements NtpService {}

class MockCurrentAccountsService extends Mock
    implements CurrentAccountsService {}

// Create a real PasswordService with mocked dependencies
PasswordService _createTestPasswordService() {
  final mockSecureStorageService = MockSecureStorageService();
  final mockNekotonRepository = MockNekotonRepository();
  final mockNtpService = MockNtpService();

  // Setup minimal stubs for password service
  when(
    mockSecureStorageService.getPasswordServiceStateJson,
  ).thenAnswer((_) async => null);
  when(
    () => mockNekotonRepository.seedChangesStream,
  ).thenAnswer((_) => const Stream.empty());

  return PasswordService(
    mockSecureStorageService,
    mockNekotonRepository,
    mockNtpService,
  );
}

// Fake model classes that extend real models (not mocks)
class FakeManualBackUpModel extends ManualBackUpModel {
  FakeManualBackUpModel()
    : super(
        MockErrorHandler(),
        MockNekotonRepository(),
        MockMessengerService(),
        MockAppStorageService(),
      );

  @override
  void setShowingBackUpFlag(String address) {}

  @override
  void showMessageAboutCopy() {}
}

class FakeConfirmActionModel extends ConfirmActionModel {
  FakeConfirmActionModel()
    : super(
        MockErrorHandler(),
        MockBiometryService(),
        MockNekotonRepository(),
        MockCurrentSeedService(),
        MockMessengerService(),
        _createTestPasswordService(),
      );
}

class FakeAddAccountConfirmModel extends AddAccountConfirmModel {
  FakeAddAccountConfirmModel()
    : super(
        MockErrorHandler(),
        MockBiometryService(),
        MockMessengerService(),
        MockNekotonRepository(),
        MockCurrentAccountsService(),
        _createTestPasswordService(),
      );
}

class FakeChangeSeedPasswordModel extends ChangeSeedPasswordModel {
  FakeChangeSeedPasswordModel()
    : super(
        MockErrorHandler(),
        MockNekotonRepository(),
        MockBiometryService(),
        MockMessengerService(),
        _createTestPasswordService(),
      );
}

class FakeManualBackUpWidgetModel extends ManualBackUpWidgetModel {
  FakeManualBackUpWidgetModel() : super(FakeManualBackUpModel());

  late ThemeStyleV2 _themeStyle;
  late ValueNotifier<List<String>> _wordsState;
  late EntityStateNotifier<ManualBackUpData> _screenState;

  void configure({
    required ThemeStyleV2 themeStyle,
    required ValueNotifier<List<String>> wordsState,
    required EntityStateNotifier<ManualBackUpData> screenState,
  }) {
    _themeStyle = themeStyle;
    _wordsState = wordsState;
    _screenState = screenState;
  }

  @override
  ThemeStyleV2 get themeStyle => _themeStyle;

  @override
  ValueListenable<List<String>> get wordsState => _wordsState;

  @override
  EntityStateNotifier<ManualBackUpData> get screenState => _screenState;

  @override
  Future<void> copySeed() async {}

  @override
  void clickCheckPhrase(BuildContext context) {}

  @override
  void clickSkip(BuildContext context) {}
}

class FakeConfirmActionWidgetModel extends ConfirmActionWidgetModel {
  FakeConfirmActionWidgetModel() : super(FakeConfirmActionModel());

  late ThemeStyleV2 _themeStyle;
  late ValueNotifier<KeyAccount?> _accountState;
  late TextEditingController _passwordController;
  late ListenableState<bool> _isPasswordLockedState;
  late ListenableState<List<BiometricType>> _availableBiometryState;
  late EntityStateNotifier<ConfirmActionData> _screenState;

  void configure({
    required ThemeStyleV2 themeStyle,
    required ValueNotifier<KeyAccount?> accountState,
    required TextEditingController passwordController,
    required ListenableState<bool> isPasswordLockedState,
    required ListenableState<List<BiometricType>> availableBiometryState,
    required EntityStateNotifier<ConfirmActionData> screenState,
  }) {
    _themeStyle = themeStyle;
    _accountState = accountState;
    _passwordController = passwordController;
    _isPasswordLockedState = isPasswordLockedState;
    _availableBiometryState = availableBiometryState;
    _screenState = screenState;
  }

  @override
  ThemeStyleV2 get themeStyle => _themeStyle;

  @override
  ValueNotifier<KeyAccount?> get accountState => _accountState;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  @override
  ListenableState<List<BiometricType>> get availableBiometryState =>
      _availableBiometryState;

  @override
  EntityStateNotifier<ConfirmActionData> get screenState => _screenState;

  @override
  Future<void> onClickConfirm() async {}

  @override
  Future<void> onUseBiometry() async {}
}

class FakeAddAccountConfirmWidgetModel extends AddAccountConfirmWidgetModel {
  FakeAddAccountConfirmWidgetModel() : super(FakeAddAccountConfirmModel());

  late ThemeStyleV2 _theme;
  late String _seedName;
  late TextEditingController _controller;
  late ListenableState<bool> _isPasswordLockedState;
  late ListenableState<List<BiometricType>> _availableBiometryState;

  void configure({
    required ThemeStyleV2 theme,
    required String seedName,
    required TextEditingController controller,
    required ListenableState<bool> isPasswordLockedState,
    required ListenableState<List<BiometricType>> availableBiometryState,
  }) {
    _theme = theme;
    _seedName = seedName;
    _controller = controller;
    _isPasswordLockedState = isPasswordLockedState;
    _availableBiometryState = availableBiometryState;
  }

  @override
  ThemeStyleV2 get theme => _theme;

  @override
  String get seedName => _seedName;

  @override
  TextEditingController get controller => _controller;

  @override
  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  @override
  ListenableState<List<BiometricType>> get availableBiometryState =>
      _availableBiometryState;

  @override
  Future<void> onPasswordSubmit() async {}

  @override
  Future<void> onUseBiometry() async {}
}

class FakeChangeSeedPasswordWidgetModel extends ChangeSeedPasswordWidgetModel {
  FakeChangeSeedPasswordWidgetModel() : super(FakeChangeSeedPasswordModel());

  late GlobalKey<FormState> _formKey;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late FocusNode _newPasswordFocusNode;
  late ListenableState<bool> _isPasswordLockedState;

  void configure({
    required GlobalKey<FormState> formKey,
    required TextEditingController oldPasswordController,
    required TextEditingController newPasswordController,
    required FocusNode newPasswordFocusNode,
    required ListenableState<bool> isPasswordLockedState,
  }) {
    _formKey = formKey;
    _oldPasswordController = oldPasswordController;
    _newPasswordController = newPasswordController;
    _newPasswordFocusNode = newPasswordFocusNode;
    _isPasswordLockedState = isPasswordLockedState;
  }

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  TextEditingController get oldPasswordController => _oldPasswordController;

  @override
  TextEditingController get newPasswordController => _newPasswordController;

  @override
  FocusNode get newPasswordFocusNode => _newPasswordFocusNode;

  @override
  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  @override
  String? inputValidator(String? value) => null;

  @override
  Future<void> onSubmitChange([String? _]) async {}
}

class FakeKeyAccount extends Fake implements KeyAccount {}

class FakeBuildContext extends Fake implements BuildContext {}

class SimpleListenableState<T> extends ValueNotifier<T>
    implements ListenableState<T> {
  SimpleListenableState(super.value);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockProtectedContentService protectedContentService;

  setUpAll(() async {
    registerFallbackValue(PublicKey(publicKey: List.filled(64, 'a').join()));
    registerFallbackValue(FakeKeyAccount());
    registerFallbackValue(FakeBuildContext());
    await EasyLocalization.ensureInitialized();
  });

  setUp(() async {
    await getIt.reset();
    protectedContentService = MockProtectedContentService();
    when(
      () => protectedContentService.enableProtectedContent(),
    ).thenAnswer((_) async {});
    when(
      () => protectedContentService.disableProtectedContent(),
    ).thenAnswer((_) async {});

    getIt
      ..registerSingleton<ProtectedContentService>(protectedContentService)
      ..registerFactory<ManualBackUpWidgetModel>(_buildManualBackUpWm)
      ..registerFactory<ConfirmActionWidgetModel>(_buildConfirmActionWm)
      ..registerFactory<AddAccountConfirmWidgetModel>(_buildAddAccountConfirmWm)
      ..registerFactory<ChangeSeedPasswordWidgetModel>(
        _buildChangeSeedPasswordWm,
      );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('Protected bottom sheets', () {
    testWidgets(
      'export seed save phrase route keeps ProtectedContent wrappers',
      (tester) async {
        final phrase = List<String>.generate(12, (index) => 'word$index');

        await _pumpSheet(
          tester,
          (context) => Navigator.of(context).push(
            exportSeedSavePhraseRoute(
              Theme.of(context).textTheme.titleLarge ?? const TextStyle(),
              phrase,
            ),
          ),
        );

        expect(find.byType(ProtectedContent), findsNWidgets(2));
      },
    );

    testWidgets('change seed password bottom sheet is protected', (
      tester,
    ) async {
      await _pumpSheet(
        tester,
        (context) => Navigator.of(context).push(
          changeSeedPasswordSheetRoute(
            context,
            PublicKey(publicKey: List.filled(64, 'a').join()),
          ),
        ),
      );

      expect(find.byType(ProtectedContent), findsOneWidget);
    });

    testWidgets('add account confirm bottom sheet is protected', (
      tester,
    ) async {
      await _pumpSheet(
        tester,
        (context) => showAddAccountConfirmSheet(
          context: context,
          publicKey: PublicKey(publicKey: List.filled(64, 'a').join()),
          seedName: 'My seed',
        ),
      );

      expect(find.byType(ProtectedContent), findsOneWidget);
    });

    testWidgets('confirm action bottom sheet is protected', (tester) async {
      await _pumpSheet(
        tester,
        (context) => showConfirmActionDialog(context, FakeKeyAccount(), (_) {}),
      );

      expect(find.byType(ProtectedContent), findsOneWidget);
    });

    testWidgets('manual backup bottom sheet is protected', (tester) async {
      await _pumpSheet(
        tester,
        (context) => showManualBackupDialog(
          context,
          const ['one', 'two', 'three', 'four'],
          '0:dummy',
          (_) {},
        ),
      );

      expect(find.byType(ProtectedContent), findsOneWidget);
    });
  });
}

Future<void> _pumpSheet(
  WidgetTester tester,
  FutureOr<dynamic> Function(BuildContext) openSheet,
) async {
  const locale = Locale('en');
  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [locale],
      path: 'assets/translations',
      fallbackLocale: locale,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, __) => Builder(
          builder: (easyContext) => MaterialApp(
            locale: locale,
            localizationsDelegates: easyContext.localizationDelegates,
            supportedLocales: easyContext.supportedLocales,
            theme: ThemeData(extensions: [getDefaultTheme()]),
            home: Scaffold(
              body: Center(
                child: Builder(
                  builder: (scaffoldContext) => ElevatedButton(
                    key: const ValueKey('open-sheet'),
                    onPressed: () async {
                      await openSheet(scaffoldContext);
                    },
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('open-sheet')));
  await tester.pumpAndSettle();

  // Add teardown to ensure async work is completed
  addTearDown(() async {
    // Dismiss any open sheets/dialogs
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  });
}

ManualBackUpWidgetModel _buildManualBackUpWm() {
  final wm = FakeManualBackUpWidgetModel();
  final screenState = EntityStateNotifier<ManualBackUpData>()
    ..content(ManualBackUpData(isCopied: false));
  wm.configure(
    themeStyle: getDefaultTheme(),
    wordsState: ValueNotifier<List<String>>(['one', 'two', 'three', 'four']),
    screenState: screenState,
  );
  return wm;
}

ConfirmActionWidgetModel _buildConfirmActionWm() {
  final wm = FakeConfirmActionWidgetModel();
  final screenState = EntityStateNotifier<ConfirmActionData>()
    ..content(ConfirmActionData());
  wm.configure(
    themeStyle: getDefaultTheme(),
    accountState: ValueNotifier<KeyAccount?>(null),
    passwordController: TextEditingController(),
    isPasswordLockedState: SimpleListenableState<bool>(false),
    availableBiometryState: SimpleListenableState<List<BiometricType>>([]),
    screenState: screenState,
  );
  return wm;
}

AddAccountConfirmWidgetModel _buildAddAccountConfirmWm() {
  final wm = FakeAddAccountConfirmWidgetModel()
    ..configure(
      theme: getDefaultTheme(),
      seedName: 'Seed',
      controller: TextEditingController(),
      isPasswordLockedState: SimpleListenableState<bool>(false),
      availableBiometryState: SimpleListenableState<List<BiometricType>>([]),
    );
  return wm;
}

ChangeSeedPasswordWidgetModel _buildChangeSeedPasswordWm() {
  final wm = FakeChangeSeedPasswordWidgetModel()
    ..configure(
      formKey: GlobalKey<FormState>(),
      oldPasswordController: TextEditingController(),
      newPasswordController: TextEditingController(),
      newPasswordFocusNode: FocusNode(),
      isPasswordLockedState: SimpleListenableState<bool>(false),
    );
  return wm;
}
