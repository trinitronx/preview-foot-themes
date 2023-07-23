#!/bin/sh
SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd )"

exa --icons --color-scale --classify -lah --tree "$SCRIPT_DIR/foot-theme-demo/"
neofetch
sleep "${1:-3}"
