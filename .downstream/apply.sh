#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

required_files=(
  "$SCRIPT_DIR/workflows/docker-publish.yml"
  "$SCRIPT_DIR/workflows/sync-upstream.yml"
  "$SCRIPT_DIR/docker-compose.fork.yml"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    printf 'Required downstream overlay file is missing: %s\n' "$file" >&2
    exit 1
  fi
done

mkdir -p "$ROOT_DIR/.github/workflows"
cp "$SCRIPT_DIR/workflows/docker-publish.yml" "$ROOT_DIR/.github/workflows/docker-publish.yml"
cp "$SCRIPT_DIR/workflows/sync-upstream.yml" "$ROOT_DIR/.github/workflows/sync-upstream.yml"
cp "$SCRIPT_DIR/docker-compose.fork.yml" "$ROOT_DIR/docker-compose.fork.yml"

for workflow in \
  docker-unstable.yml \
  build.yml \
  helm-chart.yml \
  lint.yml \
  release.yml \
  stale.yml \
  sync-model-developers.yml \
  test.yml; do
  rm -f "$ROOT_DIR/.github/workflows/$workflow"
done
