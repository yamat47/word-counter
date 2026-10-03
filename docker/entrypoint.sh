#!/bin/sh
set -eu

# node_modules lives in a volume that outlasts the image, so it is synced with
# the lockfile on every start instead of at image build time.
pnpm install

exec "$@"
