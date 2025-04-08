#!/bin/bash
set -e
set -o pipefail

if [[ "$BUILD_MODE" == "debug" ]]; then
  echo "🍿🎢🤖 Deploy DEBUG APK for FAD with flavor: $FLAVOR"
  # Passing build mode to the fastlane script so it can find the correct APK path
  cd android
  fastlane android deploy_fad flavor:"$FLAVOR" build_mode:"debug"
  cd ..
else
  echo "🍿🎢🤖 Deploy RELEASE APK for FAD with flavor: $FLAVOR"
  cd android
  fastlane android deploy_fad flavor:"$FLAVOR"
  cd ..
fi
