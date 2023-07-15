#!/usr/bin/zsh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

exa --icons --color-scale --classify -lah --tree $SCRIPT_DIR/foot-theme-demo/
neofetch
sleep ${1:-3}
