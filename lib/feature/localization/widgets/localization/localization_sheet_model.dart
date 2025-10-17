import 'package:app/feature/localization/localization.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalizationSheetModel extends ElementaryModel {
  LocalizationSheetModel(ErrorHandler errorHandler, this._localizationService)
    : super(errorHandler: errorHandler);

  final LocalizationService _localizationService;

  SupportedLocaleCodes get localeCode => _localizationService.localeCode;

  Stream<SupportedLocaleCodes> get localeCodeStream =>
      _localizationService.localeCodeStream;

  void setLocaleCode(SupportedLocaleCodes code) {
    _localizationService.changeLocaleCode(code);
  }
}
