#!/bin/sh
SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd )"
FETCHER=${PREVIEW_FOOT_FETCHER:-neofetch}

print_16_colors() {
    INDENT="${1:-0}"
    for j in $(seq 1 "$INDENT"); do
      printf " "
    done
    for i in $(seq 0 15); do
        # Prints each foreground color number in its respective foreground color, then resets to avoid bleeding
        printf "\033[48;5;%dm%3s\033[0m" "$i" " "
        # New line every 8 colors
        if [ "$(((i + 1) % 8))" -eq 0 ]; then
            echo ""
            for j in $(seq 1 "$INDENT"); do
              printf " "
            done
        fi
    done
    echo ""
}

exa --icons --color-scale --classify -lah --tree "$SCRIPT_DIR/foot-theme-demo/"
if ! command -v "$FETCHER" >/dev/null 2>&1 ; then
  if command -v fastfetch  >/dev/null 2>&1 ; then
    fastfetch --config neofetch
  elif command -v macchina  >/dev/null 2>&1 ; then
    macchina --theme=Helium
    print_16_colors '24'
  elif command -v screenfetch  >/dev/null 2>&1 ; then
    screenfetch
    print_16_colors '34'
  else
    echo ""
    print_16_colors '0'
  fi
else
  $FETCHER
fi

sleep "${1:-3}"
