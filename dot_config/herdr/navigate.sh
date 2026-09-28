#!/bin/sh
# herdr version of the is_vim check in tmux.conf. config.toml binds ctrl+hjkl
# to this script.
# If the active pane runs vim or fzf, pass the key to it. vim moves between
# its splits and calls `herdr pane focus` at the edge (vim/plugin/herdr_navigator.vim).
# Otherwise move herdr focus.
#
# Usage: sh navigate.sh left|down|up|right

direction=$1
case $direction in
  left)  key=ctrl+h ;;
  down)  key=ctrl+j ;;
  up)    key=ctrl+k ;;
  right) key=ctrl+l ;;
  *) echo "usage: navigate.sh left|down|up|right" >&2; exit 2 ;;
esac

herdr=${HERDR_BIN_PATH:-herdr}
pane=$HERDR_ACTIVE_PANE_ID

# Same pattern as is_vim in tmux.conf
if "$herdr" pane process-info --pane "$pane" \
  | jq -e '[.result.process_info.foreground_processes[].name]
           | any(test("^g?(view|l?n?vim?x?|fzf)(diff)?$"; "i"))' >/dev/null; then
  "$herdr" pane send-keys "$pane" "$key" >/dev/null
else
  "$herdr" pane focus --pane "$pane" --direction "$direction" >/dev/null
fi
