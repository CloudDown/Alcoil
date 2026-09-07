#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if git ls-files | grep -Ei '\.(exe|dll|bin)$'; then
  echo "binaries should not be tracked" >&2
  exit 1
fi
echo ok
