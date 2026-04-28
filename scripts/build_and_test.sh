#!/bin/bash

set -e

melos decrypt-secrets

# Run format check and show diff if any files were changed
echo "Running format check..."
if ! melos run check-format --no-select; then
  echo "❌ Format check failed. Showing diff of what needs to be formatted:"
  git diff
  exit 1
fi

# melos run codegen --no-select // disabled due to CI time consumption, should be run locally before pushing changes
melos run analyze --no-select
melos run test --no-select
