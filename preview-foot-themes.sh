#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
theme_dir=${1:-/usr/share/foot/themes/}

read -r -d '' pane_help_text <<EOHELP
Press...
  Tab to preview
  ctrl-i to turn on  auto-preview
  ctrl-o to turn OFF auto-preview
  ctrl-/ to toggle preview pane
EOHELP

read -r -d '' short_help_text <<EOSHORT
tab = Preview
ctrl-/ = Toggle Preview: on,hidden
ctrl-i = auto-preview on
ctrl-o = auto-preview OFF
? = help
EOSHORT

read -r -d '' change_help_text <<EOCHANGEHELP
Stopped launching previews due to typing query...
? = help
EOCHANGEHELP

find ${theme_dir} -type f -print0 | \
  fzf --read0 --preview-window right,30%,border-rounded --preview="echo -e '$pane_help_text'" \
    --prompt ' > ' \
    --bind 'load:+change-prompt: > ' \
    --bind "change:hide-preview+change-header($change_help_text)" \
    --bind "tab:preview(${SCRIPT_DIR}/launch-theme.sh {})+unbind(focus)" \
    --bind 'start:unbind(focus)' \
    --bind "ctrl-i:+rebind(focus)+change-preview(${SCRIPT_DIR}/launch-theme.sh {})" \
    --bind 'ctrl-o:+unbind(focus)+change-preview()' \
    --bind 'ctrl-/:+change-preview-window(hidden|)' \
    --bind 'ctrl-/:+refresh-preview' \
    --bind "?:change-header($short_help_text)" \
    --bind 'focus:refresh-preview+transform-preview-label:echo ▶ Viewing: {} ◀;' \
    --color 'fg:#999999,fg+:#ccd7d4,bg:#1b2224,gutter:#1b2224,preview-bg:#141a1b,border:#707a7a,scrollbar:#2eb398,pointer:#ac3562,hl:#ac74f9,query:#ccd7d4,prompt:#45ff82,marker:#ac3562,preview-label:#2eb398,preview-border:#2eb398,hl+:#b07aff,header:#45ff82,separator:#697521'
