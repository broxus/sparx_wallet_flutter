// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApprovalRequest {
  Uri get origin;
  Completer<void> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestCopyWith<ApprovalRequest> get copyWith =>
      _$ApprovalRequestCopyWithImpl<ApprovalRequest>(
          this as ApprovalRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequest &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, completer);

  @override
  String toString() {
    return 'ApprovalRequest(origin: $origin, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestCopyWith(
          ApprovalRequest value, $Res Function(ApprovalRequest) _then) =
      _$ApprovalRequestCopyWithImpl;
  @useResult
  $Res call({Uri origin});
}

/// @nodoc
class _$ApprovalRequestCopyWithImpl<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  _$ApprovalRequestCopyWithImpl(this._self, this._then);

  final ApprovalRequest _self;
  final $Res Function(ApprovalRequest) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
  }) {
    return _then(_self.copyWith(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class ApprovalRequestPermissions implements ApprovalRequest {
  const ApprovalRequestPermissions(
      {required this.origin,
      required final List<Permission> permissions,
      required this.completer})
      : _permissions = permissions;

  @override
  final Uri origin;
  final List<Permission> _permissions;
  List<Permission> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final Completer<Permissions> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestPermissionsCopyWith<ApprovalRequestPermissions>
      get copyWith =>
          _$ApprovalRequestPermissionsCopyWithImpl<ApprovalRequestPermissions>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestPermissions &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin,
      const DeepCollectionEquality().hash(_permissions), completer);

  @override
  String toString() {
    return 'ApprovalRequest.requestPermissions(origin: $origin, permissions: $permissions, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestPermissionsCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestPermissionsCopyWith(ApprovalRequestPermissions value,
          $Res Function(ApprovalRequestPermissions) _then) =
      _$ApprovalRequestPermissionsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      List<Permission> permissions,
      Completer<Permissions> completer});
}

/// @nodoc
class _$ApprovalRequestPermissionsCopyWithImpl<$Res>
    implements $ApprovalRequestPermissionsCopyWith<$Res> {
  _$ApprovalRequestPermissionsCopyWithImpl(this._self, this._then);

  final ApprovalRequestPermissions _self;
  final $Res Function(ApprovalRequestPermissions) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? permissions = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestPermissions(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      permissions: null == permissions
          ? _self._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<Permission>,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<Permissions>,
    ));
  }
}

/// @nodoc

class ApprovalRequestChangeAccount implements ApprovalRequest {
  const ApprovalRequestChangeAccount(
      {required this.origin,
      required final List<Permission> permissions,
      required this.previousSelectedAccount,
      required this.completer})
      : _permissions = permissions;

  @override
  final Uri origin;
  final List<Permission> _permissions;
  List<Permission> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  final Address? previousSelectedAccount;
  @override
  final Completer<Permissions> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestChangeAccountCopyWith<ApprovalRequestChangeAccount>
      get copyWith => _$ApprovalRequestChangeAccountCopyWithImpl<
          ApprovalRequestChangeAccount>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestChangeAccount &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(
                    other.previousSelectedAccount, previousSelectedAccount) ||
                other.previousSelectedAccount == previousSelectedAccount) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(_permissions),
      previousSelectedAccount,
      completer);

  @override
  String toString() {
    return 'ApprovalRequest.changeAccount(origin: $origin, permissions: $permissions, previousSelectedAccount: $previousSelectedAccount, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestChangeAccountCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestChangeAccountCopyWith(
          ApprovalRequestChangeAccount value,
          $Res Function(ApprovalRequestChangeAccount) _then) =
      _$ApprovalRequestChangeAccountCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      List<Permission> permissions,
      Address? previousSelectedAccount,
      Completer<Permissions> completer});

  $AddressCopyWith<$Res>? get previousSelectedAccount;
}

/// @nodoc
class _$ApprovalRequestChangeAccountCopyWithImpl<$Res>
    implements $ApprovalRequestChangeAccountCopyWith<$Res> {
  _$ApprovalRequestChangeAccountCopyWithImpl(this._self, this._then);

  final ApprovalRequestChangeAccount _self;
  final $Res Function(ApprovalRequestChangeAccount) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? permissions = null,
    Object? previousSelectedAccount = freezed,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestChangeAccount(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      permissions: null == permissions
          ? _self._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<Permission>,
      previousSelectedAccount: freezed == previousSelectedAccount
          ? _self.previousSelectedAccount
          : previousSelectedAccount // ignore: cast_nullable_to_non_nullable
              as Address?,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<Permissions>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get previousSelectedAccount {
    if (_self.previousSelectedAccount == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.previousSelectedAccount!, (value) {
      return _then(_self.copyWith(previousSelectedAccount: value));
    });
  }
}

/// @nodoc

class ApprovalRequestAddTip3Token implements ApprovalRequest {
  const ApprovalRequestAddTip3Token(
      {required this.origin,
      required this.account,
      required this.details,
      required this.completer});

  @override
  final Uri origin;
  final Address account;
  final TokenContractAsset details;
  @override
  final Completer<void> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestAddTip3TokenCopyWith<ApprovalRequestAddTip3Token>
      get copyWith => _$ApprovalRequestAddTip3TokenCopyWithImpl<
          ApprovalRequestAddTip3Token>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestAddTip3Token &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, origin, account, details, completer);

  @override
  String toString() {
    return 'ApprovalRequest.addTip3Token(origin: $origin, account: $account, details: $details, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestAddTip3TokenCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestAddTip3TokenCopyWith(
          ApprovalRequestAddTip3Token value,
          $Res Function(ApprovalRequestAddTip3Token) _then) =
      _$ApprovalRequestAddTip3TokenCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      TokenContractAsset details,
      Completer<void> completer});

  $AddressCopyWith<$Res> get account;
  $TokenContractAssetCopyWith<$Res> get details;
}

/// @nodoc
class _$ApprovalRequestAddTip3TokenCopyWithImpl<$Res>
    implements $ApprovalRequestAddTip3TokenCopyWith<$Res> {
  _$ApprovalRequestAddTip3TokenCopyWithImpl(this._self, this._then);

  final ApprovalRequestAddTip3Token _self;
  final $Res Function(ApprovalRequestAddTip3Token) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? account = null,
    Object? details = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestAddTip3Token(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      details: null == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as TokenContractAsset,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<void>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get account {
    return $AddressCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenContractAssetCopyWith<$Res> get details {
    return $TokenContractAssetCopyWith<$Res>(_self.details, (value) {
      return _then(_self.copyWith(details: value));
    });
  }
}

/// @nodoc

class ApprovalRequestSignData implements ApprovalRequest {
  const ApprovalRequestSignData(
      {required this.origin,
      required this.account,
      required this.publicKey,
      required this.data,
      required this.signInputAuthLedger,
      required this.completer});

  @override
  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final String data;
  final SignInputAuthLedger signInputAuthLedger;
  @override
  final Completer<SignInputAuth> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestSignDataCopyWith<ApprovalRequestSignData> get copyWith =>
      _$ApprovalRequestSignDataCopyWithImpl<ApprovalRequestSignData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestSignData &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.signInputAuthLedger, signInputAuthLedger) ||
                other.signInputAuthLedger == signInputAuthLedger) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, account, publicKey, data,
      signInputAuthLedger, completer);

  @override
  String toString() {
    return 'ApprovalRequest.signData(origin: $origin, account: $account, publicKey: $publicKey, data: $data, signInputAuthLedger: $signInputAuthLedger, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestSignDataCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestSignDataCopyWith(ApprovalRequestSignData value,
          $Res Function(ApprovalRequestSignData) _then) =
      _$ApprovalRequestSignDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey publicKey,
      String data,
      SignInputAuthLedger signInputAuthLedger,
      Completer<SignInputAuth> completer});

  $AddressCopyWith<$Res> get account;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$ApprovalRequestSignDataCopyWithImpl<$Res>
    implements $ApprovalRequestSignDataCopyWith<$Res> {
  _$ApprovalRequestSignDataCopyWithImpl(this._self, this._then);

  final ApprovalRequestSignData _self;
  final $Res Function(ApprovalRequestSignData) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? account = null,
    Object? publicKey = null,
    Object? data = null,
    Object? signInputAuthLedger = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestSignData(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _self.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      signInputAuthLedger: null == signInputAuthLedger
          ? _self.signInputAuthLedger
          : signInputAuthLedger // ignore: cast_nullable_to_non_nullable
              as SignInputAuthLedger,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignInputAuth>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get account {
    return $AddressCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
      return _then(_self.copyWith(publicKey: value));
    });
  }
}

/// @nodoc

class ApprovalRequestEncryptData implements ApprovalRequest {
  const ApprovalRequestEncryptData(
      {required this.origin,
      required this.account,
      required this.publicKey,
      required this.data,
      required this.completer});

  @override
  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final String data;
  @override
  final Completer<SignInputAuth> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestEncryptDataCopyWith<ApprovalRequestEncryptData>
      get copyWith =>
          _$ApprovalRequestEncryptDataCopyWithImpl<ApprovalRequestEncryptData>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestEncryptData &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, origin, account, publicKey, data, completer);

  @override
  String toString() {
    return 'ApprovalRequest.encryptData(origin: $origin, account: $account, publicKey: $publicKey, data: $data, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestEncryptDataCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestEncryptDataCopyWith(ApprovalRequestEncryptData value,
          $Res Function(ApprovalRequestEncryptData) _then) =
      _$ApprovalRequestEncryptDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey publicKey,
      String data,
      Completer<SignInputAuth> completer});

  $AddressCopyWith<$Res> get account;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$ApprovalRequestEncryptDataCopyWithImpl<$Res>
    implements $ApprovalRequestEncryptDataCopyWith<$Res> {
  _$ApprovalRequestEncryptDataCopyWithImpl(this._self, this._then);

  final ApprovalRequestEncryptData _self;
  final $Res Function(ApprovalRequestEncryptData) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? account = null,
    Object? publicKey = null,
    Object? data = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestEncryptData(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _self.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignInputAuth>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get account {
    return $AddressCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
      return _then(_self.copyWith(publicKey: value));
    });
  }
}

/// @nodoc

class ApprovalRequestDecryptData implements ApprovalRequest {
  const ApprovalRequestDecryptData(
      {required this.origin,
      required this.account,
      required this.recipientPublicKey,
      required this.sourcePublicKey,
      required this.completer});

  @override
  final Uri origin;
  final Address account;
  final PublicKey recipientPublicKey;
  final PublicKey sourcePublicKey;
  @override
  final Completer<SignInputAuth> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestDecryptDataCopyWith<ApprovalRequestDecryptData>
      get copyWith =>
          _$ApprovalRequestDecryptDataCopyWithImpl<ApprovalRequestDecryptData>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestDecryptData &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.recipientPublicKey, recipientPublicKey) ||
                other.recipientPublicKey == recipientPublicKey) &&
            (identical(other.sourcePublicKey, sourcePublicKey) ||
                other.sourcePublicKey == sourcePublicKey) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, account,
      recipientPublicKey, sourcePublicKey, completer);

  @override
  String toString() {
    return 'ApprovalRequest.decryptData(origin: $origin, account: $account, recipientPublicKey: $recipientPublicKey, sourcePublicKey: $sourcePublicKey, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestDecryptDataCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestDecryptDataCopyWith(ApprovalRequestDecryptData value,
          $Res Function(ApprovalRequestDecryptData) _then) =
      _$ApprovalRequestDecryptDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey recipientPublicKey,
      PublicKey sourcePublicKey,
      Completer<SignInputAuth> completer});

  $AddressCopyWith<$Res> get account;
  $PublicKeyCopyWith<$Res> get recipientPublicKey;
  $PublicKeyCopyWith<$Res> get sourcePublicKey;
}

/// @nodoc
class _$ApprovalRequestDecryptDataCopyWithImpl<$Res>
    implements $ApprovalRequestDecryptDataCopyWith<$Res> {
  _$ApprovalRequestDecryptDataCopyWithImpl(this._self, this._then);

  final ApprovalRequestDecryptData _self;
  final $Res Function(ApprovalRequestDecryptData) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? account = null,
    Object? recipientPublicKey = null,
    Object? sourcePublicKey = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestDecryptData(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      recipientPublicKey: null == recipientPublicKey
          ? _self.recipientPublicKey
          : recipientPublicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      sourcePublicKey: null == sourcePublicKey
          ? _self.sourcePublicKey
          : sourcePublicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignInputAuth>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get account {
    return $AddressCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get recipientPublicKey {
    return $PublicKeyCopyWith<$Res>(_self.recipientPublicKey, (value) {
      return _then(_self.copyWith(recipientPublicKey: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get sourcePublicKey {
    return $PublicKeyCopyWith<$Res>(_self.sourcePublicKey, (value) {
      return _then(_self.copyWith(sourcePublicKey: value));
    });
  }
}

/// @nodoc

class ApprovalRequestCallContractMethod implements ApprovalRequest {
  const ApprovalRequestCallContractMethod(
      {required this.origin,
      required this.account,
      required this.publicKey,
      required this.recipient,
      required this.payload,
      required this.signInputAuthLedger,
      required this.completer});

  @override
  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final Address recipient;
  final FunctionCall payload;
  final SignInputAuthLedger signInputAuthLedger;
  @override
  final Completer<SignInputAuth> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestCallContractMethodCopyWith<ApprovalRequestCallContractMethod>
      get copyWith => _$ApprovalRequestCallContractMethodCopyWithImpl<
          ApprovalRequestCallContractMethod>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestCallContractMethod &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.signInputAuthLedger, signInputAuthLedger) ||
                other.signInputAuthLedger == signInputAuthLedger) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, account, publicKey,
      recipient, payload, signInputAuthLedger, completer);

  @override
  String toString() {
    return 'ApprovalRequest.callContractMethod(origin: $origin, account: $account, publicKey: $publicKey, recipient: $recipient, payload: $payload, signInputAuthLedger: $signInputAuthLedger, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestCallContractMethodCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestCallContractMethodCopyWith(
          ApprovalRequestCallContractMethod value,
          $Res Function(ApprovalRequestCallContractMethod) _then) =
      _$ApprovalRequestCallContractMethodCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey publicKey,
      Address recipient,
      FunctionCall payload,
      SignInputAuthLedger signInputAuthLedger,
      Completer<SignInputAuth> completer});

  $AddressCopyWith<$Res> get account;
  $PublicKeyCopyWith<$Res> get publicKey;
  $AddressCopyWith<$Res> get recipient;
  $FunctionCallCopyWith<$Res> get payload;
}

/// @nodoc
class _$ApprovalRequestCallContractMethodCopyWithImpl<$Res>
    implements $ApprovalRequestCallContractMethodCopyWith<$Res> {
  _$ApprovalRequestCallContractMethodCopyWithImpl(this._self, this._then);

  final ApprovalRequestCallContractMethod _self;
  final $Res Function(ApprovalRequestCallContractMethod) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? account = null,
    Object? publicKey = null,
    Object? recipient = null,
    Object? payload = null,
    Object? signInputAuthLedger = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestCallContractMethod(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _self.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      recipient: null == recipient
          ? _self.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as Address,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as FunctionCall,
      signInputAuthLedger: null == signInputAuthLedger
          ? _self.signInputAuthLedger
          : signInputAuthLedger // ignore: cast_nullable_to_non_nullable
              as SignInputAuthLedger,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignInputAuth>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get account {
    return $AddressCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
      return _then(_self.copyWith(publicKey: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get recipient {
    return $AddressCopyWith<$Res>(_self.recipient, (value) {
      return _then(_self.copyWith(recipient: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FunctionCallCopyWith<$Res> get payload {
    return $FunctionCallCopyWith<$Res>(_self.payload, (value) {
      return _then(_self.copyWith(payload: value));
    });
  }
}

/// @nodoc

class ApprovalRequestSendMessage implements ApprovalRequest {
  const ApprovalRequestSendMessage(
      {required this.origin,
      required this.sender,
      required this.recipient,
      @amountJsonConverter required this.amount,
      required this.bounce,
      required this.payload,
      required this.knownPayload,
      required final List<IgnoreTransactionTreeSimulationError>?
          ignoredComputePhaseCodes,
      required final List<IgnoreTransactionTreeSimulationError>?
          ignoredActionPhaseCodes,
      required this.completer})
      : _ignoredComputePhaseCodes = ignoredComputePhaseCodes,
        _ignoredActionPhaseCodes = ignoredActionPhaseCodes;

  @override
  final Uri origin;
  final Address sender;
  final Address recipient;
  @amountJsonConverter
  final BigInt amount;
  final bool bounce;
  final FunctionCall? payload;
  final KnownPayload? knownPayload;
  final List<IgnoreTransactionTreeSimulationError>? _ignoredComputePhaseCodes;
  List<IgnoreTransactionTreeSimulationError>? get ignoredComputePhaseCodes {
    final value = _ignoredComputePhaseCodes;
    if (value == null) return null;
    if (_ignoredComputePhaseCodes is EqualUnmodifiableListView)
      return _ignoredComputePhaseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<IgnoreTransactionTreeSimulationError>? _ignoredActionPhaseCodes;
  List<IgnoreTransactionTreeSimulationError>? get ignoredActionPhaseCodes {
    final value = _ignoredActionPhaseCodes;
    if (value == null) return null;
    if (_ignoredActionPhaseCodes is EqualUnmodifiableListView)
      return _ignoredActionPhaseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Completer<(PublicKey, SignInputAuth)> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestSendMessageCopyWith<ApprovalRequestSendMessage>
      get copyWith =>
          _$ApprovalRequestSendMessageCopyWithImpl<ApprovalRequestSendMessage>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestSendMessage &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bounce, bounce) || other.bounce == bounce) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.knownPayload, knownPayload) ||
                other.knownPayload == knownPayload) &&
            const DeepCollectionEquality().equals(
                other._ignoredComputePhaseCodes, _ignoredComputePhaseCodes) &&
            const DeepCollectionEquality().equals(
                other._ignoredActionPhaseCodes, _ignoredActionPhaseCodes) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      sender,
      recipient,
      amount,
      bounce,
      payload,
      knownPayload,
      const DeepCollectionEquality().hash(_ignoredComputePhaseCodes),
      const DeepCollectionEquality().hash(_ignoredActionPhaseCodes),
      completer);

  @override
  String toString() {
    return 'ApprovalRequest.sendMessage(origin: $origin, sender: $sender, recipient: $recipient, amount: $amount, bounce: $bounce, payload: $payload, knownPayload: $knownPayload, ignoredComputePhaseCodes: $ignoredComputePhaseCodes, ignoredActionPhaseCodes: $ignoredActionPhaseCodes, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestSendMessageCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestSendMessageCopyWith(ApprovalRequestSendMessage value,
          $Res Function(ApprovalRequestSendMessage) _then) =
      _$ApprovalRequestSendMessageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address sender,
      Address recipient,
      @amountJsonConverter BigInt amount,
      bool bounce,
      FunctionCall? payload,
      KnownPayload? knownPayload,
      List<IgnoreTransactionTreeSimulationError>? ignoredComputePhaseCodes,
      List<IgnoreTransactionTreeSimulationError>? ignoredActionPhaseCodes,
      Completer<(PublicKey, SignInputAuth)> completer});

  $AddressCopyWith<$Res> get sender;
  $AddressCopyWith<$Res> get recipient;
  $FunctionCallCopyWith<$Res>? get payload;
  $KnownPayloadCopyWith<$Res>? get knownPayload;
}

/// @nodoc
class _$ApprovalRequestSendMessageCopyWithImpl<$Res>
    implements $ApprovalRequestSendMessageCopyWith<$Res> {
  _$ApprovalRequestSendMessageCopyWithImpl(this._self, this._then);

  final ApprovalRequestSendMessage _self;
  final $Res Function(ApprovalRequestSendMessage) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? sender = null,
    Object? recipient = null,
    Object? amount = null,
    Object? bounce = null,
    Object? payload = freezed,
    Object? knownPayload = freezed,
    Object? ignoredComputePhaseCodes = freezed,
    Object? ignoredActionPhaseCodes = freezed,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestSendMessage(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Address,
      recipient: null == recipient
          ? _self.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      bounce: null == bounce
          ? _self.bounce
          : bounce // ignore: cast_nullable_to_non_nullable
              as bool,
      payload: freezed == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as FunctionCall?,
      knownPayload: freezed == knownPayload
          ? _self.knownPayload
          : knownPayload // ignore: cast_nullable_to_non_nullable
              as KnownPayload?,
      ignoredComputePhaseCodes: freezed == ignoredComputePhaseCodes
          ? _self._ignoredComputePhaseCodes
          : ignoredComputePhaseCodes // ignore: cast_nullable_to_non_nullable
              as List<IgnoreTransactionTreeSimulationError>?,
      ignoredActionPhaseCodes: freezed == ignoredActionPhaseCodes
          ? _self._ignoredActionPhaseCodes
          : ignoredActionPhaseCodes // ignore: cast_nullable_to_non_nullable
              as List<IgnoreTransactionTreeSimulationError>?,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<(PublicKey, SignInputAuth)>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get sender {
    return $AddressCopyWith<$Res>(_self.sender, (value) {
      return _then(_self.copyWith(sender: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get recipient {
    return $AddressCopyWith<$Res>(_self.recipient, (value) {
      return _then(_self.copyWith(recipient: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FunctionCallCopyWith<$Res>? get payload {
    if (_self.payload == null) {
      return null;
    }

    return $FunctionCallCopyWith<$Res>(_self.payload!, (value) {
      return _then(_self.copyWith(payload: value));
    });
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KnownPayloadCopyWith<$Res>? get knownPayload {
    if (_self.knownPayload == null) {
      return null;
    }

    return $KnownPayloadCopyWith<$Res>(_self.knownPayload!, (value) {
      return _then(_self.copyWith(knownPayload: value));
    });
  }
}

/// @nodoc

class ApprovalRequestChangeNetwork implements ApprovalRequest {
  const ApprovalRequestChangeNetwork(
      {required this.origin,
      required this.networkId,
      required final List<Connection> connections,
      required this.completer})
      : _connections = connections;

  @override
  final Uri origin;
  final int networkId;
  final List<Connection> _connections;
  List<Connection> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  @override
  final Completer<TransportStrategy?> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestChangeNetworkCopyWith<ApprovalRequestChangeNetwork>
      get copyWith => _$ApprovalRequestChangeNetworkCopyWithImpl<
          ApprovalRequestChangeNetwork>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestChangeNetwork &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.networkId, networkId) ||
                other.networkId == networkId) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, networkId,
      const DeepCollectionEquality().hash(_connections), completer);

  @override
  String toString() {
    return 'ApprovalRequest.changeNetwork(origin: $origin, networkId: $networkId, connections: $connections, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestChangeNetworkCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestChangeNetworkCopyWith(
          ApprovalRequestChangeNetwork value,
          $Res Function(ApprovalRequestChangeNetwork) _then) =
      _$ApprovalRequestChangeNetworkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      int networkId,
      List<Connection> connections,
      Completer<TransportStrategy?> completer});
}

/// @nodoc
class _$ApprovalRequestChangeNetworkCopyWithImpl<$Res>
    implements $ApprovalRequestChangeNetworkCopyWith<$Res> {
  _$ApprovalRequestChangeNetworkCopyWithImpl(this._self, this._then);

  final ApprovalRequestChangeNetwork _self;
  final $Res Function(ApprovalRequestChangeNetwork) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? networkId = null,
    Object? connections = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestChangeNetwork(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      networkId: null == networkId
          ? _self.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as int,
      connections: null == connections
          ? _self._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<TransportStrategy?>,
    ));
  }
}

/// @nodoc

class ApprovalRequestAddNetwork implements ApprovalRequest {
  const ApprovalRequestAddNetwork(
      {required this.origin,
      required this.network,
      required this.switchNetwork,
      required this.completer});

  @override
  final Uri origin;
  final AddNetwork network;
  final bool switchNetwork;
  @override
  final Completer<Network?> completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApprovalRequestAddNetworkCopyWith<ApprovalRequestAddNetwork> get copyWith =>
      _$ApprovalRequestAddNetworkCopyWithImpl<ApprovalRequestAddNetwork>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApprovalRequestAddNetwork &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.switchNetwork, switchNetwork) ||
                other.switchNetwork == switchNetwork) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, origin, network, switchNetwork, completer);

  @override
  String toString() {
    return 'ApprovalRequest.addNetwork(origin: $origin, network: $network, switchNetwork: $switchNetwork, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $ApprovalRequestAddNetworkCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestAddNetworkCopyWith(ApprovalRequestAddNetwork value,
          $Res Function(ApprovalRequestAddNetwork) _then) =
      _$ApprovalRequestAddNetworkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Uri origin,
      AddNetwork network,
      bool switchNetwork,
      Completer<Network?> completer});
}

/// @nodoc
class _$ApprovalRequestAddNetworkCopyWithImpl<$Res>
    implements $ApprovalRequestAddNetworkCopyWith<$Res> {
  _$ApprovalRequestAddNetworkCopyWithImpl(this._self, this._then);

  final ApprovalRequestAddNetwork _self;
  final $Res Function(ApprovalRequestAddNetwork) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? network = null,
    Object? switchNetwork = null,
    Object? completer = null,
  }) {
    return _then(ApprovalRequestAddNetwork(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      network: null == network
          ? _self.network
          : network // ignore: cast_nullable_to_non_nullable
              as AddNetwork,
      switchNetwork: null == switchNetwork
          ? _self.switchNetwork
          : switchNetwork // ignore: cast_nullable_to_non_nullable
              as bool,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<Network?>,
    ));
  }
}

// dart format on
