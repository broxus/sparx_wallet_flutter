// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_work_chain_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionWorkchainData {
  int get id;
  NetworkType get networkType;
  String get networkGroup;
  List<String> get endpoints;
  String get blockExplorerUrl;
  bool get isLocal;
  String get nativeTokenTicker;
  bool get isPreset;
  bool get canBeEdited;
  TransportIcons get icons;
  @WalletTypeListConverter()
  List<WalletType> get availableWalletTypes;
  @WalletTypeConverter()
  WalletType get defaultWalletType;
  TransportNativeTokenTickerOption get nativeTokenTickerOption;
  TransportManifestOption get manifestOption;
  @AddressStringConverter()
  Address get nativeTokenAddress;
  List<int> get seedPhraseWordsCount;
  int? get defaultNativeCurrencyDecimal;
  GenericTokenType get genericTokenType;
  AccountExplorerLinkType get accountExplorerLinkType;
  TransactionExplorerLinkType? get transactionExplorerLinkType;
  WalletDefaultAccountNames get walletDefaultAccountNames;
  bool get isUsedOnStart;
  String get manifestUrl;
  int get nativeTokenDecimals;
  List<DefaultActiveAsset> get defaultActiveAssets;
  int? get latencyDetectionInterval;
  int? get maxLatency;
  int? get endpointSelectionRetryCount;
  String? get tokenApiBaseUrl;
  String? get currencyApiBaseUrl;
  @PollingConfigSecondsConverter()
  PollingConfig? get pollingConfig;
  @StakingInformationConverter()
  StakingInformation? get stakeInformation;
  NftInformation? get nftInformation;

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionWorkchainDataCopyWith<ConnectionWorkchainData> get copyWith =>
      _$ConnectionWorkchainDataCopyWithImpl<ConnectionWorkchainData>(
          this as ConnectionWorkchainData, _$identity);

  /// Serializes this ConnectionWorkchainData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionWorkchainData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            const DeepCollectionEquality().equals(other.endpoints, endpoints) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.isLocal, isLocal) || other.isLocal == isLocal) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.icons, icons) || other.icons == icons) &&
            const DeepCollectionEquality()
                .equals(other.availableWalletTypes, availableWalletTypes) &&
            (identical(other.defaultWalletType, defaultWalletType) ||
                other.defaultWalletType == defaultWalletType) &&
            (identical(other.nativeTokenTickerOption, nativeTokenTickerOption) ||
                other.nativeTokenTickerOption == nativeTokenTickerOption) &&
            (identical(other.manifestOption, manifestOption) ||
                other.manifestOption == manifestOption) &&
            (identical(other.nativeTokenAddress, nativeTokenAddress) ||
                other.nativeTokenAddress == nativeTokenAddress) &&
            const DeepCollectionEquality()
                .equals(other.seedPhraseWordsCount, seedPhraseWordsCount) &&
            (identical(other.defaultNativeCurrencyDecimal, defaultNativeCurrencyDecimal) ||
                other.defaultNativeCurrencyDecimal ==
                    defaultNativeCurrencyDecimal) &&
            (identical(other.genericTokenType, genericTokenType) ||
                other.genericTokenType == genericTokenType) &&
            (identical(other.accountExplorerLinkType, accountExplorerLinkType) ||
                other.accountExplorerLinkType == accountExplorerLinkType) &&
            (identical(other.transactionExplorerLinkType, transactionExplorerLinkType) ||
                other.transactionExplorerLinkType ==
                    transactionExplorerLinkType) &&
            (identical(other.walletDefaultAccountNames, walletDefaultAccountNames) ||
                other.walletDefaultAccountNames == walletDefaultAccountNames) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(other.nativeTokenDecimals, nativeTokenDecimals) ||
                other.nativeTokenDecimals == nativeTokenDecimals) &&
            const DeepCollectionEquality()
                .equals(other.defaultActiveAssets, defaultActiveAssets) &&
            (identical(other.latencyDetectionInterval, latencyDetectionInterval) ||
                other.latencyDetectionInterval == latencyDetectionInterval) &&
            (identical(other.maxLatency, maxLatency) ||
                other.maxLatency == maxLatency) &&
            (identical(other.endpointSelectionRetryCount, endpointSelectionRetryCount) ||
                other.endpointSelectionRetryCount ==
                    endpointSelectionRetryCount) &&
            (identical(other.tokenApiBaseUrl, tokenApiBaseUrl) ||
                other.tokenApiBaseUrl == tokenApiBaseUrl) &&
            (identical(other.currencyApiBaseUrl, currencyApiBaseUrl) ||
                other.currencyApiBaseUrl == currencyApiBaseUrl) &&
            (identical(other.pollingConfig, pollingConfig) || other.pollingConfig == pollingConfig) &&
            (identical(other.stakeInformation, stakeInformation) || other.stakeInformation == stakeInformation) &&
            (identical(other.nftInformation, nftInformation) || other.nftInformation == nftInformation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        networkType,
        networkGroup,
        const DeepCollectionEquality().hash(endpoints),
        blockExplorerUrl,
        isLocal,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        icons,
        const DeepCollectionEquality().hash(availableWalletTypes),
        defaultWalletType,
        nativeTokenTickerOption,
        manifestOption,
        nativeTokenAddress,
        const DeepCollectionEquality().hash(seedPhraseWordsCount),
        defaultNativeCurrencyDecimal,
        genericTokenType,
        accountExplorerLinkType,
        transactionExplorerLinkType,
        walletDefaultAccountNames,
        isUsedOnStart,
        manifestUrl,
        nativeTokenDecimals,
        const DeepCollectionEquality().hash(defaultActiveAssets),
        latencyDetectionInterval,
        maxLatency,
        endpointSelectionRetryCount,
        tokenApiBaseUrl,
        currencyApiBaseUrl,
        pollingConfig,
        stakeInformation,
        nftInformation
      ]);

  @override
  String toString() {
    return 'ConnectionWorkchainData(id: $id, networkType: $networkType, networkGroup: $networkGroup, endpoints: $endpoints, blockExplorerUrl: $blockExplorerUrl, isLocal: $isLocal, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, icons: $icons, availableWalletTypes: $availableWalletTypes, defaultWalletType: $defaultWalletType, nativeTokenTickerOption: $nativeTokenTickerOption, manifestOption: $manifestOption, nativeTokenAddress: $nativeTokenAddress, seedPhraseWordsCount: $seedPhraseWordsCount, defaultNativeCurrencyDecimal: $defaultNativeCurrencyDecimal, genericTokenType: $genericTokenType, accountExplorerLinkType: $accountExplorerLinkType, transactionExplorerLinkType: $transactionExplorerLinkType, walletDefaultAccountNames: $walletDefaultAccountNames, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, nativeTokenDecimals: $nativeTokenDecimals, defaultActiveAssets: $defaultActiveAssets, latencyDetectionInterval: $latencyDetectionInterval, maxLatency: $maxLatency, endpointSelectionRetryCount: $endpointSelectionRetryCount, tokenApiBaseUrl: $tokenApiBaseUrl, currencyApiBaseUrl: $currencyApiBaseUrl, pollingConfig: $pollingConfig, stakeInformation: $stakeInformation, nftInformation: $nftInformation)';
  }
}

/// @nodoc
abstract mixin class $ConnectionWorkchainDataCopyWith<$Res> {
  factory $ConnectionWorkchainDataCopyWith(ConnectionWorkchainData value,
          $Res Function(ConnectionWorkchainData) _then) =
      _$ConnectionWorkchainDataCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      NetworkType networkType,
      String networkGroup,
      List<String> endpoints,
      String blockExplorerUrl,
      bool isLocal,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      TransportIcons icons,
      @WalletTypeListConverter() List<WalletType> availableWalletTypes,
      @WalletTypeConverter() WalletType defaultWalletType,
      TransportNativeTokenTickerOption nativeTokenTickerOption,
      TransportManifestOption manifestOption,
      @AddressStringConverter() Address nativeTokenAddress,
      List<int> seedPhraseWordsCount,
      int? defaultNativeCurrencyDecimal,
      GenericTokenType genericTokenType,
      AccountExplorerLinkType accountExplorerLinkType,
      TransactionExplorerLinkType? transactionExplorerLinkType,
      WalletDefaultAccountNames walletDefaultAccountNames,
      bool isUsedOnStart,
      String manifestUrl,
      int nativeTokenDecimals,
      List<DefaultActiveAsset> defaultActiveAssets,
      int? latencyDetectionInterval,
      int? maxLatency,
      int? endpointSelectionRetryCount,
      String? tokenApiBaseUrl,
      String? currencyApiBaseUrl,
      @PollingConfigSecondsConverter() PollingConfig? pollingConfig,
      @StakingInformationConverter() StakingInformation? stakeInformation,
      NftInformation? nftInformation});

  $TransportIconsCopyWith<$Res> get icons;
  $WalletTypeCopyWith<$Res> get defaultWalletType;
  $TransportNativeTokenTickerOptionCopyWith<$Res> get nativeTokenTickerOption;
  $TransportManifestOptionCopyWith<$Res> get manifestOption;
  $AddressCopyWith<$Res> get nativeTokenAddress;
  $WalletDefaultAccountNamesCopyWith<$Res> get walletDefaultAccountNames;
  $NftInformationCopyWith<$Res>? get nftInformation;
}

/// @nodoc
class _$ConnectionWorkchainDataCopyWithImpl<$Res>
    implements $ConnectionWorkchainDataCopyWith<$Res> {
  _$ConnectionWorkchainDataCopyWithImpl(this._self, this._then);

  final ConnectionWorkchainData _self;
  final $Res Function(ConnectionWorkchainData) _then;

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? networkType = null,
    Object? networkGroup = null,
    Object? endpoints = null,
    Object? blockExplorerUrl = null,
    Object? isLocal = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? icons = null,
    Object? availableWalletTypes = null,
    Object? defaultWalletType = null,
    Object? nativeTokenTickerOption = null,
    Object? manifestOption = null,
    Object? nativeTokenAddress = null,
    Object? seedPhraseWordsCount = null,
    Object? defaultNativeCurrencyDecimal = freezed,
    Object? genericTokenType = null,
    Object? accountExplorerLinkType = null,
    Object? transactionExplorerLinkType = freezed,
    Object? walletDefaultAccountNames = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? nativeTokenDecimals = null,
    Object? defaultActiveAssets = null,
    Object? latencyDetectionInterval = freezed,
    Object? maxLatency = freezed,
    Object? endpointSelectionRetryCount = freezed,
    Object? tokenApiBaseUrl = freezed,
    Object? currencyApiBaseUrl = freezed,
    Object? pollingConfig = freezed,
    Object? stakeInformation = freezed,
    Object? nftInformation = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      endpoints: null == endpoints
          ? _self.endpoints
          : endpoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockExplorerUrl: null == blockExplorerUrl
          ? _self.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLocal: null == isLocal
          ? _self.isLocal
          : isLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      nativeTokenTicker: null == nativeTokenTicker
          ? _self.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      icons: null == icons
          ? _self.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as TransportIcons,
      availableWalletTypes: null == availableWalletTypes
          ? _self.availableWalletTypes
          : availableWalletTypes // ignore: cast_nullable_to_non_nullable
              as List<WalletType>,
      defaultWalletType: null == defaultWalletType
          ? _self.defaultWalletType
          : defaultWalletType // ignore: cast_nullable_to_non_nullable
              as WalletType,
      nativeTokenTickerOption: null == nativeTokenTickerOption
          ? _self.nativeTokenTickerOption
          : nativeTokenTickerOption // ignore: cast_nullable_to_non_nullable
              as TransportNativeTokenTickerOption,
      manifestOption: null == manifestOption
          ? _self.manifestOption
          : manifestOption // ignore: cast_nullable_to_non_nullable
              as TransportManifestOption,
      nativeTokenAddress: null == nativeTokenAddress
          ? _self.nativeTokenAddress
          : nativeTokenAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      seedPhraseWordsCount: null == seedPhraseWordsCount
          ? _self.seedPhraseWordsCount
          : seedPhraseWordsCount // ignore: cast_nullable_to_non_nullable
              as List<int>,
      defaultNativeCurrencyDecimal: freezed == defaultNativeCurrencyDecimal
          ? _self.defaultNativeCurrencyDecimal
          : defaultNativeCurrencyDecimal // ignore: cast_nullable_to_non_nullable
              as int?,
      genericTokenType: null == genericTokenType
          ? _self.genericTokenType
          : genericTokenType // ignore: cast_nullable_to_non_nullable
              as GenericTokenType,
      accountExplorerLinkType: null == accountExplorerLinkType
          ? _self.accountExplorerLinkType
          : accountExplorerLinkType // ignore: cast_nullable_to_non_nullable
              as AccountExplorerLinkType,
      transactionExplorerLinkType: freezed == transactionExplorerLinkType
          ? _self.transactionExplorerLinkType
          : transactionExplorerLinkType // ignore: cast_nullable_to_non_nullable
              as TransactionExplorerLinkType?,
      walletDefaultAccountNames: null == walletDefaultAccountNames
          ? _self.walletDefaultAccountNames
          : walletDefaultAccountNames // ignore: cast_nullable_to_non_nullable
              as WalletDefaultAccountNames,
      isUsedOnStart: null == isUsedOnStart
          ? _self.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenDecimals: null == nativeTokenDecimals
          ? _self.nativeTokenDecimals
          : nativeTokenDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      defaultActiveAssets: null == defaultActiveAssets
          ? _self.defaultActiveAssets
          : defaultActiveAssets // ignore: cast_nullable_to_non_nullable
              as List<DefaultActiveAsset>,
      latencyDetectionInterval: freezed == latencyDetectionInterval
          ? _self.latencyDetectionInterval
          : latencyDetectionInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLatency: freezed == maxLatency
          ? _self.maxLatency
          : maxLatency // ignore: cast_nullable_to_non_nullable
              as int?,
      endpointSelectionRetryCount: freezed == endpointSelectionRetryCount
          ? _self.endpointSelectionRetryCount
          : endpointSelectionRetryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      tokenApiBaseUrl: freezed == tokenApiBaseUrl
          ? _self.tokenApiBaseUrl
          : tokenApiBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyApiBaseUrl: freezed == currencyApiBaseUrl
          ? _self.currencyApiBaseUrl
          : currencyApiBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pollingConfig: freezed == pollingConfig
          ? _self.pollingConfig
          : pollingConfig // ignore: cast_nullable_to_non_nullable
              as PollingConfig?,
      stakeInformation: freezed == stakeInformation
          ? _self.stakeInformation
          : stakeInformation // ignore: cast_nullable_to_non_nullable
              as StakingInformation?,
      nftInformation: freezed == nftInformation
          ? _self.nftInformation
          : nftInformation // ignore: cast_nullable_to_non_nullable
              as NftInformation?,
    ));
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportIconsCopyWith<$Res> get icons {
    return $TransportIconsCopyWith<$Res>(_self.icons, (value) {
      return _then(_self.copyWith(icons: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTypeCopyWith<$Res> get defaultWalletType {
    return $WalletTypeCopyWith<$Res>(_self.defaultWalletType, (value) {
      return _then(_self.copyWith(defaultWalletType: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportNativeTokenTickerOptionCopyWith<$Res> get nativeTokenTickerOption {
    return $TransportNativeTokenTickerOptionCopyWith<$Res>(
        _self.nativeTokenTickerOption, (value) {
      return _then(_self.copyWith(nativeTokenTickerOption: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportManifestOptionCopyWith<$Res> get manifestOption {
    return $TransportManifestOptionCopyWith<$Res>(_self.manifestOption,
        (value) {
      return _then(_self.copyWith(manifestOption: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get nativeTokenAddress {
    return $AddressCopyWith<$Res>(_self.nativeTokenAddress, (value) {
      return _then(_self.copyWith(nativeTokenAddress: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletDefaultAccountNamesCopyWith<$Res> get walletDefaultAccountNames {
    return $WalletDefaultAccountNamesCopyWith<$Res>(
        _self.walletDefaultAccountNames, (value) {
      return _then(_self.copyWith(walletDefaultAccountNames: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftInformationCopyWith<$Res>? get nftInformation {
    if (_self.nftInformation == null) {
      return null;
    }

    return $NftInformationCopyWith<$Res>(_self.nftInformation!, (value) {
      return _then(_self.copyWith(nftInformation: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectionWorkchainData implements ConnectionWorkchainData {
  _ConnectionWorkchainData(
      {required this.id,
      required this.networkType,
      required this.networkGroup,
      required final List<String> endpoints,
      required this.blockExplorerUrl,
      required this.isLocal,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.icons,
      @WalletTypeListConverter()
      required final List<WalletType> availableWalletTypes,
      @WalletTypeConverter() required this.defaultWalletType,
      required this.nativeTokenTickerOption,
      required this.manifestOption,
      @AddressStringConverter() required this.nativeTokenAddress,
      required final List<int> seedPhraseWordsCount,
      required this.defaultNativeCurrencyDecimal,
      required this.genericTokenType,
      required this.accountExplorerLinkType,
      required this.transactionExplorerLinkType,
      required this.walletDefaultAccountNames,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      this.nativeTokenDecimals = 9,
      final List<DefaultActiveAsset> defaultActiveAssets = const [],
      this.latencyDetectionInterval,
      this.maxLatency,
      this.endpointSelectionRetryCount,
      this.tokenApiBaseUrl,
      this.currencyApiBaseUrl,
      @PollingConfigSecondsConverter() this.pollingConfig,
      @StakingInformationConverter() this.stakeInformation,
      this.nftInformation})
      : _endpoints = endpoints,
        _availableWalletTypes = availableWalletTypes,
        _seedPhraseWordsCount = seedPhraseWordsCount,
        _defaultActiveAssets = defaultActiveAssets;
  factory _ConnectionWorkchainData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionWorkchainDataFromJson(json);

  @override
  final int id;
  @override
  final NetworkType networkType;
  @override
  final String networkGroup;
  final List<String> _endpoints;
  @override
  List<String> get endpoints {
    if (_endpoints is EqualUnmodifiableListView) return _endpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_endpoints);
  }

  @override
  final String blockExplorerUrl;
  @override
  final bool isLocal;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final TransportIcons icons;
  final List<WalletType> _availableWalletTypes;
  @override
  @WalletTypeListConverter()
  List<WalletType> get availableWalletTypes {
    if (_availableWalletTypes is EqualUnmodifiableListView)
      return _availableWalletTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableWalletTypes);
  }

  @override
  @WalletTypeConverter()
  final WalletType defaultWalletType;
  @override
  final TransportNativeTokenTickerOption nativeTokenTickerOption;
  @override
  final TransportManifestOption manifestOption;
  @override
  @AddressStringConverter()
  final Address nativeTokenAddress;
  final List<int> _seedPhraseWordsCount;
  @override
  List<int> get seedPhraseWordsCount {
    if (_seedPhraseWordsCount is EqualUnmodifiableListView)
      return _seedPhraseWordsCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seedPhraseWordsCount);
  }

  @override
  final int? defaultNativeCurrencyDecimal;
  @override
  final GenericTokenType genericTokenType;
  @override
  final AccountExplorerLinkType accountExplorerLinkType;
  @override
  final TransactionExplorerLinkType? transactionExplorerLinkType;
  @override
  final WalletDefaultAccountNames walletDefaultAccountNames;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;
  @override
  @JsonKey()
  final int nativeTokenDecimals;
  final List<DefaultActiveAsset> _defaultActiveAssets;
  @override
  @JsonKey()
  List<DefaultActiveAsset> get defaultActiveAssets {
    if (_defaultActiveAssets is EqualUnmodifiableListView)
      return _defaultActiveAssets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_defaultActiveAssets);
  }

  @override
  final int? latencyDetectionInterval;
  @override
  final int? maxLatency;
  @override
  final int? endpointSelectionRetryCount;
  @override
  final String? tokenApiBaseUrl;
  @override
  final String? currencyApiBaseUrl;
  @override
  @PollingConfigSecondsConverter()
  final PollingConfig? pollingConfig;
  @override
  @StakingInformationConverter()
  final StakingInformation? stakeInformation;
  @override
  final NftInformation? nftInformation;

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionWorkchainDataCopyWith<_ConnectionWorkchainData> get copyWith =>
      __$ConnectionWorkchainDataCopyWithImpl<_ConnectionWorkchainData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionWorkchainDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionWorkchainData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            const DeepCollectionEquality()
                .equals(other._endpoints, _endpoints) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.isLocal, isLocal) || other.isLocal == isLocal) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.icons, icons) || other.icons == icons) &&
            const DeepCollectionEquality()
                .equals(other._availableWalletTypes, _availableWalletTypes) &&
            (identical(other.defaultWalletType, defaultWalletType) ||
                other.defaultWalletType == defaultWalletType) &&
            (identical(other.nativeTokenTickerOption, nativeTokenTickerOption) ||
                other.nativeTokenTickerOption == nativeTokenTickerOption) &&
            (identical(other.manifestOption, manifestOption) ||
                other.manifestOption == manifestOption) &&
            (identical(other.nativeTokenAddress, nativeTokenAddress) ||
                other.nativeTokenAddress == nativeTokenAddress) &&
            const DeepCollectionEquality()
                .equals(other._seedPhraseWordsCount, _seedPhraseWordsCount) &&
            (identical(other.defaultNativeCurrencyDecimal, defaultNativeCurrencyDecimal) ||
                other.defaultNativeCurrencyDecimal ==
                    defaultNativeCurrencyDecimal) &&
            (identical(other.genericTokenType, genericTokenType) ||
                other.genericTokenType == genericTokenType) &&
            (identical(other.accountExplorerLinkType, accountExplorerLinkType) ||
                other.accountExplorerLinkType == accountExplorerLinkType) &&
            (identical(other.transactionExplorerLinkType, transactionExplorerLinkType) ||
                other.transactionExplorerLinkType ==
                    transactionExplorerLinkType) &&
            (identical(other.walletDefaultAccountNames, walletDefaultAccountNames) ||
                other.walletDefaultAccountNames == walletDefaultAccountNames) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(other.nativeTokenDecimals, nativeTokenDecimals) ||
                other.nativeTokenDecimals == nativeTokenDecimals) &&
            const DeepCollectionEquality()
                .equals(other._defaultActiveAssets, _defaultActiveAssets) &&
            (identical(other.latencyDetectionInterval, latencyDetectionInterval) ||
                other.latencyDetectionInterval == latencyDetectionInterval) &&
            (identical(other.maxLatency, maxLatency) ||
                other.maxLatency == maxLatency) &&
            (identical(other.endpointSelectionRetryCount, endpointSelectionRetryCount) ||
                other.endpointSelectionRetryCount ==
                    endpointSelectionRetryCount) &&
            (identical(other.tokenApiBaseUrl, tokenApiBaseUrl) ||
                other.tokenApiBaseUrl == tokenApiBaseUrl) &&
            (identical(other.currencyApiBaseUrl, currencyApiBaseUrl) || other.currencyApiBaseUrl == currencyApiBaseUrl) &&
            (identical(other.pollingConfig, pollingConfig) || other.pollingConfig == pollingConfig) &&
            (identical(other.stakeInformation, stakeInformation) || other.stakeInformation == stakeInformation) &&
            (identical(other.nftInformation, nftInformation) || other.nftInformation == nftInformation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        networkType,
        networkGroup,
        const DeepCollectionEquality().hash(_endpoints),
        blockExplorerUrl,
        isLocal,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        icons,
        const DeepCollectionEquality().hash(_availableWalletTypes),
        defaultWalletType,
        nativeTokenTickerOption,
        manifestOption,
        nativeTokenAddress,
        const DeepCollectionEquality().hash(_seedPhraseWordsCount),
        defaultNativeCurrencyDecimal,
        genericTokenType,
        accountExplorerLinkType,
        transactionExplorerLinkType,
        walletDefaultAccountNames,
        isUsedOnStart,
        manifestUrl,
        nativeTokenDecimals,
        const DeepCollectionEquality().hash(_defaultActiveAssets),
        latencyDetectionInterval,
        maxLatency,
        endpointSelectionRetryCount,
        tokenApiBaseUrl,
        currencyApiBaseUrl,
        pollingConfig,
        stakeInformation,
        nftInformation
      ]);

  @override
  String toString() {
    return 'ConnectionWorkchainData(id: $id, networkType: $networkType, networkGroup: $networkGroup, endpoints: $endpoints, blockExplorerUrl: $blockExplorerUrl, isLocal: $isLocal, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, icons: $icons, availableWalletTypes: $availableWalletTypes, defaultWalletType: $defaultWalletType, nativeTokenTickerOption: $nativeTokenTickerOption, manifestOption: $manifestOption, nativeTokenAddress: $nativeTokenAddress, seedPhraseWordsCount: $seedPhraseWordsCount, defaultNativeCurrencyDecimal: $defaultNativeCurrencyDecimal, genericTokenType: $genericTokenType, accountExplorerLinkType: $accountExplorerLinkType, transactionExplorerLinkType: $transactionExplorerLinkType, walletDefaultAccountNames: $walletDefaultAccountNames, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, nativeTokenDecimals: $nativeTokenDecimals, defaultActiveAssets: $defaultActiveAssets, latencyDetectionInterval: $latencyDetectionInterval, maxLatency: $maxLatency, endpointSelectionRetryCount: $endpointSelectionRetryCount, tokenApiBaseUrl: $tokenApiBaseUrl, currencyApiBaseUrl: $currencyApiBaseUrl, pollingConfig: $pollingConfig, stakeInformation: $stakeInformation, nftInformation: $nftInformation)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionWorkchainDataCopyWith<$Res>
    implements $ConnectionWorkchainDataCopyWith<$Res> {
  factory _$ConnectionWorkchainDataCopyWith(_ConnectionWorkchainData value,
          $Res Function(_ConnectionWorkchainData) _then) =
      __$ConnectionWorkchainDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      NetworkType networkType,
      String networkGroup,
      List<String> endpoints,
      String blockExplorerUrl,
      bool isLocal,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      TransportIcons icons,
      @WalletTypeListConverter() List<WalletType> availableWalletTypes,
      @WalletTypeConverter() WalletType defaultWalletType,
      TransportNativeTokenTickerOption nativeTokenTickerOption,
      TransportManifestOption manifestOption,
      @AddressStringConverter() Address nativeTokenAddress,
      List<int> seedPhraseWordsCount,
      int? defaultNativeCurrencyDecimal,
      GenericTokenType genericTokenType,
      AccountExplorerLinkType accountExplorerLinkType,
      TransactionExplorerLinkType? transactionExplorerLinkType,
      WalletDefaultAccountNames walletDefaultAccountNames,
      bool isUsedOnStart,
      String manifestUrl,
      int nativeTokenDecimals,
      List<DefaultActiveAsset> defaultActiveAssets,
      int? latencyDetectionInterval,
      int? maxLatency,
      int? endpointSelectionRetryCount,
      String? tokenApiBaseUrl,
      String? currencyApiBaseUrl,
      @PollingConfigSecondsConverter() PollingConfig? pollingConfig,
      @StakingInformationConverter() StakingInformation? stakeInformation,
      NftInformation? nftInformation});

  @override
  $TransportIconsCopyWith<$Res> get icons;
  @override
  $WalletTypeCopyWith<$Res> get defaultWalletType;
  @override
  $TransportNativeTokenTickerOptionCopyWith<$Res> get nativeTokenTickerOption;
  @override
  $TransportManifestOptionCopyWith<$Res> get manifestOption;
  @override
  $AddressCopyWith<$Res> get nativeTokenAddress;
  @override
  $WalletDefaultAccountNamesCopyWith<$Res> get walletDefaultAccountNames;
  @override
  $NftInformationCopyWith<$Res>? get nftInformation;
}

/// @nodoc
class __$ConnectionWorkchainDataCopyWithImpl<$Res>
    implements _$ConnectionWorkchainDataCopyWith<$Res> {
  __$ConnectionWorkchainDataCopyWithImpl(this._self, this._then);

  final _ConnectionWorkchainData _self;
  final $Res Function(_ConnectionWorkchainData) _then;

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? networkType = null,
    Object? networkGroup = null,
    Object? endpoints = null,
    Object? blockExplorerUrl = null,
    Object? isLocal = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? icons = null,
    Object? availableWalletTypes = null,
    Object? defaultWalletType = null,
    Object? nativeTokenTickerOption = null,
    Object? manifestOption = null,
    Object? nativeTokenAddress = null,
    Object? seedPhraseWordsCount = null,
    Object? defaultNativeCurrencyDecimal = freezed,
    Object? genericTokenType = null,
    Object? accountExplorerLinkType = null,
    Object? transactionExplorerLinkType = freezed,
    Object? walletDefaultAccountNames = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? nativeTokenDecimals = null,
    Object? defaultActiveAssets = null,
    Object? latencyDetectionInterval = freezed,
    Object? maxLatency = freezed,
    Object? endpointSelectionRetryCount = freezed,
    Object? tokenApiBaseUrl = freezed,
    Object? currencyApiBaseUrl = freezed,
    Object? pollingConfig = freezed,
    Object? stakeInformation = freezed,
    Object? nftInformation = freezed,
  }) {
    return _then(_ConnectionWorkchainData(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      endpoints: null == endpoints
          ? _self._endpoints
          : endpoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockExplorerUrl: null == blockExplorerUrl
          ? _self.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLocal: null == isLocal
          ? _self.isLocal
          : isLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      nativeTokenTicker: null == nativeTokenTicker
          ? _self.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      icons: null == icons
          ? _self.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as TransportIcons,
      availableWalletTypes: null == availableWalletTypes
          ? _self._availableWalletTypes
          : availableWalletTypes // ignore: cast_nullable_to_non_nullable
              as List<WalletType>,
      defaultWalletType: null == defaultWalletType
          ? _self.defaultWalletType
          : defaultWalletType // ignore: cast_nullable_to_non_nullable
              as WalletType,
      nativeTokenTickerOption: null == nativeTokenTickerOption
          ? _self.nativeTokenTickerOption
          : nativeTokenTickerOption // ignore: cast_nullable_to_non_nullable
              as TransportNativeTokenTickerOption,
      manifestOption: null == manifestOption
          ? _self.manifestOption
          : manifestOption // ignore: cast_nullable_to_non_nullable
              as TransportManifestOption,
      nativeTokenAddress: null == nativeTokenAddress
          ? _self.nativeTokenAddress
          : nativeTokenAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      seedPhraseWordsCount: null == seedPhraseWordsCount
          ? _self._seedPhraseWordsCount
          : seedPhraseWordsCount // ignore: cast_nullable_to_non_nullable
              as List<int>,
      defaultNativeCurrencyDecimal: freezed == defaultNativeCurrencyDecimal
          ? _self.defaultNativeCurrencyDecimal
          : defaultNativeCurrencyDecimal // ignore: cast_nullable_to_non_nullable
              as int?,
      genericTokenType: null == genericTokenType
          ? _self.genericTokenType
          : genericTokenType // ignore: cast_nullable_to_non_nullable
              as GenericTokenType,
      accountExplorerLinkType: null == accountExplorerLinkType
          ? _self.accountExplorerLinkType
          : accountExplorerLinkType // ignore: cast_nullable_to_non_nullable
              as AccountExplorerLinkType,
      transactionExplorerLinkType: freezed == transactionExplorerLinkType
          ? _self.transactionExplorerLinkType
          : transactionExplorerLinkType // ignore: cast_nullable_to_non_nullable
              as TransactionExplorerLinkType?,
      walletDefaultAccountNames: null == walletDefaultAccountNames
          ? _self.walletDefaultAccountNames
          : walletDefaultAccountNames // ignore: cast_nullable_to_non_nullable
              as WalletDefaultAccountNames,
      isUsedOnStart: null == isUsedOnStart
          ? _self.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenDecimals: null == nativeTokenDecimals
          ? _self.nativeTokenDecimals
          : nativeTokenDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      defaultActiveAssets: null == defaultActiveAssets
          ? _self._defaultActiveAssets
          : defaultActiveAssets // ignore: cast_nullable_to_non_nullable
              as List<DefaultActiveAsset>,
      latencyDetectionInterval: freezed == latencyDetectionInterval
          ? _self.latencyDetectionInterval
          : latencyDetectionInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLatency: freezed == maxLatency
          ? _self.maxLatency
          : maxLatency // ignore: cast_nullable_to_non_nullable
              as int?,
      endpointSelectionRetryCount: freezed == endpointSelectionRetryCount
          ? _self.endpointSelectionRetryCount
          : endpointSelectionRetryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      tokenApiBaseUrl: freezed == tokenApiBaseUrl
          ? _self.tokenApiBaseUrl
          : tokenApiBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyApiBaseUrl: freezed == currencyApiBaseUrl
          ? _self.currencyApiBaseUrl
          : currencyApiBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pollingConfig: freezed == pollingConfig
          ? _self.pollingConfig
          : pollingConfig // ignore: cast_nullable_to_non_nullable
              as PollingConfig?,
      stakeInformation: freezed == stakeInformation
          ? _self.stakeInformation
          : stakeInformation // ignore: cast_nullable_to_non_nullable
              as StakingInformation?,
      nftInformation: freezed == nftInformation
          ? _self.nftInformation
          : nftInformation // ignore: cast_nullable_to_non_nullable
              as NftInformation?,
    ));
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportIconsCopyWith<$Res> get icons {
    return $TransportIconsCopyWith<$Res>(_self.icons, (value) {
      return _then(_self.copyWith(icons: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTypeCopyWith<$Res> get defaultWalletType {
    return $WalletTypeCopyWith<$Res>(_self.defaultWalletType, (value) {
      return _then(_self.copyWith(defaultWalletType: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportNativeTokenTickerOptionCopyWith<$Res> get nativeTokenTickerOption {
    return $TransportNativeTokenTickerOptionCopyWith<$Res>(
        _self.nativeTokenTickerOption, (value) {
      return _then(_self.copyWith(nativeTokenTickerOption: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportManifestOptionCopyWith<$Res> get manifestOption {
    return $TransportManifestOptionCopyWith<$Res>(_self.manifestOption,
        (value) {
      return _then(_self.copyWith(manifestOption: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get nativeTokenAddress {
    return $AddressCopyWith<$Res>(_self.nativeTokenAddress, (value) {
      return _then(_self.copyWith(nativeTokenAddress: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletDefaultAccountNamesCopyWith<$Res> get walletDefaultAccountNames {
    return $WalletDefaultAccountNamesCopyWith<$Res>(
        _self.walletDefaultAccountNames, (value) {
      return _then(_self.copyWith(walletDefaultAccountNames: value));
    });
  }

  /// Create a copy of ConnectionWorkchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftInformationCopyWith<$Res>? get nftInformation {
    if (_self.nftInformation == null) {
      return null;
    }

    return $NftInformationCopyWith<$Res>(_self.nftInformation!, (value) {
      return _then(_self.copyWith(nftInformation: value));
    });
  }
}

// dart format on
