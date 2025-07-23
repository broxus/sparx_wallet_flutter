enum LedgerInteractionType {
  getPublicKey,
  getAddress(needsConfirmation: true),
  sign(needsConfirmation: true),
  signTransaction(needsConfirmation: true);

  const LedgerInteractionType({
    this.needsConfirmation = false,
  });

  final bool needsConfirmation;
}
