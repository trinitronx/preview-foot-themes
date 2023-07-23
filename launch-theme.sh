#!/bin/sh
SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd )"
preview_seconds=5

# Cleanup on exit
cleanup() {
  kill_foot_preview
  [ -d "$TMP_DIR" ] && rm -rf "$TMP_DIR" 1>/dev/null 2>&1
}

# Kill foot preview PID
kill_foot_preview() {
  if [ -n "$foot_pid" ]; then
    echo "Killing $foot_pid due to trap"
    kill -TERM "$foot_pid" 1>/dev/null 2>&1
  fi
}
trap cleanup EXIT HUP TSTP QUIT SEGV TERM INT ABRT  # trap all common terminate signals

# Replace the include theme line
TMP_DIR=$(mktemp -d /tmp/preview-foot-theme.XXXXXXXXXX)
tmp_foot_ini=$TMP_DIR/foot.ini
cp ~/.config/foot/foot.ini "$tmp_foot_ini"
sed -i -e "s#^include=.*#include=${1}#" "$tmp_foot_ini"
sync "$tmp_foot_ini"

foot --config "$tmp_foot_ini" -L "${SHELL:-sh}" "$SCRIPT_DIR/preview-terminal-colors.sh" $preview_seconds &
foot_pid=$!

# Wait 300ms for foot to read config, then immediately remove tmpfile
sleep 0.3
# Must be <= previewDelayed in fzf (Default: 500ms) to avoid leaking tmpfiles
rm -rf "$TMP_DIR" 1>/dev/null 2>&1

for i in $(seq $preview_seconds -1 0); do
  printf "\033[2J"
  echo "Previewing foot theme for: "
  echo " $i more seconds..."
  sleep 1
done
