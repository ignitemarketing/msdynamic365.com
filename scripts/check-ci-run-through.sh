#!/usr/bin/env bash
# Fails if any check step in a workflow can be skipped by an earlier failure.
# Setup steps (`uses:`) stay fail-fast; every `run:` step must carry
# `if: ${{ !cancelled() ... }}` so all checks report in one run.
# Usage: check-ci-run-through.sh <workflow.yml>
set -u
file="${1:?usage: check-ci-run-through.sh <workflow.yml>}"

awk '
  function flush() {
    if (name != "" && has_run && !has_cond) { print "step without if: !cancelled(): " name; bad++ }
    name = ""; has_run = 0; has_cond = 0
  }
  /^      - name:/ { flush(); name = $0; sub(/^      - name:[ ]*/, "", name); next }
  /^        run:/ { has_run = 1 }
  /^        if:.*!cancelled\(\)/ { has_cond = 1 }
  END { flush(); if (bad) exit 1 }
' "$file"
status=$?
if [ "$status" -ne 0 ]; then
  echo "::error::$file has check steps that an earlier failure would skip"
  exit 1
fi
echo "ok: every run step in $file runs after earlier failures"
