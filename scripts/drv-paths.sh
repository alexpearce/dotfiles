#!/usr/bin/env bash
# Print the derivation path of every host's top-level build.
#
# Save the output before a refactor and compare after: identical paths mean
# identical systems. For differing paths, `scripts/drvdiff.py OLD NEW` shows
# what changed.
set -euo pipefail
cd "$(dirname "$0")/.."
nix eval --no-warn-dirty --json .#checks \
  --apply 'builtins.mapAttrs (_: builtins.mapAttrs (_: drv: drv.drvPath))' 2>/dev/null |
  jq -r 'to_entries[] | .value | to_entries[] | "\(.key) \(.value)"' | sort
