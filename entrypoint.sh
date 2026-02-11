#!/bin/sh
set -e

# DB が存在する場合のみマイグレーション
if [ -f db/schema.rb ] || [ -d db/migrate ]; then
  bin/rails db:prepare 2>/dev/null || true
fi

exec "$@"
