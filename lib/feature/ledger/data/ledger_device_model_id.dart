/// Device model identifiers for Ledger devices.
enum DeviceModelId {
  /// Ledger Blue
  blue,

  /// Ledger Nano S
  nanoS,

  /// Ledger Nano S Plus
  nanoSP,

  /// Ledger Nano X
  nanoX,

  /// Ledger Stax
  stax,

  /// Ledger Flex ("europa" is the internal name)
  /// DO NOT CHANGE TO FLEX or handle all migration issues, things will break
  europa,
}
