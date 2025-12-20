#!/usr/bin/env bash
set -euo pipefail

# Startup helper: delegate to the more robust profile applier (retries + logging).
sleep 1
~/.config/hypr/scripts/apply-display-profile.sh --reason startup || true
