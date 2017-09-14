#!/bin/sh
set -e
CRAVE_DATA=/home/crave/.crave
cd /home/crave/craved

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for craved"

  set -- craved "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "craved" ]; then
  mkdir -p "$CRAVE_DATA"
  chmod 700 "$CRAVE_DATA"
  chown -R crave "$CRAVE_DATA"

  echo "$0: setting data directory to $CRAVE_DATA"

  set -- "$@" -datadir="$CRAVE_DATA"
fi

if [ "$1" = "craved" ] || [ "$1" = "crave-cli" ] || [ "$1" = "crave-tx" ]; then
  echo
  exec gosu crave "$@"
fi

echo
exec "$@"
