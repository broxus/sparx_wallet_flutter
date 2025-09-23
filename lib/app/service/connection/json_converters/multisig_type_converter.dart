import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class MultisigTypeConverter
    extends JsonConverter<Map<MultisigType, String>, Map<String, dynamic>?> {
  const MultisigTypeConverter(this._defaultMultisigNames);

  final Map<MultisigType, String> _defaultMultisigNames;

  static final _log = Logger('MultisigTypeConverter');

  @override
  Map<MultisigType, String> fromJson(Map<String, dynamic>? json) {
    final result = Map<MultisigType, String>.from(_defaultMultisigNames);

    if (json != null) {
      for (final entry in json.entries) {
        final val = entry.value;
        if (val is! String) continue;

        try {
          result[MultisigType.values.byName(entry.key)] = val;
        } catch (e, s) {
          _log.severe('fromJson error', e, s);
          continue;
        }
      }
    }
    return result;
  }

  @override
  Map<String, dynamic> toJson(Map<MultisigType, String> object) {
    return {
      for (final e in object.entries) e.key.name: e.value,
    };
  }
}
