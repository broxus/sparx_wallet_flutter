// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_contract_asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenContractAsset {
  String get name;
  String get symbol;
  int get decimals; // address of rootTokenContract
  Address get address;
  NetworkType get networkType;
  NetworkGroup get networkGroup; // true if custom, false if system
  bool get isCustom;
  TokenWalletVersion? get version;
  int? get chainId; // address of owner that could be set when loaded in
// <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
  @JsonKey(includeToJson: false, includeFromJson: false)
  Address? get ownerAddress;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get totalSupply;
  String? get logoURI;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenContractAssetCopyWith<TokenContractAsset> get copyWith =>
      _$TokenContractAssetCopyWithImpl<TokenContractAsset>(
          this as TokenContractAsset, _$identity);

  /// Serializes this TokenContractAsset to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenContractAsset &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.ownerAddress, ownerAddress) ||
                other.ownerAddress == ownerAddress) &&
            (identical(other.totalSupply, totalSupply) ||
                other.totalSupply == totalSupply) &&
            (identical(other.logoURI, logoURI) || other.logoURI == logoURI));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      symbol,
      decimals,
      address,
      networkType,
      networkGroup,
      isCustom,
      version,
      chainId,
      ownerAddress,
      totalSupply,
      logoURI);

  @override
  String toString() {
    return 'TokenContractAsset(name: $name, symbol: $symbol, decimals: $decimals, address: $address, networkType: $networkType, networkGroup: $networkGroup, isCustom: $isCustom, version: $version, chainId: $chainId, ownerAddress: $ownerAddress, totalSupply: $totalSupply, logoURI: $logoURI)';
  }
}

/// @nodoc
abstract mixin class $TokenContractAssetCopyWith<$Res> {
  factory $TokenContractAssetCopyWith(
          TokenContractAsset value, $Res Function(TokenContractAsset) _then) =
      _$TokenContractAssetCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String symbol,
      int decimals,
      Address address,
      NetworkType networkType,
      NetworkGroup networkGroup,
      bool isCustom,
      TokenWalletVersion? version,
      int? chainId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      Address? ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false)
      String? totalSupply,
      String? logoURI});

  $AddressCopyWith<$Res> get address;
  $AddressCopyWith<$Res>? get ownerAddress;
}

/// @nodoc
class _$TokenContractAssetCopyWithImpl<$Res>
    implements $TokenContractAssetCopyWith<$Res> {
  _$TokenContractAssetCopyWithImpl(this._self, this._then);

  final TokenContractAsset _self;
  final $Res Function(TokenContractAsset) _then;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? address = null,
    Object? networkType = null,
    Object? networkGroup = null,
    Object? isCustom = null,
    Object? version = freezed,
    Object? chainId = freezed,
    Object? ownerAddress = freezed,
    Object? totalSupply = freezed,
    Object? logoURI = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _self.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _self.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as NetworkGroup,
      isCustom: null == isCustom
          ? _self.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      version: freezed == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as TokenWalletVersion?,
      chainId: freezed == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerAddress: freezed == ownerAddress
          ? _self.ownerAddress
          : ownerAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      totalSupply: freezed == totalSupply
          ? _self.totalSupply
          : totalSupply // ignore: cast_nullable_to_non_nullable
              as String?,
      logoURI: freezed == logoURI
          ? _self.logoURI
          : logoURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get ownerAddress {
    if (_self.ownerAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.ownerAddress!, (value) {
      return _then(_self.copyWith(ownerAddress: value));
    });
  }
}

/// Adds pattern-matching-related methods to [TokenContractAsset].
extension TokenContractAssetPatterns on TokenContractAsset {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TokenContractAsset value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenContractAsset() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TokenContractAsset value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenContractAsset():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TokenContractAsset value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenContractAsset() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String name,
            String symbol,
            int decimals,
            Address address,
            NetworkType networkType,
            NetworkGroup networkGroup,
            bool isCustom,
            TokenWalletVersion? version,
            int? chainId,
            @JsonKey(includeToJson: false, includeFromJson: false)
            Address? ownerAddress,
            @JsonKey(includeToJson: false, includeFromJson: false)
            String? totalSupply,
            String? logoURI)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenContractAsset() when $default != null:
        return $default(
            _that.name,
            _that.symbol,
            _that.decimals,
            _that.address,
            _that.networkType,
            _that.networkGroup,
            _that.isCustom,
            _that.version,
            _that.chainId,
            _that.ownerAddress,
            _that.totalSupply,
            _that.logoURI);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String name,
            String symbol,
            int decimals,
            Address address,
            NetworkType networkType,
            NetworkGroup networkGroup,
            bool isCustom,
            TokenWalletVersion? version,
            int? chainId,
            @JsonKey(includeToJson: false, includeFromJson: false)
            Address? ownerAddress,
            @JsonKey(includeToJson: false, includeFromJson: false)
            String? totalSupply,
            String? logoURI)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenContractAsset():
        return $default(
            _that.name,
            _that.symbol,
            _that.decimals,
            _that.address,
            _that.networkType,
            _that.networkGroup,
            _that.isCustom,
            _that.version,
            _that.chainId,
            _that.ownerAddress,
            _that.totalSupply,
            _that.logoURI);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String name,
            String symbol,
            int decimals,
            Address address,
            NetworkType networkType,
            NetworkGroup networkGroup,
            bool isCustom,
            TokenWalletVersion? version,
            int? chainId,
            @JsonKey(includeToJson: false, includeFromJson: false)
            Address? ownerAddress,
            @JsonKey(includeToJson: false, includeFromJson: false)
            String? totalSupply,
            String? logoURI)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenContractAsset() when $default != null:
        return $default(
            _that.name,
            _that.symbol,
            _that.decimals,
            _that.address,
            _that.networkType,
            _that.networkGroup,
            _that.isCustom,
            _that.version,
            _that.chainId,
            _that.ownerAddress,
            _that.totalSupply,
            _that.logoURI);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TokenContractAsset implements TokenContractAsset {
  const _TokenContractAsset(
      {required this.name,
      required this.symbol,
      required this.decimals,
      required this.address,
      required this.networkType,
      required this.networkGroup,
      required this.isCustom,
      this.version,
      this.chainId,
      @JsonKey(includeToJson: false, includeFromJson: false) this.ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false) this.totalSupply,
      this.logoURI});
  factory _TokenContractAsset.fromJson(Map<String, dynamic> json) =>
      _$TokenContractAssetFromJson(json);

  @override
  final String name;
  @override
  final String symbol;
  @override
  final int decimals;
// address of rootTokenContract
  @override
  final Address address;
  @override
  final NetworkType networkType;
  @override
  final NetworkGroup networkGroup;
// true if custom, false if system
  @override
  final bool isCustom;
  @override
  final TokenWalletVersion? version;
  @override
  final int? chainId;
// address of owner that could be set when loaded in
// <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Address? ownerAddress;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? totalSupply;
  @override
  final String? logoURI;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenContractAssetCopyWith<_TokenContractAsset> get copyWith =>
      __$TokenContractAssetCopyWithImpl<_TokenContractAsset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenContractAssetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenContractAsset &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.ownerAddress, ownerAddress) ||
                other.ownerAddress == ownerAddress) &&
            (identical(other.totalSupply, totalSupply) ||
                other.totalSupply == totalSupply) &&
            (identical(other.logoURI, logoURI) || other.logoURI == logoURI));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      symbol,
      decimals,
      address,
      networkType,
      networkGroup,
      isCustom,
      version,
      chainId,
      ownerAddress,
      totalSupply,
      logoURI);

  @override
  String toString() {
    return 'TokenContractAsset(name: $name, symbol: $symbol, decimals: $decimals, address: $address, networkType: $networkType, networkGroup: $networkGroup, isCustom: $isCustom, version: $version, chainId: $chainId, ownerAddress: $ownerAddress, totalSupply: $totalSupply, logoURI: $logoURI)';
  }
}

/// @nodoc
abstract mixin class _$TokenContractAssetCopyWith<$Res>
    implements $TokenContractAssetCopyWith<$Res> {
  factory _$TokenContractAssetCopyWith(
          _TokenContractAsset value, $Res Function(_TokenContractAsset) _then) =
      __$TokenContractAssetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String symbol,
      int decimals,
      Address address,
      NetworkType networkType,
      NetworkGroup networkGroup,
      bool isCustom,
      TokenWalletVersion? version,
      int? chainId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      Address? ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false)
      String? totalSupply,
      String? logoURI});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $AddressCopyWith<$Res>? get ownerAddress;
}

/// @nodoc
class __$TokenContractAssetCopyWithImpl<$Res>
    implements _$TokenContractAssetCopyWith<$Res> {
  __$TokenContractAssetCopyWithImpl(this._self, this._then);

  final _TokenContractAsset _self;
  final $Res Function(_TokenContractAsset) _then;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? address = null,
    Object? networkType = null,
    Object? networkGroup = null,
    Object? isCustom = null,
    Object? version = freezed,
    Object? chainId = freezed,
    Object? ownerAddress = freezed,
    Object? totalSupply = freezed,
    Object? logoURI = freezed,
  }) {
    return _then(_TokenContractAsset(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _self.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _self.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      networkGroup: null == networkGroup
          ? _self.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as NetworkGroup,
      isCustom: null == isCustom
          ? _self.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      version: freezed == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as TokenWalletVersion?,
      chainId: freezed == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerAddress: freezed == ownerAddress
          ? _self.ownerAddress
          : ownerAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      totalSupply: freezed == totalSupply
          ? _self.totalSupply
          : totalSupply // ignore: cast_nullable_to_non_nullable
              as String?,
      logoURI: freezed == logoURI
          ? _self.logoURI
          : logoURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get ownerAddress {
    if (_self.ownerAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.ownerAddress!, (value) {
      return _then(_self.copyWith(ownerAddress: value));
    });
  }
}

// dart format on
