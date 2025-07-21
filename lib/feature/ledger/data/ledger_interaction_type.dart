enum LedgerInteractionType {
  getPublicKey,
  sign(needsConfirmation: true),
  signTransaction(needsConfirmation: true);

  const LedgerInteractionType({
    this.needsConfirmation = false,
  });

  final bool needsConfirmation;
}
