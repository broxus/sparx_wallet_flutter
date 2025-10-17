import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_page.dart';
import 'package:app/feature/biometry/route.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

// Constants for query parameter names
const _seedQueryParam = 'seed';
const _mnemonicTypeQueryParam = 'mnemonicType';
const _namePathParam = 'name';
const _typeQueryParam = 'type';
const _isCheckedQueryParam = 'isChecked';

@named
@Singleton(as: CompassBaseRoute)
class CreateSeedOnboardingPasswordRoute
    extends CompassRoute<CreateSeedOnboardingPasswordRouteData> {
  CreateSeedOnboardingPasswordRoute(
    @Named.from(EnableBiometryRoute) CompassBaseRoute enableBiometryRoute,
  ) : super(
        path: '/create-seed-onboarding-password',
        isSaveLocation: true,
        builder: (context, data, _) => CreateSeedPasswordScreen(
          phrase: SeedPhraseModel(data.seedPhrase),
          mnemonicType: data.mnemonicType,
        ),
        compassBaseRoutes: [enableBiometryRoute],
      );

  @override
  CreateSeedOnboardingPasswordRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final mnemonicTypeStr = queryParams[_mnemonicTypeQueryParam];
    final mnemonicType = mnemonicTypeStr != null
        ? const MnemonicTypeJsonConverter().fromJson(
            jsonDecode(mnemonicTypeStr) as Map<String, dynamic>,
          )
        : null;

    return CreateSeedOnboardingPasswordRouteData(
      seedPhrase: queryParams[_seedQueryParam],
      mnemonicType: mnemonicType,
    );
  }
}

class CreateSeedOnboardingPasswordRouteData implements CompassRouteDataQuery {
  const CreateSeedOnboardingPasswordRouteData({
    this.seedPhrase,
    this.mnemonicType,
  });

  final String? seedPhrase;
  final MnemonicType? mnemonicType;

  @override
  Map<String, String> toQueryParams() {
    final seedPhrase = this.seedPhrase;
    final mnemonicType = this.mnemonicType;

    return {
      if (seedPhrase != null) _seedQueryParam: seedPhrase,
      if (mnemonicType != null)
        _mnemonicTypeQueryParam: jsonEncode(mnemonicType.toJson()),
    };
  }
}

@named
@Singleton(as: CompassBaseRoute)
class CreateSeedPasswordRoute
    extends CompassRoute<CreateSeedPasswordRouteData> {
  CreateSeedPasswordRoute()
    : super(
        path: '/create-seed-password',
        isSaveLocation: true,
        builder: (context, data, _) => CreateSeedPasswordProfilePage(
          seedPhrase: SeedPhraseModel(data.seedPhrase),
          name: data.name,
          type: data.type,
          mnemonicType: data.mnemonicType,
          isChecked: data.isChecked,
        ),
      );

  @override
  CreateSeedPasswordRouteData fromQueryParams(Map<String, String> queryParams) {
    final mnemonicTypeStr = queryParams[_mnemonicTypeQueryParam];
    final mnemonicType = mnemonicTypeStr != null
        ? const MnemonicTypeJsonConverter().fromJson(
            jsonDecode(mnemonicTypeStr) as Map<String, dynamic>,
          )
        : null;
    final isChecked = bool.tryParse(queryParams[_isCheckedQueryParam] ?? '');

    return CreateSeedPasswordRouteData(
      type: SeedAddType.values.byName(queryParams[_typeQueryParam]!),
      seedPhrase: queryParams[_seedQueryParam],
      mnemonicType: mnemonicType,
      name: queryParams[_namePathParam],
      isChecked: isChecked ?? false,
    );
  }
}

class CreateSeedPasswordRouteData implements CompassRouteDataQuery {
  const CreateSeedPasswordRouteData({
    required this.type,
    this.seedPhrase,
    this.mnemonicType,
    this.name,
    this.isChecked = false,
  });

  final SeedAddType type;
  final String? seedPhrase;
  final MnemonicType? mnemonicType;
  final String? name;

  /// Indicates whether the seed phrase has been checked
  final bool isChecked;

  @override
  Map<String, String> toQueryParams() {
    final type = this.type;
    final seedPhrase = this.seedPhrase;
    final name = this.name;
    final mnemonicType = this.mnemonicType;
    final isChecked = this.isChecked;

    return {
      _typeQueryParam: type.name,
      _isCheckedQueryParam: isChecked.toString(),
      if (seedPhrase != null) _seedQueryParam: seedPhrase,
      if (name != null) _namePathParam: name,
      if (mnemonicType != null)
        _mnemonicTypeQueryParam: jsonEncode(mnemonicType.toJson()),
    };
  }
}
