import 'package:app/extensions/enum_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const defaultMultisigNames = <MultisigType, String>{
  MultisigType.safeMultisigWallet: 'SafeMultisig24h',
  MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
  MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
  MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
  MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
  MultisigType.surfWallet: 'Surf wallet',
  MultisigType.multisig2: 'Legacy Multisig',
  MultisigType.multisig2_1: 'Multisig',
};

class MultisigTypeConverter
    extends JsonConverter<Map<MultisigType, String>, Map<String, dynamic>?> {
  const MultisigTypeConverter();

  static final _log = Logger('MultisigTypeConverter');

  @override
  Map<MultisigType, String> fromJson(Map<String, dynamic>? json) {
    final result = Map<MultisigType, String>.from(defaultMultisigNames);

    if (json != null) {
      for (final entry in json.entries) {
        final val = entry.value;
        if (val is! String) continue;

        try {
          result[MultisigType.values.byNameNormalize(entry.key)] = val;
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
    return {for (final e in object.entries) e.key.name: e.value};
  }
}
