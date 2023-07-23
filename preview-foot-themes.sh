#!/bin/sh
#    preview-foot-themes.sh - Easily preview foot terminal themes via fzf + exa + neofetch
#
#    Copyright (C) 2023  James Cuzella
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd )"
theme_dir=${1:-/usr/share/foot/themes/}

_nl='
'

while IFS="$_nl" read -r line; do
  pane_help_text="${pane_help_text}${line}${_nl}"
done <<EOHELP
Press...
  Tab to preview
  ctrl-i to turn on  auto-preview
  ctrl-o to turn OFF auto-preview
  ctrl-/ to toggle preview pane
EOHELP

while IFS="$_nl" read -r line; do
  short_help_text="${short_help_text}${line}${_nl}"
done <<EOSHORT
tab = Preview
ctrl-/ = Toggle Preview: on,hidden
ctrl-i = auto-preview on
ctrl-o = auto-preview OFF
? = help
EOSHORT

while IFS="$_nl" read -r line; do
  change_help_text="${change_help_text}${line}${_nl}"
done <<EOCHANGEHELP
Stopped launching previews due to typing query...
? = help
EOCHANGEHELP

find "${theme_dir}" -type f -print0 | \
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
