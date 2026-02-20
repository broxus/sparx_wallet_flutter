import 'package:app/feature/ledger/ledger.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

void main() {
  group('LedgerAppInterface.buildSignTransactionPayload', () {
    const baseContext = LedgerSignatureContext(decimals: 9, asset: 'EVER');
    const baseMessage = <int>[0x00, 0x01, 0x02, 0x03, 0xAA, 0xBB];

    test('encodes signatureId mode and big-endian globalId', () {
      const signatureContext = SignatureContext(
        globalId: 0x11223344,
        signatureType: SignatureType.signatureId,
      );

      final payload = LedgerAppInterface.buildSignTransactionPayload(
        accountId: 0x01020304,
        wallet: 0x05,
        originalWallet: 0x05,
        message: baseMessage,
        context: baseContext,
        signatureContext: signatureContext,
      );

      expect(
        payload,
        equals(<int>[
          0x01,
          0x02,
          0x03,
          0x04, // account id
          0x05, // original wallet
          0x09, // decimals
          0x04, // ticker length
          0x45,
          0x56,
          0x45,
          0x52, // EVER
          0x08, // mode: signatureId (1 << 3)
          0x11,
          0x22,
          0x33,
          0x44, // globalId big-endian
          0xAA,
          0xBB, // message tail
        ]),
      );
    });

    test('encodes signatureDomain mode and little-endian globalId', () {
      const signatureContext = SignatureContext(
        globalId: 0x11223344,
        signatureType: SignatureType.signatureDomain,
      );

      final payload = LedgerAppInterface.buildSignTransactionPayload(
        accountId: 0x01020304,
        wallet: 0x05,
        originalWallet: 0x05,
        message: baseMessage,
        context: baseContext,
        signatureContext: signatureContext,
      );

      expect(
        payload,
        equals(<int>[
          0x01,
          0x02,
          0x03,
          0x04, // account id
          0x05, // original wallet
          0x09, // decimals
          0x04, // ticker length
          0x45,
          0x56,
          0x45,
          0x52, // EVER
          0x10, // mode: signatureDomain (2 << 3)
          0x44,
          0x33,
          0x22,
          0x11, // globalId little-endian
          0xAA,
          0xBB, // message tail
        ]),
      );
    });

    test('encodes empty mode without globalId bytes', () {
      const signatureContext = SignatureContext(
        signatureType: SignatureType.empty,
      );

      final payload = LedgerAppInterface.buildSignTransactionPayload(
        accountId: 0x01020304,
        wallet: 0x05,
        originalWallet: 0x05,
        message: baseMessage,
        context: baseContext,
        signatureContext: signatureContext,
      );

      expect(
        payload,
        equals(<int>[
          0x01,
          0x02,
          0x03,
          0x04, // account id
          0x05, // original wallet
          0x09, // decimals
          0x04, // ticker length
          0x45,
          0x56,
          0x45,
          0x52, // EVER
          0x00, // mode: empty
          0xAA,
          0xBB, // message tail
        ]),
      );
    });
  });
}
