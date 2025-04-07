// JS Bridge constants
const tonConnectJsHandlerName = 'sparxTonConnectWebviewHandler';
const tonConnectJsBridgeKey = 'sparx';

// HTTP Bridge settings
const tonConnectBackoffInitialDuration = Duration(seconds: 2);
const tonConnectBackoffMultiplier = 2.0;
const tonConnectBackoffMaxAttempts = 6; // 2^6 = 64 seconds
const tonConnectMessageDefaultTtl = 300;
const tonConnectHttpBridgeSendRetries = 2;
const tonConnectHttpBridgeUrl =
    'https://ton-connect-bridge.sparxwallet.com/bridge'; // https://bridge.tonapi.io/bridge
