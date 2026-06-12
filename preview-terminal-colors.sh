#!/bin/sh
SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd )"
FETCHER=${PREVIEW_FOOT_FETCHER:-neofetch}

exa --icons --color-scale --classify -lah --tree "$SCRIPT_DIR/foot-theme-demo/"
if ! command -v "$FETCHER" ; then
  if command -v fastfetch ; then
    fastfetch --config neofetch
  elif command -v screenfetch ; then
    screenfetch
  fi
else
  $FETCHER
fi

sleep "${1:-3}"
