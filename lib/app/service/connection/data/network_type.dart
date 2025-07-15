extension type const NetworkType._(String name) {
  factory NetworkType.empty() => const NetworkType._('');

  factory NetworkType.fromJson(String json) => NetworkType._(json);

  static const NetworkType ever = NetworkType._('ever');
  static const NetworkType venom = NetworkType._('venom');
  static const NetworkType tycho = NetworkType._('tycho');
  static const NetworkType ton = NetworkType._('ton');
  static const NetworkType custom = NetworkType._('custom');

  String toJson() => name;

  bool get isEver => this == NetworkType.ever;
  bool get isVenom => this == NetworkType.venom;
  bool get isTycho => this == NetworkType.tycho;
  bool get isTon => this == NetworkType.ton;
  bool get isCustom => this == NetworkType.custom;
}
