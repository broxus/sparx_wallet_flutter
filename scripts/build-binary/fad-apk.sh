#!/bin/bash
set -e
set -o pipefail

if [[ "$BUILD_MODE" == "debug" ]]; then
  echo "🍿🏗️🤖 Build DEBUG APK for FAD with flavor $FLAVOR, target $TARGET_FILE"
  flutter build apk --debug $BUILD_NUMBER_STRING --flavor $FLAVOR --target $TARGET_FILE --dart-define=SENTRY_DSN=$SENTRY_DSN
else
  echo "🍿🏗️🤖 Build RELEASE APK for FAD with flavor $FLAVOR, target $TARGET_FILE"
  flutter build apk $BUILD_NUMBER_STRING --flavor $FLAVOR --target $TARGET_FILE --dart-define=SENTRY_DSN=$SENTRY_DSN
fi
