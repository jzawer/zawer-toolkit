#!/usr/bin/env bash
# Validates the marketplace and every plugin in it.
set -euo pipefail
cd "$(dirname "$0")/.."

status=0
echo "== marketplace"
claude plugin validate . || status=1

for dir in plugins/*/; do
  echo "== ${dir%/}"
  claude plugin validate "$dir" || status=1
done

exit $status
