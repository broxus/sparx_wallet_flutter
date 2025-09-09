enum ApduIns {
  openApp(0xd8),
  getApp(0x01),
  getConf(0x01),
  getPk(0x02),
  sign(0x03),
  getAddr(0x04),
  signTransaction(0x05);

  const ApduIns(this.byte);

  final int byte;
}
