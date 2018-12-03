#!/usr/bin/env bash

set -e

# ensure db
db3=/data/wallet.db3
[ ! -f $db3 ] && {
  mkdir -p /data
  sqlite3 $db3 -init /root/rpchub/schema/schema.sql .exit
  sqlite3 $db3 -init /root/rpchub/schema/triggers.sqlite3.sql .exit
}

exec /root/rpchub/bazel-bin/hub/hub --dbType sqlite3 --db /data/wallet.db3 --salt rJ8067pkJ4QvIuB7f7tZd $@
