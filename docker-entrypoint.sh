#!/bin/bash

set -e

CRAVE_DATA=/home/crave/.crave
CONFIG_FILE=crave.conf

if [ -z "$1" ] || [ "$1" == "craved" ] || [ "$(echo "$1" | cut -c1)" == "-" ]; then
  cmd=craved
  shift

  if [ ! -d $CRAVE_DATA ]; then
    echo "$0: DATA DIR ($CRAVE_DATA) not found, please create and add config.  exiting...."
    exit 1
  fi

  if [ ! -f $CRAVE_DATA/$CONFIG_FILE ]; then
    echo "$0: craved config ($CRAVE_DATA/$CONFIG_FILE) not found, please create.  exiting...."
    exit 1
  fi

  chmod 700 "$CRAVE_DATA"
  chown -R crave "$CRAVE_DATA"

  if [ -z "$1" ] || [ "$(echo "$1" | cut -c1)" == "-" ]; then
    echo "$0: assuming arguments for craved"

    set -- $cmd "$@" -datadir="$CRAVE_DATA"
  else
    set -- $cmd -datadir="$CRAVE_DATA"
  fi

  exec gosu crave "$@"
else
  echo "This entrypoint will only execute craved, crave-cli and crave-tx"
fi
